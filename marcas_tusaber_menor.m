function [dilatar]=marcas_tusaber_menor(img1)
    gris1 = img1;      % para sacar las marcas
    gris2 = img1;      % para sacar las preguntas como tal
    umbral1 = 0.18;               % para sacar las marcas 
    umbral2 = 0.73;              % para sacar las preguntas como tal
    
foto_marcas=~im2bw(gris1,umbral1);
binaria2=~im2bw(gris2,umbral2); 
%figure, imshow(binaria2);
marcas_filtrada = bwareaopen(foto_marcas,750); 
clear  foto_marcas gris1 gris2  img1 umbral1 umbral2      
[L Ne]=bwlabel(marcas_filtrada);  
%figure, imshow(label2rgb(L));   
propied = regionprops(L);    
%figure, imshow(marcas_filtrada);   
format shortG 
for n=1:length(propied), 
    centroideY(n) = propied(n).Centroid(2) + propied(n).Centroid(1);
    propied(n).Centroid = centroideY(n);
end; 
 pepe= [{propied.BoundingBox}',{propied.Centroid}'];
[tmp ind] = sortrows(pepe,2);
ImagenRecortar = propied(ind);    
clear centroideY pepe propied ind tmp n Ne L
format shortG

 for n=1:2  
    if n==1 
        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3) +15;
        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4);
        ancho = ImagenRecortar(n+2).BoundingBox(1) - ImagenRecortar(n+1).BoundingBox(1) - (ImagenRecortar(n+1).BoundingBox(3) *2 ) + 4; 
        alto = ImagenRecortar(n+2).BoundingBox(2) - ImagenRecortar(n+1).BoundingBox(3) - ImagenRecortar(n+1).BoundingBox(3); 
        %ancho =  266 + 9; 
        %alto =  302 + 9;  
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]); 
        %figure,imshow(gris_crop3{n})
     elseif n==2     
        xmin = ImagenRecortar(n-1).BoundingBox(1) + ImagenRecortar(n-1).BoundingBox(3) - 35;
        ymin = ImagenRecortar(n-1).BoundingBox(2) + ImagenRecortar(n-1).BoundingBox(4) + 34;
        ancho = ImagenRecortar(n+2).BoundingBox(1) - ImagenRecortar(n-1).BoundingBox(1) + 16;
        alto =  ImagenRecortar(n+2).BoundingBox(2) - ImagenRecortar(n-1).BoundingBox(2) - (ImagenRecortar(n-1).BoundingBox(4) * 3);  
        %ancho = 1046 + 45; 
        %alto =  321 + 15; 
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n})  
    end;   
 end; 
 
 for n=1:2
    dilatar{n}= bwareaopen(gris_crop3{n}, 25);
    %figure, imshow(dilatar{n}); 
 end,    
clear  binaria2 n ymin xmin recortada n marcas_filtrada gris_crop3 ancho ImagenRecortar   