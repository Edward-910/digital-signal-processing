function [df_x,Signal_fft] = plotfft(signal_input,fs)
% 本函数用于处理需要fft并绘制频谱的信号

Signal_fft = fft(signal_input);

N = length(Signal_fft); % 信号长度
df = fs/N; % 信号分辨率
df_x = 0:df:fs/2; % 频谱横坐标轴

Signal_fft = abs(Signal_fft(1:N/2 + 1));
end

