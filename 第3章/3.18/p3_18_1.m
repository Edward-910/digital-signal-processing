%
% 3.18 为什么FIR滤波器不适合设计数字陷波器
% 过渡带宽 Δf = dw/N,由于数字陷波器幅频响应特点,dw固定,Δf越小,滤波器阶数N越大,不适用于设计数字陷波器
% 
clc,clear,close all


%% 初始条件
fs = 250; % 采样频率
fp = [45 55]; % 通带频率
fw = [49 51]; % 阻带频率
Rs = 20; % 阻带波纹
wp = fp*2*pi/fs; % 通带角频率
ws = fw*2*pi/fs; % 阻带角频率
delta_f = abs(ws - wp); % 计算过渡带宽度


%% 处理
Wn = (fw + fp)/fs; % 截止频率计算 
N = ceil(6.2*pi/min(delta_f)); % 计算滤波器阶数
N = N + mod(N,2); % 保证滤波器阶数为偶数
M = N+1; % 窗长
w = hanning(M)'; % 汉宁窗
B = fir1(N,Wn,"stop",w); % 滤波器设计
[A,W] = freqz(B,1,1000,fs); % 幅频响应


%% 绘图
subplot 211
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 212
stem(1:M,B);
title('脉冲响应');xlabel('样点');  ylabel('幅值')
grid;



