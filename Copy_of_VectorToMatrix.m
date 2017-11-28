function B = VectorToMatrix(vector)

i = 1; %index files
j = 1; %index columnes
k = 1; %index vector
n = 1;

B(i,j)=vector(k);

%%%PHASE 1
for numfor=1:3
        %movimiento derecha horizontal
        k=k+1;
        j=j+1;
        B(i,j)=vector(k);

        %diagonal bajada
        count=0;
        while count<n
            k=k+1;
            j=j-1;
            i=i+1;
            B(i,j)=vector(k);
            count=count+1;
        end

        %movimiento bajada vertical
        i=i+1;
        k=k+1;
        B(i,j)=vector(k);


        %diagonal subida
        count=0;
        while count<(n+1)
            k=k+1;
            j=j+1;
            i=i-1;
            B(i,j)=vector(k);
            count=count+1;
        end
        n=n+2;
end           




%%%PHASE 2
%movimiento derecha horizontal
k=k+1;
j=j+1;
B(i,j)=vector(k);


%diagonal bajada del medio
count=0;
while count<n
    k=k+1;
    j=j-1;
    i=i+1;
    B(i,j)=vector(k);
    count=count+1;
end





%%%PHASE 3
n=6;
for numfor=1:3
        %movimiento derecha horizontal
        k=k+1;
        j=j+1;
        B(i,j)=vector(k);
        

        %diagonal subida
        count=0;
        while count<n
            k=k+1;
            j=j+1;
            i=i-1;
            B(i,j)=vector(k);
            count=count+1;
        end

        %movimiento bajada vertical
        i=i+1;
        k=k+1;
        B(i,j)=vector(k);


        %diagonal bajada
        count=0;
        while count<(n-1)
            k=k+1;
            j=j-1;
            i=i+1;
            B(i,j)=vector(k);
            count=count+1;
        end
        n=n-2;
end

k=k+1;
j=j+1;
B(i,j)=vector(k);



