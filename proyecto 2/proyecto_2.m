clear all
load('train.mat')
w=y;%%%%% prueba
cla=9;%%%% clase selecionada
f=5000;%# filas
c=96*96*3;%# columnas en GRB
c2=65*65;%#columnas en Gray y con bajo resolucion 

%%%%%%%%%convertidor de X %%%%%%

for h=1:1:f

img=X(h,1:c);% selecciona la primera imagen fila 1 
imgrgb=reshape(img,96,96,3);% lo convierte en matrix  de 96*96 cada 3  columnas
imgf=rgb2gray(imgrgb);%convierte la imagen de color a gris
B = imresize(imgf, [65 65]);% baja la resolucion 
imggray=reshape(B,1,c2);%convierte la matriz en un vector
p(h,1:c2)=imggray;% acopla en la matriz
end

%%%%%%%% convertir los demas valores en 0 y 1 donde uno solo es para la
%%%%%%%% clase 1 aviones
for i=1:1:f
if y(i,1) == cla;
    w(i,1)=1;
else 
    w(i,1)=0;
end
end

%%%%%concatenar las targets and sources
p1=[w p];

%%%%%%%% guardar nuestro dataset
csvwrite('train.csv',p1);


