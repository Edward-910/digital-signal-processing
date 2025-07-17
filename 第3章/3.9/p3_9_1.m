%
% 3.9 如何把任意s系统转换为z系统
% 通过脉冲响应不变法或双线性变换法将模拟系统转换为数字系统
% 
% 1.计算多项式系数
% b = sym2poly(y)
% y:多项式
% 
clc,clear,close all


%% 初始条件
% 传递函数系数
omega = [9.15494 2.27979 1.22535 21.9]*2*pi;
K = 1.74802;
ledma = 4.05981*2*pi;

syms s
y = (s^2 + 2*ledma*s + omega(1)^2) * (1 + s/omega(3)) * (1 + s/omega(4)); % 分母多项式
z = K*omega(1)*s*(1 + s/omega(2)); % 分子多项式
a = sym2poly(y); % 分母多项式系数
b = sym2poly(z); % 分子多项式系数
b = [zeros(1,length(a) - length(b)),b]; % 分子多项式系数补零
fs = 400; % 采样频率
[H,w] = freqs(b,a); % 频率响应分析

%% 处理
% 1.双线性变换法
[bz1,az1] = bilinear(b,a,fs); % 双线性变换法
[A1,W1] = freqz(bz1,az1,1000,fs); % 频率响应分析

% 2.脉冲响应不变法
[bz2,az2] = impinvar(b,a,fs); % 脉冲响应不变法
[A2,W2] = freqz(bz2,az2,1000,fs); % 频率响应分析


%% 绘图
% plot(W1,20*log10(A1),'r','LineWidth',2); % 方案一
% hold on
% plot(W2,20*log10(A2),'k'); % 方案二
% plot(w/2/pi,20*log10(H),'b','LineWidth',2); % 模拟系统响应
% title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
% legend('双线性变换响应','脉冲响应不变响应','模拟系统响应');

plot(W1,abs(A1),'r','LineWidth',2); % 方案一
hold on
plot(W2,abs(A2),'k'); % 方案二
plot(w/2/pi,abs(H),'b','LineWidth',2); % 模拟系统响应
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
legend('双线性变换响应','脉冲响应不变响应','模拟系统响应');
axis([0 30 0 1.2]); % 限幅


