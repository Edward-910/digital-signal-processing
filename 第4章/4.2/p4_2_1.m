%
% 4.2 寻找信号峰值谷值
% 
% [pks,locs] = findpeaks(x,m,w)
% x:输入信号
% m:
% w:
% pks:
% locs:
% 
clc,clear,close all


%% 初始条件
 






%% 处理
x1 = detrend(y); % 消除趋势项

[x2,xtrend] = polydetrend(y,fs,3); % 最小二乘法消除趋势项

%% 绘图
subplot 411
plot(time,y); % 心电图
title('心电图曲线');xlabel('时间(s)'); ylabel('幅值');
grid







