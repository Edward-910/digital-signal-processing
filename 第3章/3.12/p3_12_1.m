%
% 3.12 如何使用数字陷波器滤除工频信号
% 
% 1.数字陷波器设计
% [b,a] = iirnotch[Wo,Bw];
% Wo:数字陷波器中心频率
% Bw:数字陷波器带宽
% 
clc,clear,close all


%% 初始条件
load noisyecg.mat

N = length(noisyecg); % 信号长度
n = 0:N-1; % 索引
t = n/fs; % 时间序列
f0 = 50; % 工频信号
Wo = f0*2/fs; % 归一化角频率
Bw = 0.1; % 带宽
[b,a] = iirnotch(Wo,Bw); % 数字陷波器设计


%% 处理
[A,W] = freqz(b,a,1000,fs); % 幅频响应曲线

y = filter(b,a,noisyecg); % 滤波


%% 绘图
subplot 311
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;
axis([0 120 -30 5])

subplot 312
plot(t,noisyecg); % 原信号
title('信号波形');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 313
plot(t,y); % 滤波后信号
title('滤波后信号波形');xlabel('时间(s)'); ylabel('幅值');
grid;

%
% Wo、Bw使用归一化频率
% 





