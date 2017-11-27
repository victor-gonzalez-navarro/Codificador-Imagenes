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



%% Inicializacion
inix = 116;
iniy = 196;
dmin = 500000;
alpha = 50;
image = B;
image2 = B;
entra = 0;

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
        if entra == 1
            % S A C A R   A B S
            image2(inix:inix+7,iniy:iniy+7) = ((image(posxmin:(posxmin+7),posymin:(posymin+7)))-(image(inix:(inix+7),iniy:(iniy+7))))+128;
            
            image(posxmin:posxmin+7,posymin)=100*ones(8,1);
            image(posxmin:posxmin+7,posymin+7)=100*ones(8,1);
            image(posxmin,posymin:posymin+7)=100*ones(8,1);
            image(posxmin+7,posymin:posymin+7)=100*ones(8,1);
        else
            % S A C A R   A B S
            image2(inix:inix+7,iniy:iniy+7) = (image(inix:(inix+7),iniy:(iniy+7)));
            entra = 1;
        end
        image(inix:inix+7,iniy)=zeros(8,1);
        image(inix:inix+7,iniy+7)=zeros(8,1);
        image(inix,iniy:iniy+7)=zeros(8,1);
        image(inix+7,iniy:iniy+7)=zeros(8,1);

        image = uint8(image);
        image2 = uint8(image2);
        figure(1);
        imshow(image2)
        figure(2);
        imshow(image)
        
        pause(1);
        
    end
end

disp('Sacar abs');

