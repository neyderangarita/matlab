function [dilatar]=marcas_saber1011_cuatro_abiertas_sesion2(img1)
 
    gris1 = img1;      % para sacar las marcas
    gris2 = img1;      % para sacar las preguntas como tal
    umbral1 = 0.18;               % para sacar las marcas 
    umbral2 = 0.73;             % para sacar las preguntas como tal
    foto_marcas=~im2bw(gris1,umbral1);
    
binaria2=~im2bw(gris2,umbral2); 
%figure, imshow(binaria2);
marcas_filtrada = bwareaopen(foto_marcas,700);  
clear  foto_marcas gris1 gris2  img1 umbral1 umbral2      
[L Ne]=bwlabel(marcas_filtrada);  
%figure, imshow(label2rgb(L));  
propied = regionprops(L);       
%figure, imshow(marcas_filtrada);  
  
for n=1:length(propied), 
    centroideY(n) = propied(n).Centroid(1) + propied(n).Centroid(2);
    propied(n).Centroid = centroideY(n);
end; 
 pepe= [{propied.BoundingBox}',{propied.Centroid}'];
[tmp ind] = sortrows(pepe,2);
ImagenRecortar = propied(ind);        
clear centroideY pepe propied ind tmp n Ne L 
 
 for n=1:7
     if n==1 
        xmin = ImagenRecortar(n+3).BoundingBox(1)+ImagenRecortar(n+3).BoundingBox(3)+15;
        ymin = ImagenRecortar(n+3).BoundingBox(2)+ImagenRecortar(n+3).BoundingBox(4);
        ancho =  277; 
        alto =  312;
        %ancho = 84; 
        %alto =  588;
        %ancho = (ImagenRecortar(n+1).BoundingBox(1) - ImagenRecortar(n).BoundingBox(1) - ImagenRecortar(n).BoundingBox(3)- ImagenRecortar(n).BoundingBox(3));
        %alto = (ImagenRecortar(n+1).BoundingBox(2)-ImagenRecortar(n).BoundingBox(2)-ImagenRecortar(n).BoundingBox(4));
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
      elseif n==2
        xmin = ImagenRecortar(n).BoundingBox(1) + ImagenRecortar(n).BoundingBox(3) + 2;
        ymin = ImagenRecortar(n).BoundingBox(2) + ImagenRecortar(n).BoundingBox(4) + 8;
        ancho = 161;
        alto =  1183;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n})  
     elseif n==3
        xmin = ImagenRecortar(n).BoundingBox(1) + ImagenRecortar(n).BoundingBox(3) + 2;
        ymin = ImagenRecortar(n).BoundingBox(2) + ImagenRecortar(n).BoundingBox(4) + 8;
        ancho = 161; 
        alto =  1183;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
     elseif n==4         
        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3)+ 2;
        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4)+ 8;
        ancho = 330;
        alto =  1183;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
     elseif n==5
        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3)+ 3;
        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4)+ 8;
        ancho = 160;
        alto =  1183;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n})  
     elseif n==6
        xmin = ImagenRecortar(n+5).BoundingBox(1)+ImagenRecortar(n+5).BoundingBox(3)-3;
        ymin = ImagenRecortar(n+5).BoundingBox(2)+ImagenRecortar(n+5).BoundingBox(4);
        ancho = 162;
        alto =  139; 
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
        %elseif n==7
        %xmin = ImagenRecortar(n+5).BoundingBox(1)+ImagenRecortar(n+5).BoundingBox(3)-3;
        %ymin = ImagenRecortar(n+5).BoundingBox(2)+ImagenRecortar(n+5).BoundingBox(4);
        %ancho = 162;
        %alto =  36;
        %gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
    end  
 end   
   
 for n=1:6  
    dilatar{n}= bwareaopen(gris_crop3{n},25);
    %figure, imshow(dilatar{n});
 end,     
  
clear  binaria2 n ymin xmin recortada n marcas_filtrada gris_crop3 ancho ImagenRecortar      