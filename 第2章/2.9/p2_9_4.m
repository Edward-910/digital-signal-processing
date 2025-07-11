%
% 2.9 同样进行矩形窗截断，为什么有的发生泄漏有的没有发生泄露
%
% 1.整周期截断
% 2.加窗
%
clc,clear,close all


%% 初始条件
fs = 5000; % 采样频率
f1 = 100; % 信号频率 
Tn = 20; % 信号周期数
t_targ = Tn/f1;

n = 0:t_targ*fs; % 采样点
t = n/fs; % 时间
N = size(n,2); % 点数

x = cos(2*pi*f1*n/fs); % 信号表达式
x2 = [x,zeros(1,99)]; % 补零信号
N2 = size(x2,2); 
n2 = 0:N2-1;
t2 = n2/fs;

df = fs/N; % 频率分辨率
df_x = 0:df:fs/2; % 频谱横坐标
df2 = fs/N2;% 频率分辨率2
df_x2 = 0:df2:fs/2; % 频谱2横坐标


%% 处理
X = fft(x);
X2 = fft(x2);
w = hamming(N2); % 海明窗
x3 = x2.*w';
X3 = fft(x3); % 补零后加窗函数


X = abs(X(1:N/2 + 1)); % 取正半周频率
X2 = abs(X2(1:N2/2 + 1)); % 取正半周频率
X3 = abs(X3(1:N2/2 + 1)); % 取正半周频率

figure;
subplot 221
plot(t,x);
title('完整周期信号');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 222
plot(df_x,X);
title('完整周期信号');xlabel('频率(Hz)'); ylabel('幅值');
grid;

subplot 223
plot(t2,x2);
title('补零信号');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 224
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
