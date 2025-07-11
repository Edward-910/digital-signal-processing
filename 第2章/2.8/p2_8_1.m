%
% 2.8 如何把频谱图中纵坐标设置为分贝数
%
% res = 20*lg(X(jw))
% 
clc,clear,close all


%% 初始条件
load sndata1.mat
x = y.';
N = size(x,2); % 信号长度
n = 0:1:N-1; % 索引
t = n/fs; % 时间

df = fs/N; % 频率分辨率
df_x = 0:df:fs/2; % 频谱横坐标

%% 处理
X = fft(x);
X = abs(X(1:N/2 + 1));
X_db = 20*log10(X);

subplot 311;
plot(df_x,X);
title('线性幅值');xlabel('频率(s)'); ylabel('幅值');
legend('线性幅值');
grid;

subplot 312;
semilogy(df_x,X);
title('对数幅值');xlabel('频率(s)'); ylabel('幅值');
legend('对数幅值');
grid;

subplot 313;
plot(df_x,X_db);
title('分贝幅值');xlabel('频率(s)'); ylabel('幅值（dB）');
legend('分贝幅值');
grid;

