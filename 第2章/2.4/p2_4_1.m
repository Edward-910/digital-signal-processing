%
% 2.4 频谱图中频率刻度设置
%
% =>频率分辨率计算
%
clc,clear,close all


%% 初始条件
N = 128; % 信号长度
n = 0:1:N-1; % 刻度
fs = 128; % 采样频率
f = 30; % 信号频率
sita = 0; % 初始相位
x = cos(2*pi*f*n/fs + sita); % 信号表达式

f1 = fs/N; % 频率分辨率
f1_x = 0:f1:f1*N/2; % 频谱图横坐标

y = fft(x); 

% 绘图
plot(f1_x,abs(y(1:N/2+1)));
xlabel('频率(Hz)'); 
ylabel('幅值');


