%
% 3.5 在调用bilinear函数时为何有的fs用实际频率值，有的用fs = 1
% 
% 1.双线性变换法模拟到数字变换
% [bz,az] = bilinear(b,a,fs)
% [zd,pd,kd] = bilinear(z,p,k,fs)
% b,a:模拟系统传递函数系数
% bz,az:数字系统传递函数系数
% z,p,k:模拟系统零极点、增益
% zd,pd,kd:数字系统零极点、增益
% 
% 2.数字滤波器幅频响应曲线
% [H,w] = freqz(b,a,n)
% [H,f] = freqz(b,a,n,fs)
% w:归一化角频率,[0,pi]
% f:频率
% n:计算长度
% 
clc,clear,close all


%% 初始条件
fs = 1000; % 采样频率
fp = 100; % 通带频率
fw = 200; % 带阻频率
Rp = 2; % 通带波纹
Rs = 40; % 阻带波纹

wp = 2*pi*fp/fs; % 通带角频率
ws = 2*pi*fw/fs; % 阻带角频率

w = 0:0.01:2; % 频点设置
t = 0:0.1:3; % 时间序列

%% 处理
% 方案一
Wp1 = 2*fs*tan(wp/2); % 通带数字角频率
Ws1 = 2*fs*tan(ws/2); % 阻带数字角频率
[n1,wn1] = cheb1ord(Wp1,Ws1,Rp,Rs,'s'); % 切比雪夫Ⅰ滤波器参数计算
[b1,a1] = cheby1(n1,Rp,wn1,'low','s'); % 切比雪夫Ⅰ滤波器设计
[bz1,az1] = bilinear(b1,a1,fs); % 双线性变换法

% 方案二
Wp2 = 2*1*tan(wp/2); % 通带数字角频率
Ws2 = 2*1*tan(ws/2); % 阻带数字角频率
[n2,wn2] = cheb1ord(Wp2,Ws2,Rp,Rs,'s'); % 切比雪夫Ⅰ滤波器参数计算
[b2,a2] = cheby1(n2,Rp,wn2,'low','s'); % 切比雪夫Ⅰ滤波器设计
[bz2,az2] = bilinear(b2,a2,1); % 双线性变换法

[A1,W1] = freqz(bz1,az1,512,fs); % 幅频响应曲线1
[A2,W2] = freqz(bz2,az2,512,fs); % 幅频响应曲线2
h1 = impz(bz1,az1,length(t),fs); % 数字系统冲激响应1
h2 = impz(bz2,az2,length(t)); % 数字系统冲激响应2

%% 绘图
subplot 211
plot(W1,20*log10(A1),'r','LineWidth',2); % 方案一
hold on
plot(W2,20*log10(A2),'k'); % 方案二
title('幅频响应曲线');xlabel('角频率(w/pi)'); ylabel('幅值/dB');
legend('方案1曲线','方案2曲线');
grid;
xlim([0 300]);
ylim([-50 10]);
subplot 212
plot(t,h1,'r','LineWidth',2); % 方案一
hold on
plot(t,h2,'k'); % 方案二
title('冲击响应曲线');xlabel('时间(s)'); ylabel('幅值');
legend('方案1曲线','方案2曲线');
grid;








