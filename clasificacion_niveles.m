function [numero_respuesta]=clasificacion_niveles(pregunta, opciones,Numero_pregunta,corte)   
% para recortar mas de las preguntas que tienen mas opciones
if corte==3
     if Numero_pregunta== 1 || Numero_pregunta== 3 || Numero_pregunta== 5 || Numero_pregunta== 7 || Numero_pregunta== 9 || Numero_pregunta== 11 || Numero_pregunta== 13 
        opciones = 5;
        Largo_pregunta=size(pregunta,2);
        Alto_Pregunta=size(pregunta,1)/opciones; 
     else       
        Largo_pregunta=size(pregunta,2);
        Alto_Pregunta=(size(pregunta,1)-106)/opciones;   
     end     
else
     Largo_pregunta=size(pregunta,2); 
     Alto_Pregunta=size(pregunta,1)/opciones;     
end
 
   for b=1:opciones
       if b==1        
            Individuales_pregunta = imcrop(pregunta,[0 0 Largo_pregunta Alto_Pregunta]);
            Individuales_pregunta = bwareaopen(Individuales_pregunta,20);
            %figure, imshow(Individuales_pregunta);
            [L Ne]=bwlabel(Individuales_pregunta);
            propied = regionprops(L); 
            Estructura(b,1).Opcion =  propied;   
       else
            Individuales_pregunta = imcrop(pregunta,[0 (Alto_Pregunta *(b-1)) Largo_pregunta Alto_Pregunta]);
            Individuales_pregunta = bwareaopen(Individuales_pregunta,23);
            %figure, imshow(Individuales_pregunta); 
            [L Ne]=bwlabel(Individuales_pregunta);
            propied = regionprops(L); 
            Estructura(b,1).Opcion =  propied;  
       end
   end 
     
   if corte==1
           
       for i=1:length(Estructura)
         Respuestas_Pregunta(i) = Estructura(i).Opcion.Area;
         if Respuestas_Pregunta(i)<500 
            Respuestas_Pregunta(i)=0;       
         else
            Respuestas_Pregunta(i)=i;
         end 
       end;
   else
        
    for i=1:length(Estructura)
         Respuestas_Pregunta(i) = Estructura(i).Opcion.Area;
         if Respuestas_Pregunta(i)<910 
            Respuestas_Pregunta(i)=0;       
         else
            Respuestas_Pregunta(i)=i;
         end 
    end; 
       
   end  
        
     cont=0;
     for i=1:length(Estructura)
         if Respuestas_Pregunta(i)~=0
            cont=cont+1;
         end     
     end
     %para saber si contesto mas de una respuesta en tal caso 
     %se deja un cero
     if cont>=2
         numero_respuesta=0;         
     else 
         numero_respuesta=max(Respuestas_Pregunta);
     end