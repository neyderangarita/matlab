function [pregunta] = recortar_columna_pregunta(columnas_preguntas,dilatar,i,b)
%%%%%%%%%%%%%%%%%%%%%%%%%  recortar por columnas %%%%%%%%%%%%%%%%%%%%%%%%
%figure, imshow(dilatar{i});
% columnas_preguntas{i}(1).BoundingBox(1)
% columnas_preguntas{i}(1).BoundingBox(3)
% columnas_preguntas{i}(1).BoundingBox(2)
% columnas_preguntas{i}(1).BoundingBox(4)
% columnas_preguntas{i}(1).BoundingBox
pregunta = imcrop(dilatar{i},columnas_preguntas{i}(b).BoundingBox);     
%    pregunta =
%    imcrop(dilatar{i},[(columnas_preguntas(n).BoundingBox(1)+columnas_preg
%    untas(n).BoundingBox(3)) ,columnas_preguntas(n).BoundingBox(2)+columnas_preguntas(1).BoundingBox(4) ,30, 50]);  
%figure, imshow(pregunta);
 
