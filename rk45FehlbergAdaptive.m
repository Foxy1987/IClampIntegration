function [yn, dtx] = rk45FehlbergAdaptive(f, t, dt, y, Ain, fin, maxdt, eps, abseps, releps)
    % modified Euler
    N = length(y);
    
    % define coefficients 
    a = zeros(7, 6);
    b = zeros(1, 6);
    a(2, 1) =1/4;
    a(3, 1) = 3/32;
    a(3, 2) = 9/32;
    
    a(4, 1) = 1932/2197;
    a(4, 2) = -7200/2197;
    a(4, 3) = 7296/2197;
    
    a(5, 1) = 439/216;
    a(5, 2) = -8;
    a(5, 3)  = 3680/513;
    a(5, 4) = -845/4104;
    
    a(6, 1)= -8/27;
    a(6, 2)=2;
    a(6, 3)=-3544/2565;
    a(6, 4)=1859/4104;
    a(6, 5)=-11/40;


    a(7, 1) = 25/216;
    a(7, 2) = 0;
    a(7, 3) = 1408/2565;
    a(7, 4) = 2197/4104;
    a(7, 5) = -1/5;
    a(7, 6) = 2/55;
    
    b(1, 1) = 16/135;
    b(1, 2) = 0;
    b(1, 3) = 6656/12825;
    b(1, 4) = 28561/56430;
    b(1, 5) = -9/50;
    b(1, 6) = 2/55;
    

    F = zeros(6, 4); % contains derivative at each stage of rk 
    Y = zeros(6, 4);
    
    yn=y;
    y4 =y;
    
    sn = 6; % number of stages
    
    % for each stage
    for i = 1:sn
        % for each equation    
        for k = 1:N
            % for each coefficent in Butcher table
            aF= 0.0;
            for j = 1:i
                aF = aF + a(i, j)*F(j, k);
            end
            Y(i, k) = y(k)+(dt*aF);
        end
        % evaluate ode at current stage s_i
        F(i, :) = dt * feval ( f, t, Y(i, :), Ain, fin);
    end
    
    
    
    % sum up terms to build 4th order scheme
    for k=1:N
    	aF= 0.0;
        for j=1:sn
            aF = aF +a(7,j)*F(j, k);
        end
        y4(k) = y(k)+ dt*aF;  
    end
    
    
     % sum up terms to build 5th order scheme
    for k=1:N
    	aF= 0.0;
        for j=1:sn
            aF = aF +b(j)*F(j, k);
        end
        yn(k) = y(k)+ dt*aF;  
    end
    
    
    delta = 0;
    dtx = maxdt;
    % use difference between 4th and 5th order schemes to adjust the time
    % step
    for k = 1:N
        theEps= max(abseps, min(eps, abs(releps*yn(k))));
        delta= abs(yn(k)-y4(k));
        if (delta > 1e-30)
            newdt = exp(0.166667*(log(theEps)-log(delta)))*dt;
            if (newdt < dtx) 
                dtx= newdt;
            end
        end
    end
end