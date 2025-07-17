%
% 3.8 使用bilinear函数时，如果Wp和Ws没进行预畸变会有什么结果
% 
% W = (2/T)*tan(w/2),所以当w/2较小时，W ≈ w/T，当T = 1时，W ≈ w，因此可能影响较小
% 当w->pi时w/2->pi/2,此时影响较大
% 
clc,clear,close all


%% 初始条件 
fs = 1000; % 采样频率 
fp = [100 200]; % 通带频率
fw = [20 250]; % 阻带频率
Rp = 2; % 通带频率
Rs = 40; % 阻带频率

w = 0:0.01:2; % 频点设置


%% 处理
wp = fp*2*pi/fs; % 通带角频率
ws = fw*2*pi/fs; % 阻带角频率
% 1.预畸变
Wp1 = 2*fs*tan(wp/2); % 通带角频率预畸变
Ws1 = 2*fs*tan(ws/2); % 阻带角频率预畸变
[n1,Wn1] = cheb2ord(Wp1,Ws1,Rp,Rs,'s'); % 切比雪夫滤波器参数计算
[b1,a1] = cheby2(n1,Rs,Wn1,'bandpass','s'); % 切比雪夫滤波器设计
[bz1,az1] = bilinear(b1,a1,fs); % 双线性变换法

% 2.不预畸变
Wp2 = fp*2*pi; % 通带角频率
Ws2 = fw*2*pi; % 阻带角频率
[n2,Wn2] = cheb2ord(Wp2,Ws2,Rp,Rs,'s'); % 切比雪夫滤波器参数计算
[b2,a2] = cheby2(n2,Rs,Wn2,'bandpass','s'); % 切比雪夫滤波器设计
[bz2,az2] = bilinear(b2,a2,fs); % 双线性变换法

% 频率响应
[A1,W1] = freqz(bz1,az1,1000,fs); % 巴特沃斯数字滤波器频率响应
[A2,W2] = freqz(bz2,az2,1000,fs); % 巴特沃斯数字滤波器频率响应
[A3,W3] = freqs(b1,a1); % 巴特沃斯模拟滤波器频率响应
[A4,W4] = freqs(b2,a2); % 巴特沃斯模拟滤波器频率响应


%% 绘图
plot(W1,20*log10(A1),'r','LineWidth',2); % 方案一
hold on
plot(W2,20*log10(A2),'k'); % 方案二
plot(W3/2/pi,20*log10(A3),'b','LineWidth',2); % 方案一
plot(W4/2/pi,20*log10(A4),'g'); % 方案二
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
legend('数字预畸变曲线','数字不预畸变曲线','模拟预畸变曲线','模拟不预畸变曲线');
grid;
xlim([0 300]);
ylim([-50 10]);

% 
% [A3,W3] = freqs(b1,a1);  巴特沃斯模拟滤波器频率响应
% 使用时注意W3输出为角频率
% 













