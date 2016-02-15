function [dilatar_sesion]=marcas_sesion(img1)
gris2 = img1;      % para sacar las preguntas como tal
umbral1 = 0.50;               % para sacar las marcas 
umbral2 = 0.81;              % para sacar las preguntas como tal

foto_marcas=~im2bw(gris2,umbral1);
binaria2=~im2bw(gris2,umbral2); 
marcas_filtrada = bwareaopen(foto_marcas,190); 
%figure, imshow(marcas_filtrada);
clear  foto_marcas gris1 gris2  img1 umbral1 umbral2      
[L Ne]=bwlabel(marcas_filtrada); 
propied = regionprops(L);     
for n=1:length(propied),
    centroideY(n) = propied(n).Centroid(2);
    %centroideX(n) = propied(n).Centroid(1);
    %Estructura(n,1).Desorden =  propied(n).Centroid; 
    propied(n).Centroid = centroideY(n);
end; 
 pepe= [{propied.BoundingBox}',{propied.Centroid}'];
[tmp ind] = sortrows(pepe,2);
ImagenRecortar = propied(ind);  
clear centroideY pepe propied ind tmp n Ne L
 for n=1:1   
     if n==1 
        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3) + 78;
        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4);
        ancho = (ImagenRecortar(n+2).BoundingBox(1) - (ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3))) - 78 -50;
        alto = (ImagenRecortar(n+2).BoundingBox(2)-ImagenRecortar(n+1).BoundingBox(2));
        %ancho = (ImagenRecortar(n+1).BoundingBox(1) - (ImagenRecortar(n).BoundingBox(1)+ImagenRecortar(n).BoundingBox(3)));
        %alto = (ImagenRecortar(n+1).BoundingBox(2)-ImagenRecortar(n).BoundingBox(2)-ImagenRecortar(n).BoundingBox(3));  
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
     end 
 end    
%  for n=1:1   
%      if n==1
%         gris_crop3{n} = imcrop(binaria2,[285,262,130,20]);     
%         %figure,imshow(gris_crop3{n})
%      end 
%  end 
 for n=1:1   
    dilatar_sesion{n}= bwareaopen(gris_crop3{n},30);
    %figure, imshow(dilatar_sesion{n});
 end,  
clear  binaria2 n 