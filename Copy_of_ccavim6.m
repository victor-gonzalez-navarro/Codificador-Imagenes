close all;

%% Leer imagen
fileIDD1 = fopen('camman.lum');
A = fread(fileIDD1);
B= zeros(256, 256);

for l=1:256
    B(l,:) = A((l-1)*256+1:(l-1)*256+256);
end
figure(2);
B2 = uint8(B);
imshow(B2);

Qintra = [16 17 18 19 20 21 22 23;
          17 18 19 20 21 22 23 24;
          18 19 20 21 22 23 24 25;
          19 20 21 22 23 24 26 27;
          20 21 22 23 25 26 27 28;
          21 22 23 24 26 27 28 30;
          22 23 24 26 27 28 30 31;
          23 24 25 27 28 30 31 33];
      
Qinter = [8 16 19 22 26 27 29 34;
          16 16 22 24 27 29 34 37;
          19 22 26 27 29 34 34 38;
          22 22 26 27 29 34 37 40;
          22 26 27 29 32 35 40 48;
          26 27 29 32 35 40 48 58;
          26 27 29 34 38 46 56 69;
          27 29 35 38 46 56 69 83];

disp("---------------------------------------------------");
disp("Las tablas de cuantificación se cuantifican por 1");
%Qintra = Qintra/4;
%Qinter = Qintra/4;



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  C O D E R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inicializacion
dmin = 500000;
disp("El área de búsqueda es de 50");
alpha = 50;
image = B;
image2 = B;
entra = 0;
nun = 0;
disp("El factor de comparador de variancias es 20");
disp("---------------------------------------------------");


%% Busqueda exhaustiva
for inix=1:8:256-7
    for iniy=1:8:256-7
        nun = nun +1;
        
        %image = B;
        dmin = 500000;
        for i=max(1,inix-alpha):inix
            if i>inix-8
                for j=max(1,iniy-alpha):(iniy-8)
                    d1 = sum(sum(abs((image(i:(i+7),j:(j+7)))-(image(inix:(inix+7),iniy:(iniy+7))))));
                    if d1<=dmin
                        dmin = d1;
                        posxmin = i;
                        posymin = j;
                    end
                end
            else
                for j=max(1,iniy-alpha):min(256-7,iniy+alpha)
                    d1 = sum(sum(abs((image(i:(i+7),j:(j+7)))-(image(inix:(inix+7),iniy:(iniy+7))))));
                    if d1<=dmin
                        dmin = d1;
                        posxmin = i;
                        posymin = j;
                    end
                end
            end
        end

        % Finalizacion
        if entra == 1
            image2(inix:inix+7,iniy:iniy+7) = ((image(posxmin:(posxmin+7),posymin:(posymin+7)))-(image(inix:(inix+7),iniy:(iniy+7))));
            Xinter = image2(inix:inix+7,iniy:iniy+7);
            Xintra = image(inix:inix+7,iniy:iniy+7);

            if var(Xintra(:))<(var(Xinter(:))+40)
                Auxi = dct2(image(inix:inix+7,iniy:iniy+7));
                Auxi = round(Auxi./Qintra); 
                l = 1;
            else
                Auxi = dct2(image2(inix:inix+7,iniy:iniy+7));
                Auxi = round(Auxi./Qinter); 
                l = 2;
            end

            image2(inix:inix+7,iniy:iniy+7) = (Auxi);

            matrix(nun,:) = [posxmin, posymin];
            mati(nun) = l;
        else
            image2(inix:inix+7,iniy:iniy+7) = dct2(image(inix:(inix+7),iniy:(iniy+7)));
            entra = 1;
            matrix(nun,:) = [999, 999];
            mati(nun) = l;
        end        
    end
end





%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  D E C O D E R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Decoder a partir de matrix y image2
nun = 0;
imagedecod = zeros(256,256);
for inix=1:8:256-7
    for iniy=1:8:256-7
        nun = nun +1;
        if matrix(nun,1) ~= 999
            if mati(nun) == 1
                imagedecod(inix:inix+7,iniy:iniy+7) = idct2(Qintra.*image2(inix:inix+7,iniy:iniy+7));  
            else
                imagex(inix:inix+7,iniy:iniy+7)=idct2(Qinter.*image2(inix:inix+7,iniy:iniy+7));
                imagedecod(inix:inix+7,iniy:iniy+7) = (imagedecod(matrix(nun,1):matrix(nun,1)+7,matrix(nun,2):matrix(nun,2)+7)-(imagex(inix:inix+7,iniy:iniy+7)));   
            end
        else
            imagedecod(inix:inix+7,iniy:iniy+7) = idct2(image2(inix:inix+7,iniy:iniy+7));

        end
        imageaux = uint8(imagedecod);
        figure(3);
        imshow(imageaux)
    end
end

