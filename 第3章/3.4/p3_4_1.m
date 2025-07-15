%
% 3.4 用留数求得脉冲不变法数字滤波器与调用impinvar函数得到的是否一样
% 
% 1.零极点计算
% [r,p,k] = residuez(B,A)
% [B,A] = residuesz(r,p,k)
% r,p,k:零点、极点、增益
% B,A:传递函数系数
% 
% 2.传递函数模拟系数转数字系数
% [bz,az] = impinvar(b,a,fs)
% bz,az:模拟系统传递函数系数
% b,a:模拟系统传递函数系数
% fs:采样频率,不输入默认为1Hz
% 
% 3.脉冲响应计算
% (1)模拟系统脉冲响应计算
% h = impulse(b,a,t)
% h:脉冲响应
% t:时间序列
% (2)离散系统脉冲响应计算
% h = impz(bz,az,n,fs)
% n:脉冲响应样点总数
% 
clc,clear,close all


%% 初始条件
% 系统函数系数
bs = [1,1];
as = [1,5,6];

fs = 10; % 采样频率
T = 1/fs; % 时间间隔

w = 0:0.01:2; % 频点设置
t = 0:0.1:3; % 时间序列

%% 处理
% 留数法
[r,p,k] = residue(bs,as); % s域计算留数、极点、增益
% s域变为z域(z = exp(s/T))
r_z = r*T;
p_z = exp(p*T); 
[b,a] = residuez(r_z,p_z,k); % 计算数字系统传递函数系数


% 调用函数
[bz,az] = impinvar(bs,as,fs); % 计算数字系统传递函数系数

% % 幅频响应
% [A1,W1] = freqs(b,a,w); % 幅频响应
% [A2,W2] = freqs(bz,az,w); % 幅频响应
% 
% plot(W1/pi,A1);
% hold on
% plot(W1/pi,A2);
% title('幅频响应曲线');xlabel('角频率(w/pi)'); ylabel('幅值/dB');
% grid;

h = impulse(bs,as,t); % 模拟系统冲激响应
h1 = impz(b,a,length(t),fs); % 数字系统冲激响应
h2 = impz(bz,az,length(t),fs); % 数字系统冲激响应
h3 = impz(bz,az,length(t)); % 数字系统冲激响应


%% 绘图
plot(t,h*T);
hold on
plot(t,h1);
plot(t,h2);
plot(t,h3);
title('冲击响应曲线');xlabel('时间(s)'); ylabel('幅值');
grid;

%
% plot(t,h*T);中h*t是为了平衡采样过程中幅值变化(补偿频域1/T缩放)
%
