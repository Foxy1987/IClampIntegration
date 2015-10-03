clear all
    dt = 0.025;
    Tmax = 3000;

    %initial vectors 
    t_vec = zeros(floor(Tmax/dt)+1, 1);
    h_vec = zeros(floor(Tmax/dt), 1);
    ca_h_vec = zeros(floor(Tmax/dt), 1);
    ca_m_vec = zeros(floor(Tmax/dt), 1);
    v_vec = zeros(floor(Tmax/dt), 1);
    
    % capacitance in uF
    c= 1;
   
    gl=0.1; 
    gh=0.15; 
    gca=0.14;
    el = -60.0;
    eca = 120;
    eh = -10;

    v = -70;
    h = 0.1;
    ca_m = 0.1;
    ca_h = 0.1;
    
    v_vec(1) = v;
    h_vec(1) = h;
    ca_h_vec(1) = ca_h;
    ca_m_vec(1) = ca_m;
    
    freq = .1;
    Ain =0;

    for i = 1:length(t_vec)-1
        t_vec(i+1) = i * dt;
        t = i*dt;
        iapp = Ain*sin(2*pi*t/1000);  
        
        h_minf = 1/(1+exp((v+70)/7.0));
        ca_minf =  1/(1+exp(-(v+51)/8.0));
        ca_hinf = 1/(1+exp((v+65)/6.0));
        h_mtau = 2500/(1+exp((v+110)/-13));
       
        %k1_v = (1/freq)*(iapp-(gl*(v-el) + gca*ca_m^3*ca_h*(v-eca) + gh*h*(v-eh)));
        k1_v = (iapp-(gl*(v-el)));
        k1_h = ((h_minf-h) / h_mtau);
        k1_ca_m = ((ca_minf-ca_m) / 1);
        k1_ca_h = ((ca_hinf-ca_h) / 515);
       
        a1_v = v + k1_v*dt;
        a1_h = h + k1_h * dt;
        a1_ca_m = ca_m + k1_ca_m * dt;
        a1_ca_h = ca_h + k1_ca_h * dt;
        
        iapp = Ain*sin(2*pi*t/1000);  
        h_mtau = 2500/(1+exp((a1_v+110)/-13));
        h_minf = 1/(1+exp((a1_v+70)/7.0));
        ca_minf =  1/(1+exp(-(a1_v+51)/8.0));
        ca_hinf = 1/(1+exp((a1_v+65)/6.0));
        
        %k2_v = (1/freq)*(iapp-(gl*(a1_v-el) + gca*a1_ca_m^3*a1_ca_h*(a1_v-eca) + gh*a1_h*(a1_v-eh)));
        k2_v = (iapp-(gl*(a1_v-el)));
        k2_h = ((h_minf-a1_h) / h_mtau);
        k2_ca_m = ((ca_minf-a1_ca_m) / 1);  
        k2_ca_h = ((ca_hinf-a1_ca_h) / 515);
        
        v = v +  (k1_v + k2_v) * dt / 2;
        h = h + (k1_h + k2_h) * dt / 2;
        ca_m = ca_m + (k1_ca_m + k2_ca_m) * dt / 2;
        ca_h = ca_h + (k1_ca_h + k2_ca_h) * dt / 2;
        
        v_vec(i+1) = v;
        h_vec(i+1) = h;
        ca_m_vec(i+1) = ca_m;
        ca_h_vec(i+1) = ca_h;
 
    end

    figure; plot(t_vec, v_vec)