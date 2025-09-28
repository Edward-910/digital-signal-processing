%
% 4.3 如何使用finpeaks函数寻找谷值
% 

clc,clear,close all


%% 初始条件
load SDqdata2.mat
N = length(time); % 信号长度
n = 0:N-1; % 序列
y = mix_signal; % 幅值序列

%% 处理
y = -y; % 信号反向
[h,loc] = findpeaks(y,'MinPeakDistance',5,'MinPeakHeight',-1400); % 寻找峰值
b0 = interp1(time(loc),-h,time); % 基线
x = -y-b0; % 基线拉平

%% 绘图
subplot 312
plot(time,x); % 心电图
title('基线拉平曲线');xlabel('时间(s)'); ylabel('幅值');
grid

subplot 311
plot(time,-y); % 心电图
title('信号曲线');xlabel('时间(s)'); ylabel('幅值');
grid

subplot 313
plot(time,b0); % 心电图
title('基线');xlabel('时间(s)'); ylabel('幅值');
grid
hold on
scatter(time(loc),-h,'r.');








