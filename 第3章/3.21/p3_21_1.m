%
% 3.21 通过firpm设计等波纹fir滤波器
% 
% 1.等波纹fir滤波器设计
% b = firpm(n,f,a,w);
% b:滤波器输出
% n:滤波器阶数
% f:频点值
% a:对应频点幅度
% w:计权矢量
% 
% 2.等波纹fir滤波器参数计算
% [n,fo,ao,w] = firpmord(f,a,dev,fs);
% n、fo、ao、w:firpm函数输入参数
% f:频点值
% a:幅值矢量
% dev:理想滤波器偏差值矢量
% 
clc,clear,close all


%% 初始条件
fs = 2000; % 采样频率
f = [200,300]; % 通带频率 阻带频率
Rp = 2; % 通带波纹
Rs = 40; % 阻带波纹
wp = f(1)*2*pi/fs; % 通带角频率
ws = f(2)*2*pi/fs; % 阻带角频率
A = [1 0]; % 滤波器幅值矢量
F = f*2/fs; % 归一化频率

%% 处理
% 理想滤波器偏差值矢量
delta1 = (10^(Rp/20)-1)/(10^(Rp/20)+1);
delta2 = 10^(-Rs/20)/(1-10^(-Rs/20));
dev = [delta1 delta2];

[n,fo,ao,w] = firpmord(F,A,dev); % 等波纹fir滤波器参数计算
b = firpm(n,fo,ao,w); % 等波纹fir滤波器设计

[H,W] = freqz(b,1,1000,fs); % 幅频响应


%% 绘图
plot(W,20*log10(H)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;


%
% firpm中f为归一化频率矢量,firpmord中若无fs输入,得到的fo为归一化频率矢量
% 因此在使用firpmord计算firpm所用参数时不使用fs
% 








