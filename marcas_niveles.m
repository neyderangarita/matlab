function [dilatar]=marcas_niveles(img1)  
    
    gris1 = img1;      % para sacar las marcas
    gris2 = img1;      % para sacar las preguntas como tal
    %umbral1 = 0.35;               % para sacar las marcas 
    umbral1 = 0.25;               % para sacar las marcas 
    umbral2 = 0.81;              % para sacar las preguntas como tal
    
    foto_marcas=~im2bw(gris1,umbral1);
    %figure, imshow(foto_marcas); 
    binaria2=~im2bw(gris2,umbral2); 
    marcas_filtrada = bwareaopen(foto_marcas,2100); 
    %marcas_filtrada = bwareaopen(foto_marcas,1900); 
    %marcas_filtrada = bwareaopen(foto_marcas,190); 
    %figure, imshow(marcas_filtrada); 
     
    clear  foto_marcas gris1 gris2  img1 umbral1 umbral2      
    [L Ne]=bwlabel(marcas_filtrada);  
    %figure, imshow(label2rgb(L));   
    propied = regionprops(L);    
     
for n=1:length(propied),
    centroideY(n) = propied(n).Centroid(2);
    propied(n).Centroid = centroideY(n);
end; 


pepe= [{propied.BoundingBox}',{propied.Centroid}'];
[tmp ind] = sortrows(pepe,2);
ImagenRecortar = propied(ind);  
clear centroideY pepe propied ind tmp n Ne L
clear L Ne marcas_filtrada  

 for n=1:5
     
    if n==1 
        
        xmin = ImagenRecortar(n).BoundingBox(1)+ImagenRecortar(n).BoundingBox(3) + 60;
        ymin = ImagenRecortar(n).BoundingBox(2)+ImagenRecortar(n).BoundingBox(4) + 68;
        ancho = (ImagenRecortar(n+1).BoundingBox(1) - (ImagenRecortar(n).BoundingBox(1)+ImagenRecortar(n).BoundingBox(3))) - 80;
        alto = (ImagenRecortar(n+1).BoundingBox(2)-ImagenRecortar(n).BoundingBox(2)-ImagenRecortar(n).BoundingBox(3))-75;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,        imshow(gris_crop3{n}) 
     
    elseif n==2
        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3) + 160;
        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4) + 58;
        ancho = (ImagenRecortar(n+2).BoundingBox(1) - (ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3))) - 338;
        alto = (ImagenRecortar(n+2).BoundingBox(2)-ImagenRecortar(n+1).BoundingBox(2)-ImagenRecortar(n+1).BoundingBox(3)) -70;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
      
    elseif n==3
        xmin = ImagenRecortar(n+2).BoundingBox(1)+ImagenRecortar(n+2).BoundingBox(3) + 204;
        ymin = ImagenRecortar(n+2).BoundingBox(2)+ImagenRecortar(n+2).BoundingBox(4);
        ancho = (ImagenRecortar(n+3).BoundingBox(1) - (ImagenRecortar(n+2).BoundingBox(1)+ImagenRecortar(n+2).BoundingBox(3))) - 455;
        alto = (ImagenRecortar(n+3).BoundingBox(2)-ImagenRecortar(n+2).BoundingBox(2)-ImagenRecortar(n+2).BoundingBox(3)) - 42;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n})    
     
    elseif n==4        
        xmin = ImagenRecortar(n+3).BoundingBox(1)+ImagenRecortar(n+3).BoundingBox(3) + 37;
        ymin = ImagenRecortar(n+3).BoundingBox(2)+ImagenRecortar(n+3).BoundingBox(4)+ 16;
        ancho = (ImagenRecortar(n+4).BoundingBox(1) - (ImagenRecortar(n+3).BoundingBox(1)+ImagenRecortar(n+3).BoundingBox(3))) - 81;
        alto = (ImagenRecortar(n+4).BoundingBox(2)-ImagenRecortar(n+3).BoundingBox(2)-ImagenRecortar(n+3).BoundingBox(3)) - 46;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
     
    else 
        xmin = ImagenRecortar(n+4).BoundingBox(1)+ImagenRecortar(n+4).BoundingBox(3) + 37;
        ymin = ImagenRecortar(n+4).BoundingBox(2)+ImagenRecortar(n+4).BoundingBox(4) + 31;
        ancho = (ImagenRecortar(n+5).BoundingBox(1) - (ImagenRecortar(n+4).BoundingBox(1)+ImagenRecortar(n+4).BoundingBox(3))) - 81;
        alto = (ImagenRecortar(n+5).BoundingBox(2)-ImagenRecortar(n+4).BoundingBox(2)-ImagenRecortar(n+4).BoundingBox(3)) - 63;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
    end  
     
 end  
 
  for n=1:5    
    dilatar{n}= bwareaopen(gris_crop3{n},150); 
    %figure, imshow(dilatar{n});
  end,         
clear recortada binaria2 n se propied recortada gris_crop3