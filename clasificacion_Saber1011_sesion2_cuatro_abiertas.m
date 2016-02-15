function [numero_respuesta]=clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta, opciones,Numero_pregunta,corte)  

% para recortar mas de las preguntas que tienen mas opciones

if corte==4
     if Numero_pregunta== 5 || Numero_pregunta== 6 || Numero_pregunta== 7 || Numero_pregunta== 8 || Numero_pregunta== 9 
        opciones = 8;
        Largo_pregunta=size(pregunta,2)/opciones;
        Alto_Pregunta=size(pregunta,1); 
     else       
        Largo_pregunta=size(pregunta,2)/2/opciones; 
        Alto_Pregunta=size(pregunta,1);   
     end
elseif corte==1
       Largo_pregunta=size(pregunta,2); 
       Alto_Pregunta=size(pregunta,1)/opciones;   
else 
     Largo_pregunta=size(pregunta,2)/opciones; 
     Alto_Pregunta=size(pregunta,1);  
end
 

   for b=1:opciones
       if b==1        
                Individuales_pregunta = imcrop(pregunta,[0 0 Largo_pregunta Alto_Pregunta]);
                Individuales_pregunta = bwareaopen(Individuales_pregunta,100);
                %figure, imshow(Individuales_pregunta);
                [L Ne]=bwlabel(Individuales_pregunta);
                if Ne==0
                    break
                else    
                    propied = regionprops(L); 
                    Estructura(b,1).Opcion =  propied;   
                end
       else
            if corte==1
                Individuales_pregunta = imcrop(pregunta,[0 (Alto_Pregunta *(b-1)) Largo_pregunta Alto_Pregunta]);
                Individuales_pregunta = bwareaopen(Individuales_pregunta,100);
                %figure, imshow(Individuales_pregunta);
                [L Ne]=bwlabel(Individuales_pregunta);
                if Ne==0
                    break
                else   
                    propied = regionprops(L); 
                    Estructura(b,1).Opcion =  propied; 
                end  
            else
                Individuales_pregunta = imcrop(pregunta,[(Largo_pregunta *(b-1)) 0 Largo_pregunta Alto_Pregunta]);
                Individuales_pregunta = bwareaopen(Individuales_pregunta,100);
                %figure, imshow(Individuales_pregunta);
                [L Ne]=bwlabel(Individuales_pregunta);
                if Ne==0
                    break
                else  
                propied = regionprops(L); 
                Estructura(b,1).Opcion =  propied;  
                end  
            end            
       end
   end
   
if Ne==0
    numero_respuesta=0;  
else  
        for i=1:length(Estructura)
            Respuestas_Pregunta(i) = Estructura(i).Opcion.Area;
             if Respuestas_Pregunta(i)<300
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
         if cont>=3
             numero_respuesta=0;         
         else 
             numero_respuesta=max(Respuestas_Pregunta);
         end
end