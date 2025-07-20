%
% 3.19 通过FIR滤波器的输出,延迟量如何矫正
% 通过群延迟计算延迟量进行修正,在时间域上消除(N-1)/2个样点进行延迟量矫正
% 
clc,clear,close all


%% 初始条件
fs = 100; % 采样频率
N = 100; % 点数
n = 0:N-1; % 索引
t = n/fs; % 时间序列
fp = 10; % 通带频率
fw = 15; % 阻带频率
Rp = 3; % 通带波纹
Rs = 60; % 阻带波纹
wp = fp*2*pi/fs; % 通带角频率
ws = fw*2*pi/fs; % 阻带角频率
delta_f = abs(ws - wp); % 计算过渡带宽度
f1 = 5; % 信号频率1
f2 = 20; % 信号频率2
seta1 = pi/4; % 初始相位1
seta2 = pi/3; % 初始相位2

x = cos(2*pi*f1*t + seta1) + cos(2*pi*f2*t + seta2); % 信号


%% 处理
Wn = (fw + fp)/fs; % 截止频率计算 
filN = ceil(11*pi/min(delta_f)); % 计算滤波器阶数
filN = filN + mod(filN,2); % 保证滤波器阶数为偶数
M = filN+1; % 窗长
w = blackman(M)'; % 布莱克曼窗
B = fir1(filN,Wn,'low',w); % 滤波器设计
[A,W] = freqz(B,1,1000,fs); % 幅频响应

% 情况1
y1 = filter(B,1,x); % 滤波

% 情况2
y2 = conv(B,x); % 卷积
y2 = y2(filN/2:filN/2+N-1); % 消去延迟量


%% 绘图
subplot 311
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 312
plot(t,y1);
title('直接滤波后信号');xlabel('时间(s)');  ylabel('幅值')
grid;

subplot 313
plot(t,y2);
title('消去延迟量后信号');xlabel('时间(s)');  ylabel('幅值')
grid;

%
% 通过群延迟计算延迟量进行修正,在时间域上消除(N-1)/2个样点进行延迟量矫正
%









