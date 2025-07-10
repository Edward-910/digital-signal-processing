%
% 2.5 计算信号幅值和初始相位 
%
% A = 2*X(k0)/N
% sita = arctan(X(k0))
%
clc,clear,close all

%% 初始条件
N = 1000; % 信号长度
n = 0:1:N-1; % 刻度
fs = 2000; % 采样频率

f1 = 50; % 信号频率1
f2 = 65.75; % 信号频率2

sita1 = 0; % 初始相位1
sita2 = 0; % 初始相位2

df = fs/N; % 频率分辨率
df_x = 0:df:fs/2; % 频谱横坐标

x = cos(2*pi*f1*n/fs + sita1) + cos(2*pi*f2*n/fs + sita2); % 信号表达式

%% 处理
X = fft(x);

X = abs(X(1:N/2 + 1)); % 取正半周频率

% plot(df_x,X);

% 截取频谱中的信号
x_thr = max(X)/2;
res_x = find(X>x_thr);

% 得到结果
res_f = df_x(res_x);
res_A = 2.*X(res_x)/N;
res_angle = angle(X(res_x));

%%
% 
% 此处结果频率：55Hz、66Hz
% 原因：频谱分辨率不足导致的频谱泄露
% 解决方法：增多dft点数、提高频谱分辨率
% df = 0.01 = fs/N，N = 2000*100
% 结果:res_f = [50,65.7500]
% 



