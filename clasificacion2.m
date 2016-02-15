  function [numero_respuesta]=clasificacion2(pregunta,b)
% figure, imshow(pregunta);
% [f c]=find(pregunta);
%        lmaxc=max(c);
%        lminc=min(c);
%        lmaxf=max(f);
%        lminf=min(f);
%        recortada=pregunta(lminf:lmaxf,lminc:lmaxc);  
% figure, imshow(recortada);
    clear c f lminf lmaxf lminc lmaxc      
    [L Ne]=bwlabel(pregunta);
    %[L Ne]=bwlabel(columna_pregunta);
    
%     figure, imshow(label2rgb(L));
    propied = regionprops(L);   
    %imshow(L)
%     hold on   
%     for n=1:size(propied,1)
%         rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
%         x = propied(n).Centroid(1);
%         y = propied(n).Centroid(2);
%         plot(x,y,'*')
%     end  
%      pause(2)

%for n=1:size(propied,1)
%         y(n) = propied(n).Centroid(2);
%         %areas(n) = propied(n).Area;
%     end
%     ordenado = sort(y);
% [tmp ind] = sortrows([{propied.BoundingBox}',{propied.Centroid(2)}'], [2 1]);
% A = propied(ind); 
% newstruct = propied.Area;

for n=1:length(propied),
    centroide(n) = propied(n).Centroid(2);
end;

for q=1:length(propied),
    propied(q).Centroid = centroide(q);
end;
   
%[tmp ind] = sortrows([{propied.BoundingBox}',{propied.Centroid}'], [2 1]);
[tmp ind] = sortrows([{propied.BoundingBox}',{propied.Centroid}'], 2);

A = propied(ind);  
once = '';

if b==5
    for i=1:length(A) 
        pregunta_once(i) = A(i).Area;
         if pregunta_once(i)<135
            %pregunta_once(i)=0;       
         else 
            pregunta_once=i;  
            AUX1 = once;   
            once = [AUX1 num2str(pregunta_once)];
         end   
    end;
     once = str2double(once);  
     numero_respuesta = once;    
  
else 
     for i=1:length(A)
         Respuestas_Pregunta(i) = A(i).Area;
          if Respuestas_Pregunta(i)<135
             Respuestas_Pregunta(i)=0;       
          else 
             Respuestas_Pregunta(i)=i;
          end
     end;
     cont=0;
     for i=1:length(A)
         if Respuestas_Pregunta(i)~=0
            cont=cont+1;
         end     
     end
     
     if cont>=2
         numero_respuesta=0;         
     else
         numero_respuesta=max(Respuestas_Pregunta);
     end
end
    

 
    

