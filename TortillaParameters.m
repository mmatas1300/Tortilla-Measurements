clc
clear all
close all
figure
%Lectura de imagen
IMA=imread('./imgs/testal.jpg');

%Inicialización de constantes.
Grad=zeros(640,480);
Constante_Realidad=0.167889908;

%Imagen en modelo RGB
 R=IMA(:,:,1);   G=IMA(:,:,2);   B=IMA(:,:,3);
[filas,columnas,capas]=size(IMA);
HSV=rgb2hsv(IMA);

%Se forma la imagen en HSV.
H=HSV(:,:,1);   S=HSV(:,:,2);   V=HSV(:,:,3);

%% Binarización de la imagen
S_=S*255;
T=150; %Umbral de binarización
for i=1:filas
    for j=1:columnas
        if S_(i,j)<=T
            Bin(i,j)=1;
        else
            Bin(i,j)=0;
        end
    end
end

%Calculo del centroide
Lc=10; %Lado centroide
x=[1:columnas]; y=[1:filas];
fx=sum(Bin,1);  fy=sum(Bin,2);
yc=round(sum(x.*fx)/sum(fx));
xc=round(sum(y.*fy')/sum(fy'));

%Dibujar centroide en la escena
IMA(uint16(xc-Lc/2):uint16(xc+Lc/2)+1,uint16(yc-Lc/2):uint16(yc+Lc/2)+1,1)=0;
IMA(uint16(xc-Lc/2):uint16(xc+Lc/2)+1,uint16(yc-Lc/2):uint16(yc+Lc/2)+1,2)=0;
IMA(uint16(xc-Lc/2):uint16(xc+Lc/2)+1,uint16(yc-Lc/2):uint16(yc+Lc/2)+1,3)=255;

%Cálculo del gradiente de la imagen
dx=1;   dy=1;
for x=2:filas-1
    for y=2:columnas-1
        Grad_x(x,y)=(Bin(x+dx,y)-Bin(x-dx,y))/(2*dx);
        Grad_y(x,y)=(Bin(x,y+dy)-Bin(x,y-dy))/(2*dy);
        Grad(x,y)=sqrt(Grad_x(x,y).^2+Grad_y(x,y).^2);
    end
end
Grad=255*Grad; Grad=Grad>127;

%Firma de la imagen
k=1;
for i=2:filas-1
    for j=2:columnas-1
        if (Grad(i,j)==1)
            Radio_Pix(k)=round(sqrt((i-xc)^2+(j-yc)^2));
            k=k+1;
        end
    end
end

%Cálculo de los radios reales
Radio_real=Constante_Realidad*Radio_Pix;
for c=1:length(Radio_real)
    if 44.6<Radio_real(c) && Radio_real(c)<55
        Radio_umbral(c)=Radio_real(c);
    else 
        Radio_umbral(c)=Radio_real(c-50);
    end
    
     if 44.6<Radio_real(c) && Radio_real(c)<55
        Radio_umbral(c)=Radio_real(c);
    else 
        Radio_umbral(c)=47;
    end
end

%Escena capturada
subplot(4,4,[1,2,5,6]);
imshow(IMA);    
title('Escena original capturada')
ax = gca;
ax.FontSize = 12;
%Bordes de testales de la escena
subplot(4,4,[3,4,7,8]);
imshow(uint8(255*Grad));
title('Bordes del testal')
ax = gca;
ax.FontSize = 12;
%Firma de la imagen
subplot(4,4,[9,10,11,12,13,14,15,16]);
plot(Radio_umbral); grid on,hold on
Radio_Prom=sum(Radio_umbral)/length(Radio_umbral);
Radio_Maximo=max(Radio_umbral);
Radio_Minimo=min(Radio_umbral);
for k=1:length(Radio_umbral)
    RadioPromedioV(k)=Radio_Prom;
    RadioMinimoV(k)=Radio_Minimo;
    RadioMaxV(k)=Radio_Maximo;
end

%Gráfico de los radios
subplot(4,4,[9,10,11,12,13,14,15,16]);
plot(RadioPromedioV); grid on,hold on
plot(RadioMinimoV); grid on,hold on
plot(RadioMaxV); grid on,hold on
title('Firma del testal')
ylabel('Magnitud del radio [mm]')
xlabel('Radios del testal')
ax = gca;
ax.FontSize = 10;
drawnow limitrate