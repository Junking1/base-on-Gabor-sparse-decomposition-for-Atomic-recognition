load('data.mat');
bat = data;
 
do_number=10; % ƥ���������
[a,N]=size(bat); % �����źŵĳ��Ⱥ�ԭ�ӵĳ���
resignal=zeros(1,N); % �����ؽ��ź������
signal_r=bat; % ��ԭʼ�źŸ�ֵ��ʣ����ֽ��ź�
 
% ����������ͨ��ȡ����a��j��ֵ
a_base=2; % a�Ļ���ͨ����2 
j_min=0; 
j_max=log2(N); 
u_base=1/2; % ʱ�ӣ�ƽ�ƣ�u
p_min=0; % p�����ֵȡ��������j�Ĺ�ϵ
v_base=pi; % Ƶ��v�趨
k_min=0; % k�����ֵȡ��������j�Ĺ�ϵ
w_base=pi/6; % ��λw
i_min=0; 
i_max=12; 
 

% ��ʼ��������
for n=1:do_number 

% ѡ����ѵ�ԭ��
[proj,scale,translation,freq,phase]=best_select(signal_r,N,a_base,j_min,j_max,u_base,p_min,v_base,k_min,w_base,i_min,i_max); 
 
t=0:N-1; 
 
t=(t-translation)/scale; % ��ƽ�Ʊ任�ͳ߶ȱ任 
 
g=(1/sqrt(scale))*exp(-pi*t.*t).*cos(freq*t+phase); % �Ե���ԭ���źŽ�������ƽ�ƺ͵���
             
g=g/sqrt(sum(g.*g)); % ����һ�� 
 
resignal=resignal+proj*g; % �����ؽ��ź�
 
signal_r=signal_r-proj*g; % ����ʣ����ֽ��ź� 
 
% ����ͼ��
subplot(221); 
plot(bat);   %%%%%%ԭʼ�ź�
title('ԭʼ�ź� ');
subplot(222); 
plot(g);      %%%%%%%%%5���ƥ��ԭ��
title('���ƥ��ԭ�� ');
subplot(223); 
plot(signal_r);   %%%%%%%%%���ֽ��ź�
title('���ֽ��ź� ');
subplot(224); 
plot(resignal);    %%%%%%�ؽ��ź�
title('�ؽ��ź� ');
drawnow; 
end 