function [pregunta] = recortar_columna_pregunta_tusaber( dilatar, b, recorte, Largo_pregunta, Ancho_Pregunta)
%%%%%%%%%%%%%%%%%%%%%%%%%  recortar por columnas %%%%%%%%%%%%%%%%%%%%%%%%
if recorte==1
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);  
        %figure, imshow(pregunta);
    else
        pregunta = imcrop(dilatar{recorte},[(Largo_pregunta *(b-1)) 0 Largo_pregunta Ancho_Pregunta]);
        %figure, imshow(pregunta);
    end; 
else
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);
        %figure, imshow(pregunta);
    else
        pregunta = imcrop(dilatar{recorte},[(Largo_pregunta *(b-1)) 0  Largo_pregunta Ancho_Pregunta]);
        %figure, imshow(pregunta);
    end;  
end;
clear b   