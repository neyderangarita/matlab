function [dilatar]=marcas_saber(img1)
%imshow(img1);
% gris1 = img1;      % para sacar las marcas
 gris2 = img1;      % para sacar las preguntas como tal
%umbral1 = 0.50;               % para sacar las marcas  
umbral2 = 0.81;              % para sacar las preguntas como tal
%foto_marcas=~im2bw(gris1,umbral1);
binaria2=~im2bw(gris2,umbral2);
%figure, imshow(binaria2);
% marcas_filtrada = bwareaopen(foto_marcas,500); 
% x: 125
% y: 312
% x: 732
% y: 310
%umbral1 = 0.30;               % para sacar las marcas  
%umbral2 = 0.87;              % para sacar las preguntas como tal
%foto_marcas=~im2bw(gris1,umbral1);
%binaria2=~im2bw(gris2,umbral2);
%marcas_filtrada = bwareaopen(foto_marcas,300); 
% figure, imshow(marcas_filtrada);    
%   figure, imshow(binaria2);
%clear  foto_marcas gris1 gris2  img1 umbral1 umbral2      
%[L Ne]=bwlabel(marcas_filtrada); 
   %figure, imshow(label2rgb(L));  
%propied = regionprops(L);     
%  hold on 
% DESDE EL CENTROIDE 
%  rectangle('Position',propied(1).BoundingBox,'EdgeColor','g','LineWidth',2)
% rectangle('Position',[propied(1).Centroid(1) ,propied(1).Centroid(2) ,(propied(3).Centroid(1)-propied(1).Centroid(1)) ,(propied(3).Centroid(2)-propied(1).Centroid(2))] ,'EdgeColor','g','LineWidth',2)
%  figure, imshow(binaria2);
%  rectangle('Position',[propied(1).Centroid(1) ,propied(1).Centroid(2)
%  ,(propied(3).Centroid(1)-propied(1).Centroid(1))
%  ,(propied(3).Centroid(2)-propied(1).Centroid(2))] ,'EdgeColor','g','LineWidth',2)
% RECORTAR LA IMAGEN
%  gris_crop3 =
%  imcrop(binaria2,[(propied(1).BoundingBox(1)+propied(1).BoundingBox(3))+55 ,propied(1).BoundingBox(2)+propied(1).BoundingBox(4) ,(propied(3).BoundingBox(1) - (propied(1).BoundingBox(1)+propied(1).BoundingBox(3))) - 120  , ( propied(3).BoundingBox(2)-propied(1).BoundingBox(2)-propied(1).BoundingBox(3) ) ]);
%  figure, imshow(gris_crop3);
% gris_crop3 = imcrop(binaria2,[(propied(1).BoundingBox(1)+propied(1).BoundingBox(3))+55 ,propied(1).BoundingBox(2)+propied(1).BoundingBox(4) ,(propied(5).BoundingBox(1) - (propied(1).BoundingBox(1)+propied(1).BoundingBox(3))) - 120  , ( propied(5).BoundingBox(2)-propied(1).BoundingBox(2)-propied(1).BoundingBox(3) ) ]);  
% figure, imshow(gris_crop3); 
%clear L Ne marcas_filtrada  
% figure, imshow(binaria2) 
 for n=1:5   
     if n==1
        gris_crop3{n} = imcrop(binaria2,[139,327,138+445,108]);     
        %figure,imshow(gris_crop3{n})
     elseif n==2
        gris_crop3{n} = imcrop(binaria2,[140,480,138+445,108]);     
        %figure,imshow(gris_crop3{n})
     elseif n==3
        gris_crop3{n} = imcrop(binaria2,[140,625,138+445,108]);     
        %figure,imshow(gris_crop3{n})
     elseif n==4   
        gris_crop3{n} = imcrop(binaria2,[141,770,138+445,108]);     
        %figure,imshow(gris_crop3{n})
     else
        gris_crop3{n} = imcrop(binaria2,[576,80,130,200]);     
        %figure,imshow(gris_crop3{n})
     end 
 end   
 %n=5;  
 %gris_crop3{n} = imcrop(binaria2,[( propied(n).BoundingBox(1)+propied(n).BoundingBox(3))+(propied(n).BoundingBox(3)/2)-3 ,propied(n).BoundingBox(2) + propied(1).BoundingBox(4),(propied(n+5).BoundingBox(1) - (propied(n).BoundingBox(1) + propied(n).BoundingBox(3))) - propied(n).BoundingBox(3)  , ( propied(n+5).BoundingBox(2)-propied(n).BoundingBox(2)-propied(n).BoundingBox(3))]);
 %imshow(gris_crop3{n})   
 for n=1:5   
    %imshow(gris_crop3{n})
    %recortada{n} = bwareaopen(gris_crop3{n},70);
    dilatar{n}= bwareaopen(gris_crop3{n},20);
    %figure, imshow(dilatar{n});
 end,  
 %n=5;  
 %    dilatar{n}= bwareaopen(gris_crop3{n},30); 
     %figure, imshow(dilatar{n});
     
%  se=strel('line',4,0);
%  for n=1:4 
%  dilatar{n} = imdilate( recortada{n},se);
%   figure, imshow(dilatar{n});
%   end,
clear  binaria2 n  