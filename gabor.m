N = 256
a_base=2; % a�Ļ���ͨ����2
j_min=0;
j_max=log2(N);

u_base=1/2;
p_min=0; % p�����ֵȡ��������j�Ĺ�ϵ
v_base=pi; % Ƶ��v�趨
k_min=0; % k�����ֵȡ��������j�Ĺ�ϵ
w_base=pi/6; % ��λw
i_min=0;
i_max=12;
for j=j_min:j_max
    for p=p_min:N*2^(-j+1)
        for k=k_min:2^(j+1)
            %%%w�걸ԭ�ӿ�
            for i=i_min:i_max
                s=a_base^j; % ����������ֵ��2Ϊ����
                u=p*s*u_base; % ����ƽ�Ƶ�ֵ
                v=k*(1/s)*v_base; % ����Ƶ��ֵ
                w=i*w_base; % ������λֵ
                t=0:N-1;
                t=(t-u)/s; % ��������ƽ�Ʊ任
                g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t+w); % ����ƽ�ƺ͵���
                ga((j+1)*(p+1)*(k+1)*(i+1),1:N)=g/sqrt(sum(g.*g)); % ����һ��
            end
            %%%%����ԭ�ӿ�
%             for i=i_min:i_max
%                 s=a_base^j; % ����������ֵ��2Ϊ����
%                 u=p*s*u_base; % ����ƽ�Ƶ�ֵ
%                 v=k*(1/s)*v_base; % ����Ƶ��ֵ
%                 t=0:N-1;
%                 t=(t-u)/s; % ��������ƽ�Ʊ任
%                 g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t); % ����ƽ�ƺ͵���
%                 ga((j+1)*(p+1)*(k+1)*(i+1),1:N)=g/sqrt(sum(g.*g)); % ����һ��
%             end
%             
        end
    end
end
save ga.mat





