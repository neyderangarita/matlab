function [pregunta] = recortar_columna_pregunta_sin_area( dilatar, b, recorte, Largo_pregunta, Ancho_Pregunta)
%%%%%%%%%%%%%%%%%%%%%%%%%  recortar por columnas %%%%%%%%%%%%%%%%%%%%%%%%
%figure, imshow(dilatar{i});
% columnas_preguntas{i}(1).BoundingBox(1)
% columnas_preguntas{i}(1).BoundingBox(3)
% columnas_preguntas{i}(1).BoundingBox(2)  
% columnas_preguntas{i}(1).BoundingBox(4)
% columnas_preguntas{i}(1).BoundingBox
if recorte==1
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);     
    else
        pregunta = imcrop(dilatar{recorte},[(Largo_pregunta *(b-1)) 0 Largo_pregunta Ancho_Pregunta]);
        %pregunta = imcrop(dilatar{recorte},[(Largo_pregunta) 0 Largo_pregunta Ancho_Pregunta]);
    end 
else
    if b==1
         pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);     
        %figure, imshow(pregunta);
    elseif b > 9
        pregunta = imcrop(dilatar{recorte},[0 (Ancho_Pregunta *(b-1))-7 Largo_pregunta Ancho_Pregunta]);
        %figure, imshow(pregunta); 
    else
        pregunta = imcrop(dilatar{recorte},[0 (Ancho_Pregunta *(b-1)) Largo_pregunta Ancho_Pregunta]);
        %figure, imshow(pregunta);
    end 
end    

    
%    pregunta =
%    imcrop(dilatar{i},[(columnas_preguntas(n).BoundingBox(1)+columnas_preg
%    untas(n).BoundingBox(3)) ,columnas_preguntas(n).BoundingBox(2)+columnas_preguntas(1).BoundingBox(4) ,30, 50]);  
%figure, imshow(pregunta);
clear b   