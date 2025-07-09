%
% 快速傅里叶变换实现
% 参考郑君里信号与系统下册9.6 P142
%
clc,clear,close all

% x = [1,3,9,2,2,-5,9,7,6,2,3,-8,-6,9,3,7]; % N=2^4
x = [1,3,9,2];
y = fft(x); % 参考答案 
tic%计时器

N = size(x,2); % 数据大小
j = complex(0,1);
w = exp(-j*(2*pi/N)); % 旋转因子
W = []; % 矩阵初始化

% DFT计算
v = (1:1:N) - 1;

% 构造矩阵
for i = 0:N-1
    w_n = w.^(i.*v);
    W = [W;w_n];
end

res = W*x'; % 计算结果
toc

% 结果验证
res_error = res - y.';



