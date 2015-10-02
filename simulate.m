function state = simulate(T, dt, y0, Ain, fin)
   

    Nt = floor(T/dt);
    
    state = zeros(Nt, length(y0));
    
    % run a simulation for each input frequency
    for i = 1:Nt
        t = i*dt;
        yn = rk2(@simple_ica_ih_model2, t, dt, y0, Ain, fin);
        y0 = yn;

        state(i, :) = y0; 
    end
end
