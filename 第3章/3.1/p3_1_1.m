%
% 3.1 巴特沃斯，切比雪夫Ⅰ、Ⅱ，椭圆形滤波器相同和不同点
% 
% 's'表示模拟滤波器
% 1.滤波器参数计算
% [n,wn] = buttord(wp,ws,Rp,Rs,'s')
% n:模拟滤波器最低阶数
% wn:等效低通滤波器截止频率
% wp:滤波器通带频率
% ws:滤波器阻带频率
% Rp:通带波纹起伏
% Rs:阻带波纹起伏
% buttord cheb1ord cheb2ord ellipord
% 
% 2.滤波器原型设计
% [b,a] = butter(n,wn,'ftype','s');巴特沃斯滤波器设计
% [b,a] = cheby1(n,Rp,wn,'ftype','s');切比雪夫Ⅰ滤波器设计
% [b,a] = cheby2(n,Rs,wn,'ftype','s');切比雪夫Ⅱ滤波器设计
% [b,a] = ellip(n,Rp,Rs,wn,'ftype','s');椭圆形滤波器设计
% b,a:滤波器传递函数系数
% ftype:滤波器类型('low'低通、'high'高通、'bandpass'带通、'stop'带阻)
% 
% 3.模拟滤波器幅频响应曲线
% [A,W] = freqs(b,a,w);
% A:幅度响应
% W:频率响应
% w:角频率频点(rad/s)
% 不设置w默认计算200个点
% 
clc,clear,close all


%% 初始条件
wp = [0.2*pi 0.3*pi]; % 通带频率
ws = [0.1*pi 0.4*pi]; % 阻带频率

Rp = 1; % 通带波纹
Rs = 20; % 阻带波纹

%% 处理
[n1,Wn1] = buttord(wp,ws,Rp,Rs,'s'); % 巴特沃斯滤波器参数计算
[n2,Wn2] = cheb1ord(wp,ws,Rp,Rs,'s'); % 切比雪夫Ⅰ滤波器参数计算
[n3,Wn3] = cheb2ord(wp,ws,Rp,Rs,'s'); % 切比雪夫Ⅱ滤波器参数计算
[n4,Wn4] = ellipord(wp,ws,Rp,Rs,'s'); % 椭圆形滤波器参数计算

% [n11,Wn11] = buttord(wp/pi,ws/pi,Rp,Rs); % 巴特沃斯滤波器参数计算
% [b11,a11] = butter(n11,Wn11,'bandpass'); % 巴特沃斯滤波器设计
% [A11,W11] = freqs(b11,a11); % 巴特沃斯滤波器频率响应
% plot(W11/pi,20*log10(A11)); % 巴特沃斯滤波器

[b1,a1] = butter(n1,Wn1,'bandpass','s'); % 巴特沃斯滤波器设计
[b2,a2] = cheby1(n2,Rp,Wn2,'bandpass','s'); % 切比雪夫Ⅰ滤波器设计
[b3,a3] = cheby2(n3,Rs,Wn3,'bandpass','s'); % 切比雪夫Ⅱ滤波器设计
[b4,a4] = ellip(n4,Rp,Rs,Wn4,'bandpass','s'); % 椭圆形滤波器设计

w = 0:0.01:2; % 频点设置
% w = 0:0.01:4; % 频点设置

[A1,W1] = freqs(b1,a1,w); % 巴特沃斯滤波器频率响应
[A2,W2] = freqs(b2,a2,w); % 切比雪夫Ⅰ滤波器频率响应
[A3,W3] = freqs(b3,a3,w); % 切比雪夫Ⅱ滤波器频率响应
[A4,W4] = freqs(b4,a4,w); % 椭圆形滤波器频率响应

% [A1,W1] = freqs(b1,a1); % 巴特沃斯滤波器频率响应
% [A2,W2] = freqs(b2,a2); % 切比雪夫Ⅰ滤波器频率响应
% [A3,W3] = freqs(b3,a3); % 切比雪夫Ⅱ滤波器频率响应
% [A4,W4] = freqs(b4,a4); % 椭圆形滤波器频率响应

% freqs(b1,a1,w); % 巴特沃斯滤波器频率响应

%% 绘图
plot(W1/pi,20*log10(A1)); % 巴特沃斯滤波器
hold on
plot(W2/pi,20*log10(A2)); % 切比雪夫Ⅰ滤波器
plot(W3/pi,20*log10(A3)); % 切比雪夫Ⅱ滤波器
plot(W4/pi,20*log10(A4)); % 椭圆形滤波器

title('幅频响应曲线');xlabel('角频率(w/pi)'); ylabel('幅值/dB');
grid;
xlim([0 0.6]);
ylim([-30 10]);

line([0 0.6],[-20 -20],'color','k','linestyle','--'); % 阻带波纹
line([0 0.6],[-1 -1],'color','k','linestyle','--'); % 通带波纹
% 通带频率
line([0.2 0.2],[10 -30],'color','k','linestyle','--'); 
line([0.3 0.3],[10 -30],'color','k','linestyle','--');
% 阻带频率
line([0.1 0.1],[10 -30],'color','k','linestyle','--'); 
line([0.4 0.4],[10 -30],'color','k','linestyle','--');



