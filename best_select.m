function [proj,scale,translation,freq,phase]=best_select(signal_r,N,a_base,j_min,j_max,u_base,p_min,v_base,k_min,w_base,i_min,i_max); 

%function [输出] = 函数（输入）

% the signal_r: 剩余的待分解信号
% N：原子的长度
% proj: 在最佳原子基上的剩余信号
% the scale: 最佳原子基的伸缩 (s in the formula) 
% the translation : 最佳原子基的平移(u in the formula) 
% the freq: 最佳原子基的频率(v in the formula) 
% phase: 最佳原子基的相位(w in the formula) 
% proj_trans ：判断哪个结果是最好的

trans=0; 
proj=0; 
  %%%%%   16  ---- 31 为建立Gabor原子库
  
for j=j_min:j_max 
   for p=p_min:N*2^(-j+1) 
      for k=k_min:2^(j+1) 
         for i=i_min:i_max 
            s=a_base^j; % 计算伸缩的值，2为基底 
            u=p*s*u_base; % 计算平移的值
            v=k*(1/s)*v_base; % 计算频率值
            w=i*w_base; % 计算相位值
            t=0:N-1;
            t=(t-u)/s; % 进行伸缩平移变换
            
            %%%完备原子库
            g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t+w); % 伸缩平移和调制
            
            g=g/sqrt(sum(g.*g)); % 归一化
             
            trans=sum(signal_r.*g); % 生成重建信号
            
            
             % 判断重建信号是否是最佳（如果是则将相应参数值赋给相应变量）
            if abs(trans)>abs(proj) 
               proj=trans; 
               scale=s; 
               translation=u; 
               freq=v; 
               phase=w; 
            end 
         end 
     %             %%%%快速原子库    
%          for i=i_min:i_max 
%             s=a_base^j; % 计算伸缩的值，2为基底 
%             u=p*s*u_base; % 计算平移的值
%             v=k*(1/s)*v_base; % 计算频率值
%             w=i*w_base; % 计算相位值
%             t=0:N-1;
%             t=(t-u)/s; % 进行伸缩平移变换

%             g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t); % 伸缩平移和调制
%             g=g/sqrt(sum(g.*g)); % 归一化 
%             trans=sum(signal_r.*g); % 生成重建信号
%              % 判断重建信号是否是最佳（如果是则将相应参数值赋给相应变量）
%             if abs(trans)>abs(proj) 
%                proj=trans; 
%                scale=s; 
%                translation=u; 
%                freq=v; 
%                phase=w; 
%             end 
%          end 
      end 
   end 
end 