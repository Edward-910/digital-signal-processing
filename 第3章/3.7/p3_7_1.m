%
% 3.7 为什么滤波器的输出会溢出或没有数值
% 若低通滤波器截止频率或带通滤波器中心频率相对采样频率过低(即fc/fs过小)或过渡带太窄时产生这种情况
% 解决方法:降低采样频率，fs'/fc < 15比较合适
% 
% 1.降采样 
% x = resample(y,p,q);
% y:输入信号
% p,q:信号以fs*p/q的采样频率进行重新采样
% 
clc,clear,close all


%% 初始条件
load bzsdata.mat
N = length(bzs); % 信号长度
n = 0:1:N-1; % 索引
t = n/Fs; % 时间序列
    
p = 1; % 比例系数
q = 5; % 比例系数
fs1 = Fs*(p/q); % 降采样后采样频率
x = resample(bzs,p,q); % 降采样采样频率fs1 = fs*(p/q)
N1 = length(x); % 降采样信号长度
n1 = 0:1:N1-1; % 降采样索引
t1 = n1/fs1; % 降采样时间序列

fp = [1.5 10]; % 通带频率
fw = [1,12]; % 带阻频率
Rp = 3; % 通带波纹
Rs = 15; % 阻带波纹


%% 处理
% 方案一
wp = 2*fp/fs1; % 通带角频率
ws = 2*fw/fs1; % 阻带角频率
[n,wn] = buttord(wp,ws,Rp,Rs); % 巴特沃斯滤波器参数计算
[b,a] = butter(n,wn); % 巴特沃斯滤波器设计

% % 方案二
% wp = 2*pi*fp/fs1; % 通带角频率
% ws = 2*pi*fw/fs1; % 阻带角频率
% Wp1 = 2*fs1*tan(wp/2); % 通带数字角频率
% Ws1 = 2*fs1*tan(ws/2); % 阻带数字角频率
% [n,wn] = buttord(Wp1,Ws1,Rp,Rs,'s'); % 巴特沃斯滤波器参数计算
% [bc,ac] = butter(n,wn,'bandpass','s'); % 巴特沃斯滤波器设计
% [b,a] = bilinear(bc,ac,fs1); % 双线性变换法

y1 = filter(b,a,x); % 滤波
y = resample(y1,5,1); % 恢复采样频率

%% 绘图
subplot 411
plot(t,bzs);
title('原信号');xlabel('t(s)'); ylabel('幅值');
grid;
subplot 412
plot(t1,x);
title('降采样信号');xlabel('t(s)'); ylabel('幅值');
grid;
subplot 413
plot(t1,y1);
title('原信号滤波');xlabel('t(s)'); ylabel('幅值');
grid;
subplot 414
plot(t,y);
title('降采样信号滤波');xlabel('t(s)'); ylabel('幅值');
grid;

% 
% 使用数字域直接计算滤波器参数时(滤波器函数不加's'):
% 1.角频率wp = 2*fp/fs1; % 通带角频率ws = 2*fw/fs1; % 阻带角频率
% 2.使用对应滤波器函数进行设计(滤波器函数不加's')
% 使用模拟域计算滤波器参数时(滤波器函数加's'):
% 1.角频率wp = 2*pi*fp/fs1; % 通带角频率ws = 2*pi*fw/fs1; % 阻带角频率
% 2.频率预畸变
% 3.双线性变换处理
% 4.使用模拟与计算滤波器函数时必须进行脉冲响应不变法或双线性变换法处理
% 







