%
% 2.1快速傅里叶变换实现
% 参考郑君里信号与系统下册9.6 P142
% fft 实现
%
clc,clear,close all

x = [1,3,9,2,2,-5,9,7,6,2,3,-8,-6,9,3,7]; % N=2^4
% x = [1,3,9,2,2,-5,9,7];
y = fft(x); % 参考答案 
tic%计时器

N = size(x,2); % 点数
m = ceil(log2(N)); % 幂次
X = zeros(1,N); % 结果
j = complex(0,1);
w = exp(-j*(2*pi/N)); % 旋转因子

% 补零
if  N ~= 2^m
    fx_zero = zeros(1,2^m - N);
    x = [x,fx_zero];
end

% 索引
n = 0:1:N-1;
n1 = dec2bin(n,m); % 十转二
n2 = fliplr(n1); % 翻转
n3 = bin2dec(n2)+1; % 复原索引

% 重新排列
X = x(n3);

% 蝶形运算
idx = 0:1:2^(m-1);

% 第con层DFT
for con = 1:m
    
    % 预处理
    X_res = []; % 迭代用数组
    N_con = 2^con; % 该层DFT点数
    idx_con = idx(1:N_con/2);
 
    for a = 1:N/N_con 
        
        % 截取第a段
        X_con = X((a - 1) * N_con + 1 :a * N_con);

        % 偶数部分
        X_eve = X_con(1:N_con/2);
    
        % 奇数部分
        X_odd = X_con(N_con/2+1:N_con) .* ... 
                 w.^(N/N_con.*idx_con); % 旋转因子计算
        
        % 计算结果
        X_eve_res = X_eve + X_odd;
        X_odd_res = X_eve - X_odd;
        
        X_res = [X_res,X_eve_res,X_odd_res];
    end

    X = X_res; % 保存
    
end
toc







