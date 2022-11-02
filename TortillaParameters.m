figure
cam=webcam(1);
IMA=imread('cal.jpg');

constRealidad=0.167889908;
%%Animacion
 %Ventana para mostrar los elementos de la animacion.
    Grad=zeros(640,480);
    Bandera_Exe=0;
    Radio_Pix=0;
    T_r=0;
    T_rp=0;
    Radio_Prom=0;
    Error_Radio_Prom=0;
    Bandera_Exe=0;
    Produccion_Buenos=0;
    Produccion_Malos=0;
R=IMA(:,:,1);   G=IMA(:,:,2);   B=IMA(:,:,3);
[filas,columnas,capas]=size(IMA);
HSV=rgb2hsv(IMA);

%Se forma la imagen en HSV.
H=HSV(:,:,1);   S=HSV(:,:,2);   V=HSV(:,:,3);

%% Binarizacion de la imagen
S_=S*255;
T=120; %Umbral de binarización
for i=1:filas
    for j=1:columnas
        if S_(i,j)<=T
            Bin(i,j)=1;
        else
            Bin(i,j)=0;
        end
    end
end
%% Calculo del centroide
Lc=10; %Lado centroide
x=[1:columnas]; y=[1:filas];
fx=sum(Bin,1);  fy=sum(Bin,2);
yc=round(sum(x.*fx)/sum(fx));
xc=round(sum(y.*fy')/sum(fy'));
%Dibujar centroide en la escena
IMA(uint16(xc-Lc/2):uint16(xc+Lc/2)+1,uint16(yc-Lc/2):uint16(yc+Lc/2)+1,1)=0;
IMA(uint16(xc-Lc/2):uint16(xc+Lc/2)+1,uint16(yc-Lc/2):uint16(yc+Lc/2)+1,2)=0;
IMA(uint16(xc-Lc/2):uint16(xc+Lc/2)+1,uint16(yc-Lc/2):uint16(yc+Lc/2)+1,3)=255;
%% Estados
if (1)
    Bandera_Exe=1;
    %% Deteccion de bordes de la imagen
    %Calculo del gradiente de la imagen
    dx=1;   dy=1;
    for x=2:filas-1
        for y=2:columnas-1
            Grad_x(x,y)=(Bin(x+dx,y)-Bin(x-dx,y))/(2*dx);
            Grad_y(x,y)=(Bin(x,y+dy)-Bin(x,y-dy))/(2*dy);
            Grad(x,y)=sqrt(Grad_x(x,y).^2+Grad_y(x,y).^2);
        end
    end
    Grad=255*Grad; Grad=Grad>127;
    %% Firma de la imagen
    k=1;
    for i=2:filas-1
        for j=2:columnas-1
            if (Grad(i,j)==1)
                Radio_Pix(k)=round(sqrt((i-xc)^2+(j-yc)^2));
                k=k+1;
            end
        end
    end
    %Verificar promedio de radios dentro del intervalo de error admisible.
    Radio_Prom=round(sum(Radio_Pix)/length(Radio_Pix));
    T_rp=0.05; %Intervalo admisible en porcentaje.
    T_r=round(T_rp*Radio_Prom);
    Dif_Max=abs(max(Radio_Pix)-Radio_Prom); %Diferencia del radio promedio con el maximo.
    Dif_Min=abs(Radio_Prom-min(Radio_Pix)); %Diferencia del radio promedio con el minimo.
    if  ((Dif_Max>T_r) || (Dif_Min>T_r))
        Bandera_Fp=0; %Incorrectamente formado
    else
        Bandera_Fp=1; %Correctamente formado
    end
    %% Decision: correcto o incorrecto conformado de testal
    if (Bandera_Fp==0)
        Bandera_Forma='Testal incorrectamente conformado';
        Produccion_Malos=Produccion_Malos+1;
    else
        Bandera_Forma='Testal correctamente conformado';
        Produccion_Buenos=Produccion_Buenos+1;
    end
    %% Calculo del error
    Error_Radio_Prom=(Dif_Max/Radio_Prom+Dif_Min/Radio_Prom)/2*100;
else
     Bandera_Exe=0;
     Bandera_Forma='No procesar';
end
%% Mostrar resultados
    %Escena capturada por la camara
    subplot(4,4,[1,2,5,6]);
    imshow(IMA);    
    title('Escena original capturada')
    ax = gca;
    ax.FontSize = 15;
    %Bordes de testales de la escena
    subplot(4,4,[3,4,7,8]);
    imshow(uint8(255*Grad));
    title('Bordes del testal')
    ax = gca;
    ax.FontSize = 15;
    %Firma de la imagen
    subplot(4,4,[9,10,11,12,13,14,15,16]);
    plot(constRealidad*Radio_Pix); grid on
    title('Firma del testal')
    ylabel('Magnitud del radio')
    xlabel('Radios del testal')
    ax = gca;
    ax.FontSize = 15;
    drawnow limitrate