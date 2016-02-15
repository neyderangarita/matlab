function [dilatar]=marcas_saber1011(img1)

    gris1 = img1;      % para sacar las marcas
    gris2 = img1;      % para sacar las preguntas como tal
    umbral1 = 0.30;               % para sacar las marcas 
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
        xmin = ImagenRecortar(n).BoundingBox(1) + ImagenRecortar(n).BoundingBox(3);
        ymin = ImagenRecortar(n).BoundingBox(2) + ImagenRecortar(n).BoundingBox(4) + 8;
        ancho = 333;
        alto =  1180;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n})  
     elseif n==3
        xmin = ImagenRecortar(n).BoundingBox(1) + ImagenRecortar(n).BoundingBox(3) + 2;
        ymin = ImagenRecortar(n).BoundingBox(2) + ImagenRecortar(n).BoundingBox(4) + 8;
        ancho = 162;
        alto =  1180;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
     elseif n==4        
        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3)+ 2;
        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4)+ 8;
        ancho = 162;
        alto =  1180;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
     elseif n==5
        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3)+ 3;
        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4)+ 8;
        ancho = 162;
        alto =  1180;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n})  
     elseif n==6
        xmin = ImagenRecortar(n+5).BoundingBox(1)+ImagenRecortar(n+5).BoundingBox(3)-3;
        ymin = ImagenRecortar(n+5).BoundingBox(2)+ImagenRecortar(n+5).BoundingBox(4);
        ancho = 162;
        alto =  36; 
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
     elseif n==7
        xmin = ImagenRecortar(n+5).BoundingBox(1)+ImagenRecortar(n+5).BoundingBox(3)-3;
        ymin = ImagenRecortar(n+5).BoundingBox(2)+ImagenRecortar(n+5).BoundingBox(4);
        ancho = 162;
        alto =  36;
        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
    end  
 end  
 
 for n=1:7  
    dilatar{n}= bwareaopen(gris_crop3{n},25);
    %figure, imshow(dilatar{n});
 end,    
  
clear  binaria2 n ymin xmin recortada n marcas_filtrada gris_crop3 ancho ImagenRecortar   


%    gris1 = img1;      % para sacar las marcas
%    gris2 = img1;      % para sacar las preguntas como tal
%    umbral1 = 0.50;               % para sacar las marcas 
%    umbral2 = 0.81;              % para sacar las preguntas como tal    
%    foto_marcas=~im2bw(gris1,umbral1);
%    binaria2=~im2bw(gris2,umbral2);  
    %figure, imshow(binaria2);
    %marcas_filtrada = bwareaopen(foto_marcas,400); 
%    marcas_filtrada = bwareaopen(foto_marcas,200); 
    %figure, imshow(marcas_filtrada);

    %foto_marcas=~im2bw(gris1,umbral1); 
    %binaria2=~im2bw(gris2,umbral2);
    %marcas_filtrada = bwareaopen(foto_marcas,300); 
    % figure, imshow(marcas_filtrada);    
    %   figure, imshow(binaria2);
%    clear  foto_marcas gris1 gris2  img1 umbral1 umbral2      
%    [L Ne]=bwlabel(marcas_filtrada); 
       %figure, imshow(label2rgb(L));  
%    propied = regionprops(L);
 

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



%for n=1:length(propied),
%    centroideY(n) = propied(n).Centroid(2);
    %centroideX(n) = propied(n).Centroid(1);
    %Estructura(n,1).Desorden =  propied(n).Centroid; 
%    propied(n).Centroid = centroideY(n);
%end; 

%pepe= [{propied.BoundingBox}',{propied.Centroid}'];
%[tmp ind] = sortrows(pepe,2);
%ImagenRecortar = propied(ind);  
%clear centroideY pepe propied ind tmp n Ne L

% for n=1:6
%    if n==1 
%        xmin = ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3) + 78;
%        ymin = ImagenRecortar(n+1).BoundingBox(2)+ImagenRecortar(n+1).BoundingBox(4);
%        ancho = (ImagenRecortar(n+2).BoundingBox(1) - (ImagenRecortar(n+1).BoundingBox(1)+ImagenRecortar(n+1).BoundingBox(3))) - 78 -50;
%        alto = (ImagenRecortar(n+2).BoundingBox(2)-ImagenRecortar(n+1).BoundingBox(2));
        %ancho = (ImagenRecortar(n+1).BoundingBox(1) - (ImagenRecortar(n).BoundingBox(1)+ImagenRecortar(n).BoundingBox(3)));
        %alto = (ImagenRecortar(n+1).BoundingBox(2)-ImagenRecortar(n).BoundingBox(2)-ImagenRecortar(n).BoundingBox(3));  
%        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
%        figure,imshow(gris_crop3{n}) 
%    elseif  n==2 
%        xmin = ImagenRecortar(n-1).BoundingBox(1)+ImagenRecortar(n-1).BoundingBox(3) + 12;
%        ymin = ImagenRecortar(n-1).BoundingBox(2)+ImagenRecortar(n-1).BoundingBox(4);
%        ancho = (ImagenRecortar(n+2).BoundingBox(1) - (ImagenRecortar(n-1).BoundingBox(1)+ImagenRecortar(n-1).BoundingBox(3))) - 32;
%        alto = (ImagenRecortar(n+2).BoundingBox(2)-ImagenRecortar(n-1).BoundingBox(2)-ImagenRecortar(n-1).BoundingBox(3));
        %ancho = (ImagenRecortar(n+1).BoundingBox(1) - (ImagenRecortar(n).BoundingBox(1)+ImagenRecortar(n).BoundingBox(3)));
        %alto = (ImagenRecortar(n+1).BoundingBox(2)-ImagenRecortar(n).BoundingBox(2)-ImagenRecortar(n).BoundingBox(3));  
%        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
%     elseif n==3
%        xmin = ImagenRecortar(n+2).BoundingBox(1)+ImagenRecortar(n+2).BoundingBox(3) + 15;
%        ymin = ImagenRecortar(n+2).BoundingBox(2)+ImagenRecortar(n+2).BoundingBox(4);
%        ancho = (ImagenRecortar(n+3).BoundingBox(1) - (ImagenRecortar(n+2).BoundingBox(1)+ImagenRecortar(n+2).BoundingBox(3))) - 32;
%        alto = (ImagenRecortar(n+3).BoundingBox(2)-ImagenRecortar(n+2).BoundingBox(2)-ImagenRecortar(n+2).BoundingBox(3));
%        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
%     elseif n==4
%        xmin = ImagenRecortar(n+3).BoundingBox(1)+ImagenRecortar(n+3).BoundingBox(3) + 15;
%        ymin = ImagenRecortar(n+3).BoundingBox(2)+ImagenRecortar(n+3).BoundingBox(4);
%        ancho = (ImagenRecortar(n+4).BoundingBox(1) - (ImagenRecortar(n+3).BoundingBox(1)+ImagenRecortar(n+3).BoundingBox(3))) - 30;
%        alto = (ImagenRecortar(n+4).BoundingBox(2)-ImagenRecortar(n+3).BoundingBox(2)-ImagenRecortar(n+3).BoundingBox(3));
%        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n})    
%     elseif n==5        
%        xmin = ImagenRecortar(n+4).BoundingBox(1)+ImagenRecortar(n+4).BoundingBox(3) + 17;
%        ymin = ImagenRecortar(n+4).BoundingBox(2)+ImagenRecortar(n+4).BoundingBox(4);
%        ancho = (ImagenRecortar(n+5).BoundingBox(1) - (ImagenRecortar(n+4).BoundingBox(1)+ImagenRecortar(n+4).BoundingBox(3))) - 33;
%        alto = (ImagenRecortar(n+5).BoundingBox(2)-ImagenRecortar(n+4).BoundingBox(2)-ImagenRecortar(n+4).BoundingBox(3));
%        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
%     else 
%        xmin = ImagenRecortar(n+5).BoundingBox(1)+ImagenRecortar(n+5).BoundingBox(3) + 19;
%        ymin = ImagenRecortar(n+5).BoundingBox(2)+ImagenRecortar(n+5).BoundingBox(4);
%        ancho = (ImagenRecortar(n+6).BoundingBox(1) - (ImagenRecortar(n+5).BoundingBox(1)+ImagenRecortar(n+5).BoundingBox(3))) - 33;
%        alto = (ImagenRecortar(n+6).BoundingBox(2)-ImagenRecortar(n+5).BoundingBox(2)-ImagenRecortar(n+5).BoundingBox(3));
%        gris_crop3{n} = imcrop(binaria2,[xmin ,ymin , ancho, alto]);     
        %figure,imshow(gris_crop3{n}) 
%     end 
% end    
 %n=5;  
 %gris_crop3{n} = imcrop(binaria2,[( propied(n).BoundingBox(1)+propied(n).BoundingBox(3))+(propied(n).BoundingBox(3)/2)-3 ,propied(n).BoundingBox(2) + propied(1).BoundingBox(4),(propied(n+5).BoundingBox(1) - (propied(n).BoundingBox(1) + propied(n).BoundingBox(3))) - propied(n).BoundingBox(3)  , ( propied(n+5).BoundingBox(2)-propied(n).BoundingBox(2)-propied(n).BoundingBox(3))]);
 %imshow(gris_crop3{n})   
 %for n=1:6   
    %imshow(gris_crop3{n})
    %recortada{n} = bwareaopen(gris_crop3{n},70);
 %   dilatar{n}= bwareaopen(gris_crop3{n},25);
    %figure, imshow(dilatar{n});
 %end,    
 %n=5;  
 %    dilatar{n}= bwareaopen(gris_crop3{n},30); 
     %figure, imshow(dilatar{n});
     
%  se=strel('line',4,0);
%  for n=1:4 
%  dilatar{n} = imdilate( recortada{n},se);
%   figure, imshow(dilatar{n});
%   end,
%clear  binaria2 n ymin xmin recortada n marcas_filtrada gris_crop3 ancho ImagenRecortar   