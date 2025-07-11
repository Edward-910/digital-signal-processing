%
% 2.10 加窗函数后频谱幅值变了，如何修正
% 
% 幅值修正系数
% 汉宁窗hanning：2
% 海明窗hamming：1.852
% 布莱克曼窗blackman：2.381
%
clc,clear,close all


%% 初始条件
N = 1000; % 信号长度
n = 0:1:N-1; % 刻度
fs = 2000; % 采样频率

f1 = 50; % 信号频率1
f2 = 65.75; % 信号频率2

sita1 = 0; % 初始相位1
sita2 = 0; % 初始相位2

df = fs/N; % 频率分辨率
df_x = 0:df:fs/2; % 频谱横坐标

x = cos(2*pi*f1*n/fs + sita1) + cos(2*pi*f2*n/fs + sita2); % 信号表达式

%% 处理
w1 = hanning(N);
w2 = hamming(N);
w3 = blackman(N);

X = fft(x);
X1 = fft(x.*w1');
X2 = fft(x.*w2');
X3 = fft(x.*w3');

X = abs(X(1:N/2 + 1)); % 取正半周频率
X1 = abs(X1(1:N/2 + 1)); % 取正半周频率
X2 = abs(X2(1:N/2 + 1)); % 取正半周频率
X3 = abs(X3(1:N/2 + 1)); % 取正半周频率


% 截取频谱中的信号
x_thr = max(X)*3/4;
res_x = find(X>x_thr);

x_thr1 = max(X1)*3/4;
res_x1 = find(X1>x_thr1);

x_thr2 = max(X2)*3/4;
res_x2 = find(X2>x_thr2);

x_thr3 = max(X3)*3/4;
res_x3 = find(X3>x_thr3);

% 得到结果
res_A = 2.*X(res_x)/N;
res_A1 = (2.*X1(res_x1)/N)*2;
res_A2 = (2.*X2(res_x2)/N)*1.852;
res_A3 = (2.*X3(res_x3)/N)*2.381;

fprintf('不加窗:A1:%f  A2:%f\n',res_A(1),res_A(2)); 
fprintf('汉宁窗:A1:%f  A2:%f\n',res_A1(1),res_A1(2)); 
fprintf('海明窗:A1:%f  A2:%f\n',res_A2(1),res_A2(2)); 
fprintf('布莱克曼窗:A1:%f  A2:%f\n',res_A3(1),res_A3(2)); 
