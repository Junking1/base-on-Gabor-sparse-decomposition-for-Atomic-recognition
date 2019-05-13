N = 256
a_base=2; % a的基，通常是2
j_min=0;
j_max=log2(N);

u_base=1/2;
p_min=0; % p的最大值取决于它和j的关系
v_base=pi; % 频率v设定
k_min=0; % k的最大值取决于它和j的关系
w_base=pi/6; % 相位w
i_min=0;
i_max=12;
for j=j_min:j_max
    for p=p_min:N*2^(-j+1)
        for k=k_min:2^(j+1)
            %%%w完备原子库
            for i=i_min:i_max
                s=a_base^j; % 计算伸缩的值，2为基底
                u=p*s*u_base; % 计算平移的值
                v=k*(1/s)*v_base; % 计算频率值
                w=i*w_base; % 计算相位值
                t=0:N-1;
                t=(t-u)/s; % 进行伸缩平移变换
                g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t+w); % 伸缩平移和调制
                ga((j+1)*(p+1)*(k+1)*(i+1),1:N)=g/sqrt(sum(g.*g)); % 作归一化
            end
            %%%%快速原子库
%             for i=i_min:i_max
%                 s=a_base^j; % 计算伸缩的值，2为基底
%                 u=p*s*u_base; % 计算平移的值
%                 v=k*(1/s)*v_base; % 计算频率值
%                 t=0:N-1;
%                 t=(t-u)/s; % 进行伸缩平移变换
%                 g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t); % 伸缩平移和调制
%                 ga((j+1)*(p+1)*(k+1)*(i+1),1:N)=g/sqrt(sum(g.*g)); % 作归一化
%             end
%             
        end
    end
end
save ga.mat





