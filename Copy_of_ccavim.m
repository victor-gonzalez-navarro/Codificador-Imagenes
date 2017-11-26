close all;
inix = 240;
iniy = 100;
alpha = 50;
%% Busqueda exhaustiva
% for inix=1:8:256-7
%     for iniy=1:8:256-7
        
image = zeros(256,256);
for i=max(1,inix-alpha):inix
    if i>inix-8
        for j=max(1,iniy-alpha):(iniy-8)
            image(i:(i+7),j:(j+7))=ones(8,8);
            %image(i,j)=256;
        end
    else
        for j=max(1,iniy-alpha):min(256-7,iniy+alpha)
            image(i:(i+7),j:(j+7))=ones(8,8);
            %image(i,j)=256;
        end
    end
end
A = zeros(8,8);
A(1:8,1:8) = 0.5;
image(inix:inix+7,iniy:iniy+7)=A;
imshow(image)

