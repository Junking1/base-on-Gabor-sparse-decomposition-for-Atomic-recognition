function [proj,scale,translation,freq,phase]=best_select(signal_r,N,a_base,j_min,j_max,u_base,p_min,v_base,k_min,w_base,i_min,i_max); 

%function [���] = ���������룩

% the signal_r: ʣ��Ĵ��ֽ��ź�
% N��ԭ�ӵĳ���
% proj: �����ԭ�ӻ��ϵ�ʣ���ź�
% the scale: ���ԭ�ӻ������� (s in the formula) 
% the translation : ���ԭ�ӻ���ƽ��(u in the formula) 
% the freq: ���ԭ�ӻ���Ƶ��(v in the formula) 
% phase: ���ԭ�ӻ�����λ(w in the formula) 
% proj_trans ���ж��ĸ��������õ�

trans=0; 
proj=0; 
  %%%%%   16  ---- 31 Ϊ����Gaborԭ�ӿ�
  
for j=j_min:j_max 
   for p=p_min:N*2^(-j+1) 
      for k=k_min:2^(j+1) 
         for i=i_min:i_max 
            s=a_base^j; % ����������ֵ��2Ϊ���� 
            u=p*s*u_base; % ����ƽ�Ƶ�ֵ
            v=k*(1/s)*v_base; % ����Ƶ��ֵ
            w=i*w_base; % ������λֵ
            t=0:N-1;
            t=(t-u)/s; % ��������ƽ�Ʊ任
            
            %%%�걸ԭ�ӿ�
            g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t+w); % ����ƽ�ƺ͵���
            
            g=g/sqrt(sum(g.*g)); % ��һ��
             
            trans=sum(signal_r.*g); % �����ؽ��ź�
            
            
             % �ж��ؽ��ź��Ƿ�����ѣ����������Ӧ����ֵ������Ӧ������
            if abs(trans)>abs(proj) 
               proj=trans; 
               scale=s; 
               translation=u; 
               freq=v; 
               phase=w; 
            end 
         end 
     %             %%%%����ԭ�ӿ�    
%          for i=i_min:i_max 
%             s=a_base^j; % ����������ֵ��2Ϊ���� 
%             u=p*s*u_base; % ����ƽ�Ƶ�ֵ
%             v=k*(1/s)*v_base; % ����Ƶ��ֵ
%             w=i*w_base; % ������λֵ
%             t=0:N-1;
%             t=(t-u)/s; % ��������ƽ�Ʊ任

%             g=(1/sqrt(s))*exp(-pi*t.*t).*cos(v*t); % ����ƽ�ƺ͵���
%             g=g/sqrt(sum(g.*g)); % ��һ�� 
%             trans=sum(signal_r.*g); % �����ؽ��ź�
%              % �ж��ؽ��ź��Ƿ�����ѣ����������Ӧ����ֵ������Ӧ������
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