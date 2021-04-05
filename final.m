clc 
clear

%%%%% proyecto final machine

for q=1:1:100
% creo un vector tipo char para que lea cada audio
% los audios con mayor a 050 son masculinos 
    if q<=50   
        archivo=['Record' num2str(q,'%03.f') '_f.wav'];%el f es de tipo float
    else
        archivo=['Record' num2str(q,'%03.f') '_m.wav'];%el f es de tipo float
    end

[Y,Fs]= audioread(archivo);

%////////////////////// señal en el dominio del tiempo //////////////////

Y1=Y(:,1);
T = 1/Fs; % tiempo entre muestras
L = length(Y1); % longitud de la señal
t = 0:1/Fs:L/Fs-(1/Fs); % vector de tiempos

%///////////////////// fft /////////////////

NFFT = 2^nextpow2(L); % Se calcula la potencia de 2 mayor a L
espectro = fft(Y1,NFFT)/L; %se calcula el espectro de la señal de voz
fo = Fs/2*linspace(0,1,NFFT/2+1); % vector de frecuencias del espectro

%/////////////////// valores de energia/////////////////////////

esp=espectro(1:NFFT/2+1);%espectro completo
enert=sum((abs(esp)).^2);%calculo de la energia absoluta de la señal

delf=fo(2);%espacio entre valores de frecuencia 

%////////////////// valores de energia por rango //////////////

a=sum((abs(esp((1/delf):(15/delf)))).^2);
b=sum((abs(esp((16/delf):(31/delf)))).^2);
c=sum((abs(esp((32/delf):(63/delf)))).^2);
d=sum((abs(esp((64/delf):(95/delf)))).^2);
e=sum((abs(esp((96/delf):(127/delf)))).^2);
f=sum((abs(esp((128/delf):(159/delf)))).^2);
g=sum((abs(esp((160/delf):(191/delf)))).^2);
h=sum((abs(esp((192/delf):(223/delf)))).^2);
i=sum((abs(esp((224/delf):(255/delf)))).^2);

%%%%%% porcentajes energia por rango
enera=((a*100)/enert);
enerb=((b*100)/enert);
enerc=((c*100)/enert);
enerd=((d*100)/enert);
enere=((e*100)/enert);
enerf=((f*100)/enert);
energ=((g*100)/enert);
enerh=((h*100)/enert);
eneri=((i*100)/enert);

tab=[enera enerb enerc enerd enere enerf energ enerh eneri 1];
tab2=[enera enerb enerc enerd enere enerf energ enerh eneri 0];

%%%%condicion if de guardado de matriz

    if archivo(11) == 'f' 
        mat(q,:)=tab;%creo una matriz con cada vector de sonido
         else
        mat(q,:)=tab2;%creo una matriz con cada vector de sonido
    end
end

csvwrite('test.csv',mat);
