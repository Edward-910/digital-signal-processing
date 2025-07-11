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


%% 一、混叠现象
%
% 提高采样频率使满足采样定律
%

fs1 = 1000; % 采样频率1
fs2 = 150; % 采样频率2
f0 = 100; % 信号频率 
Tn = 5; % 信号周期数
t_targ = Tn/f0;

t = 0:t_targ*1e-3:t_targ ; % 时间
n1 = 0:t_targ*fs1; % 频率1采样点
n2 = 0:t_targ*fs2; % 频率2采样点
t1 = n1/fs1; % 频率1时间
t2 = n2/fs2; % 频率2时间
N1 = size(n1,2); % 频率1点数
N2 = size(n2,2); % 频率2点数

df1 = fs1/N1; % 频率1分辨率
df1_x = 0:df1:fs1/2; % 频谱1横坐标
df2 = fs2/N2; % 频率2分辨率
df2_x = 0:df2:fs2/2; % 频谱2横坐标

x = cos(2*pi*f0*t); % 信号
x1 = cos(2*pi*f0*n1/fs1); % 采样频率1所得序列
x2 = cos(2*pi*f0*n2/fs2); % 采样频率2所得序列

X1 = fft(x1);
X1 = abs(X1(1:N1/2+1)); % 取正频率部分

X2 = fft(x2);
X2 = abs(X2(1:N2/2+1)); % 取正频率部分

subplot 221;
stem(t1,x1);hold on
plot(t,x);
title('fs1');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 222;
stem(t2,x2);hold on
plot(t,x);
title('fs2');xlabel('时间(s)'); ylabel('幅值');
grid;

subplot 223;
plot(df1_x,X1);
title('fs1频谱');xlabel('频率(Hz)'); ylabel('幅值');
grid;

subplot 224;
plot(df2_x,X2);
title('fs2频谱');xlabel('频率(Hz)'); ylabel('幅值');
grid;




