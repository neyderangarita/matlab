function [numero_respuesta]=clasificacion3(pregunta)
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
    
   %  figure, imshow(label2rgb(L));
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
 pepe= [{propied.BoundingBox}',{propied.Centroid}'];
%[tmp ind] = sortrows([{propied.BoundingBox}',{propied.Centroid}'], [2 1]);
[tmp ind] = sortrows(pepe,2);

A = propied(ind);  
 
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
         %numero_respuesta=0;  
         numero_respuesta=max(Respuestas_Pregunta);
     else
         numero_respuesta=max(Respuestas_Pregunta);
     end 
    
    
%     for i=1:1
%        %Respuestas_Pregunta(i)
%        if Respuestas_Pregunta(i)==i && Respuestas_Pregunta(i+1)==i+1 && Respuestas_Pregunta(i+2)==i+2
%             numero_respuesta=0;
%        elseif Respuestas_Pregunta(i)==i && Respuestas_Pregunta(i+1)==i+1
%             numero_respuesta=0;
%        elseif Respuestas_Pregunta(i+1)==i+1 && Respuestas_Pregunta(i+2)==i+2
%             numero_respuesta=0;
%        elseif Respuestas_Pregunta(i)==i && Respuestas_Pregunta(i+2)==i+2
%             numero_respuesta=0;
%        else
%            numero_respuesta = max(Respuestas_Pregunta);   
%        end
%     
%     end;    
