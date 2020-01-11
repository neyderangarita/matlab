function [pregunta] = recortar_columna_pregunta_misaber_aprueba( dilatar, b, recorte, Largo_pregunta, Ancho_Pregunta)
%%%%%%%%%%%%%%%%%%%%%%%%%  recortar por columnas %%%%%%%%%%%%%%%%%%%%%%%%
%figure, imshow(dilatar{i});

if recorte==1 
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);     
    else
        pregunta = imcrop(dilatar{recorte},[(Largo_pregunta *(b-1)) 0 Largo_pregunta Ancho_Pregunta]);
    end 
    %figure, imshow(pregunta); 
elseif recorte == 2 || recorte == 3 || recorte == 5
    
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);     
        %figure, imshow(pregunta);
    else
        pregunta = imcrop(dilatar{recorte},[0 (Ancho_Pregunta *(b-1)) Largo_pregunta Ancho_Pregunta]);
        %figure, imshow(pregunta);
    end
    
elseif recorte == 4    
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Largo_pregunta Ancho_Pregunta]);     
        %figure, imshow(pregunta);
    else
        pregunta = imcrop(dilatar{recorte},[0 (Ancho_Pregunta *(b-1)) Largo_pregunta Ancho_Pregunta]);
        %figure, imshow(pregunta);     
    end
else
    
end    

clear b   