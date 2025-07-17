%
% 3.11 滤波函数filter中zi、zf有何作用
% 
% [y,zf] = filter(a,b,x,zi);
% zi:初始条件
% zf:下一阶段初始条件
% zi、zf用于滤波过程中信号分段问题的处理
% 初始条件zi长度必须为 max(length(a),length(b))-1
% 
clc,clear,close all


%% 初始条件
f0 = 50; % 基频频率
fs = 1600; % 采样频率
N = 800; % 信号长度
n = 0:N-1; % 序列
t = n/fs; % 时间序列
fp = [40 60]; % 通带频率
fw = [30 80]; % 阻带频率
Rp = 1; % 通带波纹
Rs = 40; % 阻带波纹

% 生成信号
x = zeros(1,N);
for i = 1:2:10
    x = x + 10/(pi*i) * sin(i*2*pi*f0*t);
end


%% 处理
wp = fp*2/fs; % 通带角频率
ws = fw*2/fs; % 阻带角频率
[nw,wn] = ellipord(wp,ws,Rp,Rs); % 椭圆滤波器参数计算
[b,a] = ellip(nw,Rp,Rs,wn,'bandpass'); % 椭圆滤波器设计

[A,W] = freqz(b,a,1000,fs); % 幅频响应曲线

x1 = x(1:N/2); % 信号第一段
x2 = x(N/2+1:end); % 信号第二段

% 情况1
y1 = filter(b,a,x1); % 信号第一段滤波
y2 = filter(b,a,x2); % 信号第二段滤波
ya = [y1 y2]; % 直接进行滤波

% 情况2
zi = zeros(max(length(a),length(b))-1,1); % filter函数中zi定义长度
[y1,zf] = filter(b,a,x1,zi); % 信号第一段滤波
zi = zf; % 初始条件连接
[y2,zf] = filter(b,a,x2,zi); % 信号第二段滤波

yb = [y1 y2]; % 直接进行滤波


%% 绘图
subplot 311
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;
axis([0 120 -30 5])

subplot 312
plot(t,ya); % 情况1
title('信号波形');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 313
plot(t,yb); % 情况2
title('信号波形');xlabel('时间(s)'); ylabel('幅值');
grid;





