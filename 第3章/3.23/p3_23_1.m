%
% 3.23 如何使用FIR滤波器设计数字微分器
% 
clc,clear,close all


%% 初始条件
N = 33; % 滤波器长度

% 数字微分器频响特点
f = 0:0.05:0.95; % 频点
A = f*pi; % 幅值

b = firpm(N,f,A,'differentiator'); % 微分器

[H,W] = freqz(b,1); % 幅频响应
h = impz(b,1,N); % 冲击响应


%% 绘图
subplot 211
plot(W/pi,abs(H)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 212
stem(h);
title('冲击响应曲线');xlabel('样点'); ylabel('幅值');
grid;





