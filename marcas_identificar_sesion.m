function [Ne]=marcas_identificar_sesion(img1)

gris2 =img1;      % para sacar las preguntas como tal
umbral = 0.18;    %  para las marcas

%umbral1 = 0.50;               % para sacar las marcas 
%umbral2 = 0.60;              % para sacar las preguntas como tal
%umbral3 = 0.70;              % para sacar las preguntas como tal
%umbral4 = 0.81;              % para sacar las preguntas como tal

foto_marcas=~im2bw(gris2,umbral);
%figure, imshow(foto_marcas); 
marcas_filtrada = bwareaopen(foto_marcas,1000); 
%figure, imshow(marcas_filtrada);
clear  foto_marcas gris1 gris2  img1 umbral1 umbral2  binaria2    
[L Ne]=bwlabel(marcas_filtrada); 
propied = regionprops(L);  

%hasta aca
clear marcas_filtrada L           