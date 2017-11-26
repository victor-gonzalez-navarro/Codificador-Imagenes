close all;

%% Leer imagen
fileIDD1 = fopen('camman.lum');
A = fread(fileIDD1);
B= zeros(256, 256);

size(A(2:256+1))
for l=1:256
    B(l,:) = A((l-1)*256+1:(l-1)*256+256);
end
%figure;
%B2 = uint8(B);
%imshow(B2);



%% Inicializacion
inix = 116;
iniy = 196;
dmin = 500000;
alpha = 50;
image = B;

%% Busqueda exhaustiva
for inix=1:8:256-7
    for iniy=1:8:256-7
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



        %% Finalizacion
        image(inix:inix+7,iniy)=zeros(8,1);
        image(inix:inix+7,iniy+7)=zeros(8,1);
        image(inix,iniy:iniy+7)=zeros(8,1);
        image(inix+7,iniy:iniy+7)=zeros(8,1);


        image(posxmin:posxmin+7,posymin)=100*ones(8,1);
        image(posxmin:posxmin+7,posymin+7)=100*ones(8,1);
        image(posxmin,posymin:posymin+7)=100*ones(8,1);
        image(posxmin+7,posymin:posymin+7)=100*ones(8,1);


        image = uint8(image);
        imshow(image)
        pause(0.25);
    end
end

