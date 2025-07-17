%
% 3.10 把滤波器的滤波过程用差分方程的运算来完成
% 
% 生成椭圆形滤波器处理该问题
% 
clc,clear,close all


%% 初始条件
f0 = 50; % 基频频率
fs = 1600; % 采样频率
N = 400; % 信号长度
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

y = filter(b,a,x); % 滤波


%% 绘图
subplot 311
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;
axis([0 120 -30 5])

subplot 312
plot(t,x); % 原信号
title('信号波形');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 313
plot(t,y); % 滤波后信号
title('信号波形');xlabel('时间(s)'); ylabel('幅值');
grid;






