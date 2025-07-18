%
% 3.14 为什么零相位滤波在起始和结束两端都受瞬态效应的影响
% 零相位滤波输入输出信号同相
% 由于起始段受瞬态效应影响，时域翻转后，后一项结束端为前一项起始端，因此起始和结束两端都受瞬态效应的影响
% 
% 1.零相位数字滤波器设计
% y = filtfilt(b,a,x);
% 
clc,clear,close all


%% 初始条件
load ydata1.mat

fs = 400; % 采样频率
fp = 20; % 通带频率
fw = 30; % 阻带频率
Rp = 2; % 通带波纹
Rs = 40; % 阻带波纹
N = 0:length(y)-1; % 索引
t = N/fs; % 时间序列

%% 处理
wp = fp*2/fs; % 通带频率
ws = fw*2/fs; % 阻带频率
[n,Wn] = cheb1ord(wp,ws,Rp,Rs);  % 切比雪夫Ⅱ滤波器参数计算
[b,a] = cheby2(n,Rs,Wn,'low'); % 切比雪夫Ⅱ滤波器设计
[A,W] = freqz(b,a,1000,fs); % 幅频响应

% 方案1
y1 = filtfilt(b,a,y); % 零相位滤波

% 方案2
y0 = filter(b,a,y); % 直接滤波
y2 = flipud(y0); % 时域翻转
y2 = filter(b,a,y2); % 再次滤波
y2 = flipud(y2); % 时域翻转


%% 绘图
subplot 211
plot(W,20*log10(A)); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;
axis([0 200 -50 5])

subplot 212
plot(t,y0);
hold on
plot(t,y1);
plot(t,y2);
title('信号波形');xlabel('时间(s)'); ylabel('幅值');
legend('直接滤波','方案1','方案2');
grid;













