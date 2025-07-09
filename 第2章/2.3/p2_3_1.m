%
% 2.3 如何使实数序列位移后为实数序列
% y(n) = x(n+d)
%
clc,clear,close all

%% 初始条件
N = 40; % 信号长度
n = 0:1:N-1; % 刻度
fs = 2000; % 采样频率
f = 100; % 信号频率
sita = -pi/3; % 初始相位
x = cos(2*pi*f*n/fs + sita); % 信号表达式

d = sita*fs/(2*pi*f);
X = myfft(x); % fft结果
f_dis = fs/N; % 频率分辨率

% 1.希尔伯特变换
x1 = hilbert(x);

% 2.fft后乘以旋转因子
X1 = fft(x1);

j = complex(0,1);
w = exp(-j*(2*pi/N)*d*n);

Y = X1.*w;

% 3.ifft得到实数序列
y = ifft(Y);

y = real(y); % 取实部

plot(n,x);
hold on
plot(n,y);






