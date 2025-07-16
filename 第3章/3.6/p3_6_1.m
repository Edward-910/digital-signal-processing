%
% 3.6 为什么不能用impinvar函数
% 使用脉冲响应不变法，在奈奎斯特频率附近会产生混叠，且由于模拟滤波器选择不合理会导致阻带衰减不够
% 因此应选择双线性变换法和陡峭的高阶椭圆滤波器
% 
clc,clear,close all


%% 初始条件
[y,fs] = audioread('San2.wav'); % 采样频率
fp = 3400; % 通带频率
fw = 3700; % 带阻频率
Rp = 0.8; % 通带波纹
Rs = 50; % 阻带波纹

wp = 2*pi*fp/fs; % 通带角频率
ws = 2*pi*fw/fs; % 阻带角频率

w = 0:0.01:2; % 频点设置
t = 0:0.1:3; % 时间序列

N = length(y); % 信号长度
n = 0:1:N-1; % 索引
ts = n/fs; % 时间序列


%% 处理
Wp1 = 2*fs*tan(wp/2); % 通带数字角频率
Ws1 = 2*fs*tan(ws/2); % 阻带数字角频率
[n,wn] = ellipord(Wp1,Ws1,Rp,Rs,'s'); % 椭圆滤波器参数计算
[b,a] = ellip(n,Rp,Rs,wn,'low','s'); % 椭圆滤波器设计
[bz,az] = bilinear(b,a,fs); % 双线性变换法

x = filter(bz,az,y); % 滤波

% 滤波前后频谱
[W1,Y] = plotfft(y,fs);
[W2,X] = plotfft(x,fs);
% 滤波器幅频响应曲线
[H,f] = freqz(bz,az,1000,fs);


%% 绘图
subplot 221
plot(ts,y);
title('原信号');xlabel('t(s)'); ylabel('幅值');
grid;
subplot 222
plot(ts,x);
title('滤波后信号');xlabel('t(s)'); ylabel('幅值');
grid;
subplot 223
plot(W1,Y);
title('原信号频谱');xlabel('频率(Hz)'); ylabel('幅值');
grid;
subplot 224
plot(W2,X);
title('滤波后信号频谱');xlabel('频率(Hz)'); ylabel('幅值');
grid;

figure;
plot(f,20*log10(H));
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;
axis([0 4000  -80 10]);
