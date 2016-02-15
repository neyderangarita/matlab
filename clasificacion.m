function [numero_respuesta]=clasificacion(pregunta)
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

for n=1:length(propied),
    centroide(n) = propied(n).Centroid(2);
end;

for q=1:length(propied),
    propied(q).Centroid = centroide(q);
end;

 pepe= [{propied.BoundingBox}',{propied.Centroid}'];
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
         numero_respuesta=0;         
     else 
         numero_respuesta=max(Respuestas_Pregunta);
     end


