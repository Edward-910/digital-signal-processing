%
% 3.13 如何设计数字全通滤波器对IIR滤波器进行相位补偿
% 
% 由于IIR滤波器相移为非线性，因此可以在IIR滤波器后级联一个全通滤波器调整输出信号相移
% 群延时:滤波器对某一频率成分的延时效果
% 
% 1.群延时计算
% [gd,w] = grpdelay(b,a,n);
% [gd,f] = grpdelay(b,a,n,fs);
% b,a:数字滤波器系数
% n:计算点数,默认512点
% fs:采样频率
% f:输出频率序列
% w:输出角频率序列
% gd:延迟量曲线
%  
% 2.全相位数字滤波器设计
% 设计一个在已知频率范围内接近规定群延迟的全相位数字滤波器
% [b,a] = iirgrpdelay(N,F,Gd)
% F、Gd:群延迟指标
% b、a:数字滤波器系数
% N:全通滤波器阶数(必须是偶数)
% 
clc,clear,close all


%% 初始条件
fs = 4000; % 采样频率
fp = 400; % 通带频率
fw = 600; % 阻带频率
Rp = 3; % 通带波纹
Rs = 20; % 阻带波纹


%% 处理
wp = fp*2/fs; % 通带频率
ws = fw*2/fs; % 阻带频率
[n,Wn] = buttord(wp,ws,Rp,Rs); % 巴特沃斯滤波器参数计算
[b,a] = butter(n,Wn,"low"); % 巴特沃斯滤波器设计
[A1,W1] = freqz(b,a,1000,fs); % 幅频响应
[gd1,f1] = grpdelay(b,a,512,fs); % 计算群延迟

fp_g = 0:0.001:wp; % 通带区间
[g,f] = grpdelay(b,a,fp_g,fs); % 计算群延迟
Gd = max(g) - g; % 计算反向群延迟

[bn,an] = iirgrpdelay(4,fp_g,[0 wp],Gd); % 设计滤波器

% 计算级联后滤波器参数
A = conv(a,an); 
B = conv(b,bn);
[A2,W2] = freqz(B,A,1000,fs); % 幅频响应
[gd2,f2] = grpdelay(B,A,512,fs); % 计算群延迟


subplot 221
plot(W1,20*log10(A1)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;
axis([0 2000 -100 10]);

subplot 222
plot(f1,gd1); % 原滤波器群延迟
title('原滤波器群延迟');xlabel('频率(Hz)'); ylabel('幅值');
grid;


subplot 223
plot(W2,20*log10(A2)); % 幅频响应曲线
title('级联后幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;
axis([0 2000 -100 10]);

subplot 224
plot(f2,gd2); % 级联后滤波器群延迟
title('级联后滤波器群延迟');xlabel('频率(Hz)'); ylabel('幅值');
grid;






