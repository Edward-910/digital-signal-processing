%
% 2.13 能否用循环相关计算延迟量
%  
% 两信号可以使用互相关计算得到延迟量，使用线性相关函数；而使用fft可以快速计算循环相关，从而得到延迟量
% 两信号x(n),y(n)；长度分别为N和M，则有卷积后信号长度N' = N + M -1 
% 两信号x(n),y(n)；长度分别为N和M，若进行N' > N + M -1 点循环卷积，则结果与线性卷积一致；
% 若进行N' > N + M -1点循环卷积，则产生混叠。
% 
clc,clear,close all


%% 初始条件
load delaydata1.txt

x = delaydata1(:,1);
y = delaydata1(:,2);
N1 = length(x); 
N2 = length(y);


%% 处理
[R,n]=xcorr(y,x); % 计算互相关

X = fft(x,N1 + N2 - 1); % 补零，fft
Y = fft(y,N1 + N2 - 1); % 补零，fft

R_xy = Y.*conj(X); % 计算互相关
r_xy = ifftshift(ifft(R_xy)); % 傅里叶反变换

% subplot 311
% plot(1:2999,R_xy);
% subplot 312
% plot(1:2999,fftshift(R_xy));
% subplot 313
% plot(1:2999,ifftshift(R_xy));
% fftshift(R_xy) == ifftshift(R_xy)

%% 绘图
subplot 211
plot(n,r_xy);
title('fft计算循环相关');xlabel('点数'); ylabel('幅值');

subplot 212
plot(n,R);
title('线性相关函数');xlabel('点数'); ylabel('幅值');





















