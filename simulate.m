function state = simulate(T, dt, y0, Ain, fin)
   

    Nt = floor(T/dt);
    
    state = zeros(Nt, length(y0));
    
    % run a simulation for each input frequency
    for i = 1:Nt
        t = i*dt;
        yn = rk2(@simple_ica_ih_model2, t, dt, y0, Ain, fin);
%         yn = rk45Fehlberg(@simple_ica_ih_model2, t, dt, y0, Ain, fin);
        y0 = yn;
        
        state(i, :) = y0; 
    end
    
%     options = odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5 1e-5 1e-5]);
%     [T2,Y] = ode23(@(t, y) simple_ica_ih_model2(t, y, Ain, fin), [0 T], y0, options);
%     figure; plot(T2, Y(:, 1))
%     state = Y;
end


% 
% adaptive step size runge-kutta embedded fehlberg
% 
% function state = simulate(T, dt, y0, Ain, fin)
%     time = [];
%     v = [];
%     % run a simulation for each input frequency
%     t = 0;
%     while t < T
%          [yn, dtx] = rk45FehlbergAdaptive(@simple_ica_ih_model2, t, dt, y0, Ain, fin, 0.2, 1e-4, 1e-12, 1e-4);
%         y0 = yn;
%         dtx = min(dtx, 2.0*dt);
%         dt = dtx
%         t = t+dt;
%         time = [time t];
%         v = [v yn(1)];
%     end
%     hold on; plot(time, v);
% end