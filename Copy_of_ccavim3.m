close all;

%% Leer imagen
fileIDD1 = fopen('camman.lum');
A = fread(fileIDD1);
B= zeros(256, 256);

for l=1:256
    B(l,:) = A((l-1)*256+1:(l-1)*256+256);
end
%figure;
%B2 = uint8(B);
%imshow(B2);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  C O D E R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inicializacion
dmin = 500000;
alpha = 50;
image = B;
image2 = B;
entra = 0;
nun = 0;

%% Busqueda exhaustiva
for inix=1:8:256-7
    for iniy=1:8:256-7
        nun = nun +1;
        
        image = B;
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
            dct2(image2(inix:inix+7,iniy:iniy+7));
            matrix(nun,:) = [posxmin, posymin];
        else
            image2(inix:inix+7,iniy:iniy+7) = dct2(image(inix:(inix+7),iniy:(iniy+7)));
            entra = 1;
            matrix(nun,:) = [999, 999];
        end        
    end
end

%image2 = dct2(image2);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  D E C O D E R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Decoder a partir de matrix y image2

%image2 = idct2(image2);

nun = 0;
imagedecod = zeros(256,256);
for inix=1:8:256-7
    for iniy=1:8:256-7
        nun = nun +1;
        if matrix(nun,1) ~= 999
            idct2(image2(inix:inix+7,iniy:iniy+7));
            imagedecod(inix:inix+7,iniy:iniy+7) = (imagedecod(matrix(nun,1):matrix(nun,1)+7,matrix(nun,2):matrix(nun,2)+7)-(image2(inix:inix+7,iniy:iniy+7)));
            % Si quiero mostrar imagen asignando bloques mas parecidos
            %imagedecod(inix:inix+7,iniy:iniy+7) = image(matrix(nun,1):matrix(nun,1)+7,matrix(nun,2):matrix(nun,2)+7);
        else
            imagedecod(inix:inix+7,iniy:iniy+7) = idct2(image2(inix:inix+7,iniy:iniy+7));
        end
        imageaux = uint8(imagedecod);
        figure(3);
        imshow(imageaux)
    end
end



