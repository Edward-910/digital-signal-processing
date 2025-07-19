%
% 3.16 用ideal_lp函数和fir1函数设计的滤波器是否相同
% 
% 1.理想低通滤波器
% 给出一个理想FIR滤波器的脉冲响应序列
% hd = ideal_lp(wc,M);
% hd:理想低通滤波器脉冲响应序列
% wc = fc*2*pi/fs ：归一化截止角频率
% 
% 各种窗函数dw值:
% 矩形窗(21dB):1.8*pi
% 汉宁窗(44dB):6.2*pi
% 海明窗(53dB):6.6*pi
% 布莱克曼窗(74dB):11*pi
% 凯泽窗(80dB):10*pi
% 
clc,clear,close all


%% 初始条件
fs = 1000; % 采样频率
fp = [175 275]; % 通带频率
fw = [100 350]; % 阻带频率
Rs = 30; % 阻带波纹


%% 处理
wp = fp*2*pi/fs; % 通带角频率
ws = fw*2*pi/fs; % 阻带角频率
fc = (fp + fw)/fs; % 截止频率
wc1 = (wp(1) + ws(1))/2; % 截止角频率
wc2 = (wp(2) + ws(2))/2; % 截止角频率
delta_f = abs(ws - wp); % 计算过渡带宽度
dw = 6.2*pi; % 汉宁窗
N = ceil(dw/min(delta_f)); % 计算fir滤波器阶数
N = N + mod(N,2); % 保证滤波器阶数为偶数
M = N+1; % 窗长
w = hanning(M)'; % 窗函数(N+1为奇数)

% 方案1
B = fir1(N,fc,'bandpass',w); % fir滤波器设计
[A1,W1] = freqz(B,1,1000,fs); % 幅频响应

% 方案2
hd = ideal_lp(wc2,M) - ideal_lp(wc1,M); % 理想fir滤波器,两个低通滤波器相减
h = hd.*w; % 加窗后滤波器脉冲响应
[A2,W2] = freqz(h,1,1000,fs); % 幅频响应

%% 绘图
subplot 211
plot(W1,20*log10(A1)); % 幅频响应曲线
title('方案1 fir函数幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 212
plot(W2,20*log10(A2)); % 幅频响应曲线
title('方案2 ideal_lp函数幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;



