function [H,W,N] = myfirpm(F,A,Rp,As,n,fs)
    devp=(10^(Rp/20)-1)/(10^(Rp/20)+1); devs=10^(-As/20)/(1-10^(-As/20)); 
    dev=[devp,devs];                  % 与理想滤波器的偏差的矢量
    
    [N,F0,A0,W]=firpmord(F,A,dev);    % 调用firpmord函数计算参数
    N=N+mod(N,2);                     % 保证滤波器阶数为偶数
    Acs=1;                            % Acs初始化
    dw=pi/500;                        % 角频率分辨率
    ns1=floor(F(1)*pi/dw)+1;               % 通带对应的样点
    np1=floor(F(2)*pi/dw)-1;               % 阻带对应的样点
    wlip=1:np1;                       % 通带样点区间
    wlis=ns1:501;                     % 阻带样点区间
    
    while Acs>-As                     % 阻带衰减不满足条件将循环
        h=firpm(N,F0,A0,W);           % 用firpm函数设计滤波器
        [H,W]=freqz(h,1,n,fs);  % 计算滤波器频域响应
        Acs=max(db(wlis));            % 求阻带衰减值
        N=N+2;                        % 阶数加2,保证为第1类滤波器
    end
    N=N-2;                            % 修正N值
end

