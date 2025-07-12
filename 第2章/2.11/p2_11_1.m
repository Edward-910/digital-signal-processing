%
% 2.11 如何选择采样频率和信号长度
% 
% 频率分辨率df = fs/N
% 为满足两频率能被分辨，信号长度需满足N>=fs/(f1-f2)
%
clc,clear,close all


%% 初始条件
f1 = 1; % 信号频率1
f2 = 2.5; % 信号频率2
f3 = 3; % 信号频率3
fs = 10; % 采样频率

N{1} = 20; % 信号长度1
N{2} = 40; % 信号长度2
N{3} = 128; % 信号长度3


%% 处理
for i = 1:3
    n = 0:N{i} - 1; % 索引
    x = cos(2*pi*f1*n/fs) + cos(2*pi*f2*n/fs) + cos(2*pi*f3*n/fs); % 信号
    
    df = fs/N{i}; % 频率分辨率
    df_x = 0:df:fs/2; % 频谱横坐标轴
    X = fft(x);
    
    X = abs(X(1:N{i}/2 + 1)); % 取正半周频率
    plot(df_x,X);
    legend_str{i} = ['N=',num2str(N{i})]; % 图例
    hold on
    
end
legend(legend_str);
xlabel('频率(Hz)'); ylabel('幅值');
grid;













