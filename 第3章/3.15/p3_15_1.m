%
% 3.15 在窗函数法设计FIR滤波器中如何选择窗函数和阶数N
% 不同窗函数阻带最小衰减不同, 窗函数选择主要取决于阻带衰减(Rs)要求
% 滤波器阶数N与窗函数有关,并根据窗函数、通带频率、阻带频率进行计算
% fs - fp = dw/N 或 min(Δf1,Δf2) = dw/N
% 其中dw取决于选择的窗函数 
% fir滤波器截止频率计算：
% fc = (fp + fs)/2
% 
% 1.窗函数设计fir滤波器
% B = fir1(n,Wn,'ftype',windows)
% B:滤波器系数序列 
% n:滤波器阶数
% Wn:滤波器带宽
% window:窗函数序列,长度为n+1(滤波器阶数+1)
% 
clc,clear,close all


%% 初始条件
fs = 100; % 采样频率
fp = 3; % 通带频率
fw = 5; % 阻带频率
Rp = 3; % 通带波纹
Rs = 50; % 阻带波纹
wp = fp*2*pi/fs;
ws = fw*2*pi/fs;

delta_f = ws - wp; % 计算过渡带宽度


%% 处理
N = ceil(6.6*pi/delta_f); % 计算滤波器阶数，向上取整
N = N + mod(N,2); % 保证滤波器阶数为偶数
w = hamming(N+1)'; % 窗函数(N+1为奇数)
Wn = (fp + fw)/fs; % 截止频率
B = fir1(N,Wn,w); % 滤波器设计

[A,W] = freqz(B,1,1000,fs); % 幅频响应


%% 绘图
subplot 211
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 212
stem(1:N+1,B);
xlabel('样点');  ylabel('幅值')
title('低通滤波器的脉冲响应');
grid;



