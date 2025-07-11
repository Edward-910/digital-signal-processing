%
% 2.9 混叠现象、栅栏现象和泄露现象
%
% 混叠现象：1.不满足采样定理，即f>fs/2
%           2.不是带限信号
% 栅栏现象：频率分辨率不够高导致的细节缺失
% 泄露现象：1.输入序列没包含完整周期，经周期延拓后导致的频谱能量外泄
%           2.补零（加矩形窗）导致的频谱能量外泄
%
clc,clear,close all


%% 三、频谱泄露现象
%
% 1.取整周期
% 2.加窗函数
%
fs = 5000; % 采样频率
f1 = 100; % 信号频率 
Tn = 20; % 信号周期数
Tn1 = 29.8; % 信号周期数
t_targ = Tn/f1;
t_targ1 = Tn1/f1;

n = 0:t_targ*fs; % 采样点
n1 = 0:t_targ1*fs; % 采样点
t = n/fs; % 时间
N = size(n,2); % 点数
N1 = size(n1,2); % 点数
t1 = n1/fs; % 时间

x = cos(2*pi*f1*n/fs); % 信号表达式
x1 = cos(2*pi*f1*n1/fs); % 非完整周期信号
x2 = [x,zeros(1,99)]; % 补零信号
N2 = size(x2,2); 
n2 = 0:N2-1;
t2 = n2/fs;

df = fs/N; % 频率分辨率
df_x = 0:df:fs/2; % 频谱横坐标
df1 = fs/N1;% 频率分辨率1
df_x1 = 0:df1:fs/2; % 频谱1横坐标
df2 = fs/N2;% 频率分辨率2
df_x2 = 0:df2:fs/2; % 频谱2横坐标


%% 处理
X = fft(x);
X1 = fft(x1);
X2 = fft(x2);
w = hamming(N2); % 海明窗
x3 = x2.*w';
X3 = fft(x3); % 补零后加窗函数


X = abs(X(1:N/2 + 1)); % 取正半周频率
X1 = abs(X1(1:N1/2 + 1)); % 取正半周频率
X2 = abs(X2(1:N2/2 + 1)); % 取正半周频率
X3 = abs(X3(1:N2/2 + 1)); % 取正半周频率

subplot 231
plot(t,x);
title('完整周期信号');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 232
plot(t1,x1);
title('非完整周期信号');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 233
plot(t2,x2);
title('补零信号');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 234
plot(df_x,X);
title('完整周期信号');xlabel('频率(Hz)'); ylabel('幅值');
grid;

subplot 235
plot(df_x1,X1);
title('非完整周期信号');xlabel('频率(Hz)'); ylabel('幅值');
grid;

subplot 236
plot(df_x2,X2);
title('补零信号');xlabel('频率(Hz)'); ylabel('幅值');
grid;

figure;
subplot 211
plot(df_x2,X2);
title('补零信号');xlabel('频率(Hz)'); ylabel('幅值');
grid;
subplot 212
plot(df_x2,X3);
title('补零信号加窗');xlabel('频率(Hz)'); ylabel('幅值');
grid;
