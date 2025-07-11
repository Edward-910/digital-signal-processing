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


%% 二、栅栏现象
%
% 补零，提高频率分辨率
%
N1 = 1000; % 信号长度1
N2 = 1500; % 信号长度2
n1 = 0:1:N1-1; % 刻度1
n2 = 0:1:N2-1; % 刻度2
fs = 2000; % 采样频率

f1 = 50; % 信号频率1
f2 = 65.75; % 信号频率2

sita1 = 0; % 初始相位1
sita2 = 0; % 初始相位2

df1 = fs/N1; % 频率分辨率
df_x1 = 0:df1:fs/2; % 频谱横坐标
df2 = fs/N2; % 频率分辨率
df_x2 = 0:df2:fs/2; % 频谱横坐标


x1 = cos(2*pi*f1*n1/fs + sita1) + cos(2*pi*f2*n1/fs + sita2); % 信号1表达式
x2 = [x1,zeros(1,N2-N1)];

X1 = fft(x1);
X2 = fft(x2);

X1 = abs(X1(1:N1/2 + 1)); % 取正半周频率
X2 = abs(X2(1:N2/2 + 1)); % 取正半周频率

subplot 211
plot(df_x1,X1);
subplot 212
plot(df_x2,X2);

% 截取频谱中的信号
peaks1 = findpeaks(X1);
res_x1 = [find(X1 == peaks1(1)),find(X1 == peaks1(2))];
peaks2 = findpeaks(X2,'MinPeakHeight',max(X2)*2/3);
res_x2 = [find(X2 == peaks2(1)),find(X2 == peaks2(2))];
% 得到结果
res_f1 = df_x1(res_x1);
res_f2 = df_x2(res_x2);






