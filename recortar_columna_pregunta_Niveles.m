function [pregunta] = recortar_columna_pregunta_Niveles( dilatar, b, recorte, Alto_Pregunta, Ancho_Pregunta, Ancho_total)
%%%%%%%%%%%%%%%%%%%%%%%%%  recortar por columnas %%%%%%%%%%%%%%%%%%%%%%%%
%b: representa la posicion de cada una de las preguntas 

if recorte==2   
    if b==1  
        pregunta = imcrop(dilatar{recorte},[0 0 Ancho_Pregunta Alto_Pregunta]);  
        %figure, imshow(pregunta)
    elseif b==2  
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==3
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 25 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==4
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 25 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==5
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 49 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==6
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==7
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+24 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)             
    elseif b==8
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+24 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)            
    elseif b==9
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+(24*2) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==10
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+(23*2) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==11
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+(22*3) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==12 
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+(22*3) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==13
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+(23*4) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==14
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 47+(23*4) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==15
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+(23*5) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==16
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 48+(23*5) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)       
    end 
elseif recorte==3
    if b==1  
        pregunta = imcrop(dilatar{recorte},[0 0 Ancho_Pregunta Alto_Pregunta]);  
        %figure, imshow(pregunta)
    elseif b==2  
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 1 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==3
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 15 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==4
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 17 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==5
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==6
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 38 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==7
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+30 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)             
    elseif b==8
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+30 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)            
    elseif b==9
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+(23*2) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==10
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+(24*2) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==11
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+(23*3) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==12 
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+(23*3) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==13
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+(23*4) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==14
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) + 37+(23*4) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    end      
% porque no estan alineados y se jode
elseif recorte==4
    if b==1  
        pregunta = imcrop(dilatar{recorte},[0 0 Ancho_Pregunta Alto_Pregunta]);  
        %figure, imshow(pregunta)
    elseif b==2  
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==3
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-4 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==4
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-6 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==5
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-8 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==6
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-8  0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==7
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-10 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)             
    elseif b==8
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-12 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)            
    elseif b==9
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-13 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)
    elseif b==10
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-16 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==11
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-16 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==12 
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-12 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==13
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-13 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)    
    elseif b==14
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-11 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)  
    elseif b==15
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-10 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta) 
    elseif b==16
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-6 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta) 
    elseif b==17
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-6 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta) 
    elseif b==18
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-6 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta) 
    elseif b==19
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-5 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)         
    elseif b==20
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-2 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)         
    elseif b==21
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1))-2 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)         
    elseif b==22
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) 0 Ancho_Pregunta Alto_Pregunta]);    
        %figure, imshow(pregunta)         
    end  
else  
    if b==1
        pregunta = imcrop(dilatar{recorte},[0 0 Ancho_Pregunta Alto_Pregunta]);     
        %figure, imshow(pregunta)
    else
        pregunta = imcrop(dilatar{recorte},[(Ancho_Pregunta *(b-1)) 0 Ancho_Pregunta Alto_Pregunta]);
        %figure, imshow(pregunta)
    end   
end

clear b