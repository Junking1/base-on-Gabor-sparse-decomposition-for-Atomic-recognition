load('data.mat');
bat = data;
 
do_number=10; % 匹配迭代次数
[a,N]=size(bat); % 定义信号的长度和原子的长度
resignal=zeros(1,N); % 建立重建信号零矩阵
signal_r=bat; % 将原始信号赋值给剩余待分解信号
 
% 伸缩：伸缩通常取决于a和j的值
a_base=2; % a的基，通常是2 
j_min=0; 
j_max=log2(N); 
u_base=1/2; % 时延（平移）u
p_min=0; % p的最大值取决于它和j的关系
v_base=pi; % 频率v设定
k_min=0; % k的最大值取决于它和j的关系
w_base=pi/6; % 相位w
i_min=0; 
i_max=12; 
 

% 开始迭代运算
for n=1:do_number 

% 选择最佳的原子
[proj,scale,translation,freq,phase]=best_select(signal_r,N,a_base,j_min,j_max,u_base,p_min,v_base,k_min,w_base,i_min,i_max); 
 
t=0:N-1; 
 
t=(t-translation)/scale; % 作平移变换和尺度变换 
 
g=(1/sqrt(scale))*exp(-pi*t.*t).*cos(freq*t+phase); % 对单个原子信号进行伸缩平移和调制
             
g=g/sqrt(sum(g.*g)); % 作归一化 
 
resignal=resignal+proj*g; % 生成重建信号
 
signal_r=signal_r-proj*g; % 计算剩余待分解信号 
 
% 绘制图形
subplot(221); 
plot(bat);   %%%%%%原始信号
title('原始信号 ');
subplot(222); 
plot(g);      %%%%%%%%%5最佳匹配原子
title('最佳匹配原子 ');
subplot(223); 
plot(signal_r);   %%%%%%%%%待分解信号
title('待分解信号 ');
subplot(224); 
plot(resignal);    %%%%%%重建信号
title('重建信号 ');
drawnow; 
end 