%
% 3.17 凯泽窗设计fir滤波器优点
% 不同beta值凯泽窗有不同形状(过渡带宽、通带波纹、阻带波纹)
% Rp = 3;Rs = 50;选择beta = 4.538;过渡带宽 Δf = 5.86*pi/N
%  
% 1.凯泽窗设计滤波器
% 用凯泽窗求FIR滤波器阶数和凯泽窗参数
% [n,Wn,beta,ftype] = kaiserord(f,A,dev,fs);
% [n,Wn,beta,ftype] = kaiserord(f,A,dev);
% f:频率参数[fp fs]或[fs1 fp1 fs2 fp2]
% a:滤波器幅值矢量 低通:[1 0],带通:[0 1 0]
% dev:通带、阻带波纹线性值
% n:滤波器阶数
% Wn:滤波器频率参数
% 
% dev数值计算
% 参考数字信号处理7.3.5 p414 式7.3.47 、7.3.48
% delta1 = (10^(Rp/20)-1)/(10^(Rp/20)+1);
% delta2 = 10^(-Rs/20)/(1-10^(-Rs/20));
% 
clc,clear,close all


%% 初始条件
fs = 100; % 采样频率
f = [3,5]; % 通带频率 阻带频率
Rp = 3; % 通带波纹
Rs = 50; % 阻带波纹
wp = f(1)*2*pi/fs; % 通带角频率
ws = f(2)*2*pi/fs; % 阻带角频率
A = [1 0]; % 滤波器幅值矢量
delta_f = ws - wp; % 计算过渡带宽度


%% 处理
delta1 = (10^(Rp/20)-1)/(10^(Rp/20)+1); % 通带波纹衰减
delta2 = 10^(-Rs/20)/(1-10^(-Rs/20)); % 阻带波纹衰减
dev = [delta1 delta2]; % 设置指标
% delta2 = 10^(-Rs/20)*(1+delta1);
[N,Wn,beta,ftype] = kaiserord(f,A,dev,fs); % 用凯泽窗求FIR滤波器阶数和凯泽窗参数
N = N + mod(N,2); % 保证滤波器阶数为偶数
M = N+1; % 窗长
w = kaiser(M,beta); % 凯撒窗
B = fir1(N,Wn,w); % 滤波器设计
[A,W] = freqz(B,1,1000,fs); % 幅频响应

%% 绘图
subplot 211
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 212
stem(1:M,B);
title('脉冲响应');xlabel('样点');  ylabel('幅值')
grid;



