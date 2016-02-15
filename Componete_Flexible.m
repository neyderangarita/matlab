function [componente]=Componete_Flexible(pregunta, opciones)  
   
     Largo_pregunta=size(pregunta,2)/opciones;
     Alto_Pregunta=size(pregunta,1);   
     
   for b=1:opciones
       if b==1         
            Individuales_pregunta = imcrop(pregunta,[0 0 Largo_pregunta Alto_Pregunta]);
            Individuales_pregunta = bwareaopen(Individuales_pregunta,20);
            %figure, imshow(Individuales_pregunta);
            [L Ne]=bwlabel(Individuales_pregunta);
            propied = regionprops(L); 
            Estructura(b,1).Opcion =  propied;   
   
       else
            Individuales_pregunta = imcrop(pregunta,[(Largo_pregunta *(b-1)) 0 Largo_pregunta Alto_Pregunta]);
            Individuales_pregunta = bwareaopen(Individuales_pregunta,20);
            %figure, imshow(Individuales_pregunta); 
            [L Ne]=bwlabel(Individuales_pregunta);
            propied = regionprops(L); 
            Estructura(b,1).Opcion =  propied;  
       end
   end
    
   for i=1:length(Estructura)
        Respuestas_Pregunta(i) = Estructura(i).Opcion.Area;
         if Respuestas_Pregunta(i)<100
            Respuestas_Pregunta(i)=0;       
         else
            Respuestas_Pregunta(i)=i;
         end 
   end;  
 
     cont=0;
     for i=1:length(Estructura)
         if Respuestas_Pregunta(i)~=0
            cont=cont+1;
         end     
     end
     %para saber si contesto mas de una respuesta en tal caso 
     %se deja un cero 
     if cont>=2
         componente=0;         
     else 
         componente=max(Respuestas_Pregunta);
     end
