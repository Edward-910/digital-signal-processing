%
% 3.3 在频带变换的模拟滤波器中,怎么计算Wo和Bw
% 
clc,clear,close all


%% 初始条件
wp = [0.2*pi 0.3*pi]; % 通带频率
ws = [0.1*pi 0.4*pi]; % 阻带频率

Rp = 1; % 通带波纹
Rs = 20; % 阻带波纹

w = 0:0.01:2; % 频点设置

%% 处理
[N,Wn]=buttord(wp,ws,Rp,Rs,'s'); % 求巴特沃斯滤波器阶数
[z,p,k] = buttap(N); % 计算滤波器零、极点,增益
% 参数计算
Wo = sqrt(Wn(1)*Wn(2));
Bw = abs(Wn(1) - Wn(2));
% 传递函数计算
[b,a] = zp2tf(z,p,k);  
[b2,a2] = lp2bp(b,a,Wo,Bw);
[A2,W2] = freqs(b2,a2,w); % 巴特沃斯滤波器频率响应

% 对照组
[b1,a1] = butter(N,Wn,'bandpass','s'); % 巴特沃斯滤波器设计
[A1,W1] = freqs(b1,a1,w); % 巴特沃斯滤波器频率响应



%% 绘图
plot(W1/pi,20*log10(A1)); % 测试组
hold on
plot(W2/pi,20*log10(A2)); % 对照组
title('幅频响应曲线');xlabel('角频率(w/pi)'); ylabel('幅值/dB');
grid;
xlim([0 0.6]);
ylim([-30 10]);

line([0 0.6],[-20 -20],'color','k','linestyle','--'); % 阻带波纹
line([0 0.6],[-1 -1],'color','k','linestyle','--'); % 通带波纹
line([0.2 0.2],[10 -30],'color','k','linestyle','--'); 
line([0.3 0.3],[10 -30],'color','k','linestyle','--');


















