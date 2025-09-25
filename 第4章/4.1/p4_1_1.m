%
% 4.1基线漂移修正
% 
% y = detrend(x)
% y:消除趋势项结果
% x:输入信号
% 
% [y,ytrend] = polydetrend(x,fs,m)
% y:消除趋势项信号
% ytrend:信号趋势
% x:输入信号
% fs:采样频率
% m:多项式阶数
% 
clc,clear,close all


%% 初始条件
load ecgdata2.mat
N = length(y); % 信号长度
n = 0:N-1; % 序列
time = n/fs; % 时间序列

%% 处理
x1 = detrend(y); % 消除趋势项

[x2,xtrend] = polydetrend(y,fs,3); % 最小二乘法消除趋势项

%% 绘图
subplot 411
plot(time,y); % 心电图
title('心电图曲线');xlabel('时间(s)'); ylabel('幅值');
grid

subplot 412
plot(time,x1); % 心电图
title('消除趋势项曲线1');xlabel('时间(s)'); ylabel('幅值');
grid

subplot 413
plot(time,x2); % 心电图
title('消除趋势项曲线2');xlabel('时间(s)'); ylabel('幅值');
grid

subplot 414
plot(time,xtrend); % 心电图
title('心电图趋势');xlabel('时间(s)'); ylabel('幅值');
grid







