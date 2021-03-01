% In this part we will be Investigating mesh density by increasing the mesh
% size and comparing with other sizes and see how current density is
% effected 

% Had to furthur investigate the mesh density plots 

for nx = 30:30:300
    ny = (3/2)*nx;         
    G = sparse(nx*ny);   
    F = zeros(1,nx*ny); 
    sigma = zeros(ny, nx);   % sigma matrix
    for x = 1:nx
        for y = 1:ny
            n = y + (x-1)*ny;
            if x == 1
                G(n, :) = 0;
                G(n, n) = 1;
                F(n) = 1;
            elseif x == nx
                G(n, :) = 0;
                G(n, n) = 1;
                F(n) = 0;
            elseif y == 1
                if x > (2/5)*nx && x < (3/5)*nx
                    G(n, n) = -3;
                    G(n, n-ny) = 10^-2;
                    G(n, n+1) = 10^-2;
                    G(n, n+ny) = 10^-2;
                else
                    G(n, n) = -3;
                    G(n, n-ny) = 1;
                    G(n, n+1) = 1;
                    G(n, n+ny) = 1;                    
                end
            elseif y == ny
                if x > (2/5)*nx && x < (3/5)*nx
                    G(n, n) = -3;
                    G(n, n-ny) = 10^-2;
                    G(n, n+1) = 10^-2;
                    G(n, n+ny) = 10^-2;
                else
                    G(n, n) = -3;
                    G(n, n-ny) = 1;
                    G(n, n+1) = 1;
                    G(n, n+ny) = 1;                    
                end     
            else
                if x > (2/5)*nx && x < (3/5)*nx && (y < (2/5)*ny||y > (3/5)*ny)  
                    G(n, n) = -4;
                    G(n, n-ny) = 10^-2;
                    G(n, n+1) = 10^-2;
                    G(n, n-1) = 10^-2;
                    G(n, n+ny) = 10^-2;
                else
                    G(n, n) = -4;
                    G(n, n+1) = 1;
                    G(n, n-1) = 1;
                    G(n, n+ny) = 1;
                    G(n, n-ny) = 1;
                end
            end
        end
    end
    for a = 1 : nx
        for b = 1 : ny
            if a >= (2/5)*nx && a <= (3/5)*nx
                sigma(b, a) = 10^-2; 
            else
                sigma(b, a) = 1;
            end
        end
    end
    
    V = G\F'; 
    Emap = zeros(ny, nx, 1);
    for i = 1:nx  
        for currDensity = 1:ny
            n = currDensity + (i-1)*ny;
            Emap(currDensity,i) = V(n);  
        end
    end
    [Ex, Ey] = gradient(Emap);
    currDensityx = sigma.*Ex;
    currDensityy = sigma.*Ey;
    currDensity = sqrt(currDensityx.^2 + currDensityy.^2);
    figure(1)
    title("Mesh sizes on current effect")
    hold on
    if nx > 30  
        oldValue = total;
        total = sum(sum(currDensity, 2));
        plot([nx-30, nx], [oldValue, total])
        xlabel("nx")
        ylabel("Current Density")
    end
    if nx == 30
        total = sum(sum(currDensity, 1));
        oldValue = total;
        plot([nx, nx], [oldValue, total]) 
    end
end
