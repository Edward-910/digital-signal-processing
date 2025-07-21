%
% 3.22 如何设计多频段FIR滤波器
% 
% 通过fir2函数和等波纹法设计FIR多频带滤波器
% 
clc,clear,close all


%% 初始条件
fs = 2000; % 采样频率
f = [0 220 260 340 380 520 560 640 680 820 860 fs/2]; % 频点1
fc = [220 260 340 380 520 560 640 680 820 860]; % 频点2
fw = [0 220 380 520 680 820]; % 阻带频率
Rp = 1; % 通带波纹
Rs = 40; % 阻带波纹
A1 = [0 0 1 1 0 0 1 1 0 0 1 1]; % 滤波器幅值矢量
F = f*2/fs; % 归一化频率1
Fc = fc*2/fs; % 归一化频率2
N = 1000; % 频率响应点数

%% 处理

% 方案一fir2函数
delta_f = (f(4) - f(3))*2*pi/fs; % 计算过渡带带宽
filN = ceil(6.6*pi/min(delta_f)); % 计算滤波器阶数
filN = filN + mod(filN,2); % 保证滤波器阶数为偶数
M = filN+1; % 窗长
w = hamming(M)'; % 海明窗
B = fir2(filN,F,A1,w); % 滤波器设计
[H1,W1] = freqz(B,1,N,fs); % 幅频响应
db1 = 20*log10(H1); % 计算幅度分贝值

% 方案2等波纹法
% 理想滤波器偏差值矢量
delta1 = (10^(Rp/20)-1)/(10^(Rp/20)+1);
delta2 = 10^(-Rs/20)/(1-10^(-Rs/20));
A2 = [0 1 0 1 0 1];
dev = [delta2 delta1 delta2 delta1 delta2 delta1];

[n,fo,ao,wo] = firpmord(Fc,A2,dev); % 等波纹fir滤波器参数计算

while 1
    b = firpm(n,fo,ao,wo); % 等波纹fir滤波器设计
    [H2,W2] = freqz(b,1,N,fs); % 幅频响应
    df = fs/2/N; % 频率分辨率
    index_w = ceil(fw/df) + 1; % 计算截止频率对应索引
    db2 = 20*log10(H2); % 计算幅度分贝值
    db_s = [db2(index_w(1):index_w(2));db2(index_w(3):index_w(4));db2(index_w(5):index_w(6))];
    delta_H = max(real(db_s)); % 阻带最小衰减
    if delta_H < -Rs
        break;
    else
        n = n + 2;
    end
end


%% 绘图
subplot 211
plot(W1,db1); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;

subplot 212
plot(W2,db2); % 幅频响应曲线
title('幅频响应曲线');xlabel('频率(Hz)'); ylabel('幅值/dB');
grid;


%
% fir2函数中a长度与频点f长度相同
% firpm中频点f的长度为2*length(a)-2
% 






