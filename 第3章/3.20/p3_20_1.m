%
% 3.20 通过fir2函数设计任意响应滤波器
% 
% 1.频率采样法设计FIR滤波器
% B = fir2(n,f,a,window);
% B:滤波器输出
% n:滤波器阶数
% f:频点值
% a:对应频点幅值
% window:窗函数,默认使用海明窗
% 
clc,clear,close all


%% 初始条件
fs = 2000; % 采样频率
F = [0 150 250 350 500 600 700 800 fs/2]; % 频点
f = F*2/fs; % 归一化频点
a = [0 1 1 0.5 0.5 0.25 0.25 0 0]; % 频点对应幅值


%% 处理
delta_f = (F(4) - F(3))*2*pi/fs; % 计算过渡带带宽
filN = ceil(11*pi/min(delta_f)); % 计算滤波器阶数
filN = filN + mod(filN,2); % 保证滤波器阶数为偶数
M = filN+1; % 窗长
w = blackman(M)'; % 布莱克曼窗
B = fir2(filN,f,a,w); % 滤波器设计
[A,W] = freqz(B,1,1000,fs); % 幅频响应


%% 绘图
subplot 211
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 212
plot(W,abs(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值');
grid;


%
% fir2函数使用归一化频点
%










