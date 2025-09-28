%
% 4.2 寻找信号峰值谷值
% 
% [pks,locs] = findpeaks(x,'属性','参数')
% x:输入信号
% 属性与参数:
%   1.'MINPEAKHEIGHT':寻找峰值幅值大于'参数'
%   2.'MINPEAKDISTANCE':寻找两个相邻峰值间距大于'参数'
%   3.'THRESHOLD':寻找比两旁序列大'参数'值的峰值
%   4.'NPEAKS':限定寻找峰值数目为'参数'
%   5.'SORTSTR':要求峰值排列次序为'参数'('ascend':升序排列,'descend':降序排列,'none':按索引号排列)
% pks:峰值赋值
% locs:峰值位置
% 
clc,clear,close all


%% 初始条件
load ffpulse.txt
x = detrend(ffpulse); % 消除趋势项
fs = 200; % 采样频率
N = length(x); % 信号长度
n = 0:N-1; % 序列
time = n/fs; % 时间序列


%% 处理
[h,loc] = findpeaks(x,'MinPeakDistance',100,'MinPeakHeight',200); % 寻找峰值
t_peak = time(loc); % 峰值位置



%% 绘图
plot(time,x); % 心电图
title('心电图曲线');xlabel('时间(s)'); ylabel('幅值');
grid
hold on
scatter(t_peak,h,'ro','filled');







