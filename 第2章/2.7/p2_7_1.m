%
% 2.7 为什么fft后得到的频谱大部分为0
% 频谱中，f=0处表示直流分量
%
clc,clear,close all


%% 初始条件
load qldata.mat
N = size(y,2); % 信号长度
n = 0:1:N-1; % 索引
t = n/fs; % 时间

df = fs/N; % 频率分辨率
df_x = 0:df:fs/2; % 频谱横坐标

%% 处理

% 消除直流分量与趋势项

% 1.先消除直流分量再使用detrend
y_dir = mean(y); % 直流分量
y1 = detrend(y - y_dir); % 消除趋势项

% 2.直接使用detrend
y2 = detrend(y); % 消除趋势项

Y1 = fft(y1);
Y2 = fft(y2);

Y1 = Y1(1:N/2+1); % 取正频率部分
Y2 = Y2(1:N/2+1); % 取正频率部分

% 绘图
subplot 221 ;plot(df_x,Y1);
title('Y1');xlabel('频率(Hz)'); ylabel('幅值');

subplot 223;plot(t,y1);
title('y1');xlabel('时间(s)'); ylabel('幅值');

subplot 222 ;plot(df_x,Y2);
title('Y2');xlabel('频率(Hz)'); ylabel('幅值');

subplot 224;plot(t,y2);
title('y2');xlabel('时间(s)'); ylabel('幅值');








