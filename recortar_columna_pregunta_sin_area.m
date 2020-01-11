function [pregunta] = recortar_columna_pregunta_sin_area( dilatar, b, recorte, Largo_pregunta, Ancho_Pregunta)
%%%%%%%%%%%%%%%%%%%%%%%%%  recortar por columnas %%%%%%%%%%%%%%%%%%%%%%%%


if recorte==1
    
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);     
    else
        pregunta = imcrop(dilatar{recorte},[(Largo_pregunta *(b-1)) 0 Largo_pregunta Ancho_Pregunta]);
    end 

   % figure, imshow(pregunta); 
else
    
    if b==1
         pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);     
        %figure,         imshow(pregunta);
    elseif b > 9
        pregunta = imcrop(dilatar{recorte},[0 (Ancho_Pregunta *(b-1))-7 Largo_pregunta Ancho_Pregunta]);
        %figure, 
        %imshow(pregunta); 
    else
        pregunta = imcrop(dilatar{recorte},[0 (Ancho_Pregunta *(b-1)) Largo_pregunta Ancho_Pregunta]);
        %figure, 
        %imshow(pregunta);
    end 
     
end    

clear b  S 