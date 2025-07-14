%
% 3.2 设置模拟滤波器的几种编程方法相同和不同点
% 
% 1.模拟滤波器原型设计
% [z,p,k] = buttap(N)
% z、p、k:模拟滤波器极点、零点、增益
% n:滤波器阶数
% buttap cheb1lap cheb2lap ellipap
% 
% 2.传递函数计算
% (1)低通变带通
%    [b,a] = zp2tf(z,p,k) 
%    [bt,at] = lp2bp(b,a,Wo,Bw)
% (2)低通变高通
%    [b,a] = zp2tf(z,p,k) 
%    [bt,at] = lp2hp(b,a,Wo)
% (3)低通变带阻
%    [b,a] = zp2tf(z,p,k) 
%    [bt,at] = lp2bs(b,a,Wo,Bw)
% (4)低通变低通
%    [b,a] = zp2tf(z,p,k) 
%    [bt,at] = lp2lp(b,a,Wo)
% bt,at:滤波器传递函数系数
% Wo = sqrt(W1*W2) 中心频率
% Bw = W1-W2 带宽
% 
clc,clear,close all


%% 初始条件
wp = 0.2*pi; % 通带频率
ws = 0.3*pi; % 阻带频率

Rp = 3; % 通带波纹
Rs = 20; % 阻带波纹

w = 0:0.01:2; % 频点设置


%% 处理
% 方法一
[n,Wn] = buttord(wp,ws,Rp,Rs,'s'); % 巴特沃斯滤波器参数计算
[b1,a1] = butter(n,Wn,'low','s'); % 巴特沃斯滤波器设计
[A1,W1] = freqs(b1,a1,w); % 巴特沃斯滤波器频率响应

% 方法二
[z,p,k] = buttap(n); % 计算滤波器零、极点,增益
% 传递函数计算
[b,a] = zp2tf(z,p,k);  
[b2,a2] = lp2lp(b,a,Wn);
[A2,W2] = freqs(b2,a2,w); % 巴特沃斯滤波器频率响应

%% 绘图
plot(W1/pi,20*log10(A1)); % 方案一
hold on
plot(W2/pi,20*log10(A2)); % 方案二
title('幅频响应曲线');xlabel('角频率(w/pi)'); ylabel('幅值/dB');
grid;
xlim([0 0.6]);
ylim([-30 10]);

line([0 0.6],[-20 -20],'color','k','linestyle','--'); % 阻带波纹
line([0 0.6],[-1 -1],'color','k','linestyle','--'); % 通带波纹
line([0.2 0.2],[10 -30],'color','k','linestyle','--'); 
line([0.3 0.3],[10 -30],'color','k','linestyle','--');


