function vector = MatrixToVector(B)

i = 1; %index files
j = 1; %index columnes
k = 1; %index vector
n = 1;

vector(k)=B(i,j);
%%%FASE 1
for numfor=1:3
        %movimiento derecha horizontal
        k=k+1;
        j=j+1;
        vector(k)=B(i,j);

        %diagonal bajada
        count=0;
        while count<n
            k=k+1;
            j=j-1;
            i=i+1;
            vector(k)=B(i,j);
            count=count+1;
        end

        %movimiento bajada vertical
        i=i+1;
        k=k+1;
        vector(k)=B(i,j);


        %diagonal subida
        count=0;
        while count<(n+1)
            k=k+1;
            j=j+1;
            i=i-1;
            vector(k)=B(i,j);
            count=count+1;
        end
        n=n+2;
end           




%%%FASE 2
%movimiento derecha horizontal
k=k+1;
j=j+1;
vector(k)=B(i,j);

%diagonal bajada del medio
count=0;
while count<n
    k=k+1;
    j=j-1;
    i=i+1;
    vector(k)=B(i,j);
    count=count+1;
end





%%%FASE 3
n=6;
for numfor=1:3
        %movimiento derecha horizontal
        k=k+1;
        j=j+1;
        vector(k)=B(i,j);

        %diagonal subida
        count=0;
        while count<n
            k=k+1;
            j=j+1;
            i=i-1;
            vector(k)=B(i,j);
            count=count+1;
        end

        %movimiento bajada vertical
        i=i+1;
        k=k+1;
        vector(k)=B(i,j);


        %diagonal bajada
        count=0;
        while count<(n-1)
            k=k+1;
            j=j-1;
            i=i+1;
            vector(k)=B(i,j);
            count=count+1;
        end
        n=n-2;
end

k=k+1;
j=j+1;
vector(k)=B(i,j);
