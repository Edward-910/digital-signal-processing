%
% 2.12 FFT中的补零问题
% 
% 根据fft原理可知，当采样点数为2的幂次时，fft效率最高
% 即采样点数 N = 2^k
% 根据案例2.9可知，补零将造成频谱泄露
%
clc,clear,close all


%% 初始条件
N1 = 200; % 信号长度1
N2 = 400; % 信号长度2
n1 = 0:1:N1-1; % 刻度1
n2 = 0:1:N2-1; % 刻度2
fs = 200; % 采样频率

f1 = 30; % 信号频率1
f2 = 65.5; % 信号频率2

df1 = fs/N1; % 频率分辨率1
df2 = fs/N1; % 频率分辨率2

t1 = n1/fs; % 时间刻度1
t2 = n2/fs; % 时间刻度2

x1 = cos(2*pi*f1*t1) + cos(2*pi*f2*t1); % 信号
x2 = [x1,zeros(1,N2 - N1)]; % 补零

%% 处理
[df_x1,X1] = plotfft(x1,fs);
[df_x2,X2] = plotfft(x2,fs);

%% 绘图
subplot 221
plot(t1,x1);
title('原始信号');xlabel('时间(s)'); ylabel('幅值');

subplot 222
plot(df_x1,X1);
title('原始信号');xlabel('频率(Hz)'); ylabel('幅值');

subplot 223
plot(t2,x2);
title('补零信号');xlabel('时间(s)'); ylabel('幅值');

subplot 224
plot(df_x2,X2);
title('补零信号');xlabel('频率(Hz)'); ylabel('幅值');










