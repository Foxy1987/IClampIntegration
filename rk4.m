function [yn] = rk4(f, t, dt, y, Ain, fin)
    % modified Euler
    N = length(y);
    
    % define coefficients 
    a = zeros(4, 4);
    b = zeros(1, 4);
    a(2, 1) = 1/2;
    a(3, 2) = 1/2;
    a(4, 3) = 1;

    b(1) = 1/6;
    b(2) = 1/3;
    b(3) = 1/3;
    b(4) = 1/6;

    F = zeros(4, 4); % contains derivative at each stage of rk 
    Y = zeros(4, 4);
    
    yn=zeros(1, length(y));
    
    % for each stage
    for i = 1:4
        % for each equation    
        for k = 1:N
            % for each coefficent in Butcher table
            aF= 0;
            for j = 1:i
                aF = aF + a(i, j)*F(j, k);
            end
            Y(i, k) = y(k)+dt*aF;
        end
        % evaluate ode at current stage s_i
        F(i, :) = dt * feval ( f, t, Y(i, :), Ain, fin);
    end
    
    
    
    for k=1:N
    	aF= 0.0;
        for j=1:4
            aF = aF +b(j)*F(j, k);
        end
        yn(k) = y(k)+ dt*aF;  
    end
    
end