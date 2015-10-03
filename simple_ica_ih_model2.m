function dy = simple_ica_ih_model2(t, y, Ain, freq)

    dy =zeros(1, length(y));
    %dy =zeros(length(y), 1);
    gl=0.1; 
    gh=0.15; 
    gca=0.14;
    
    el = -60.0;
    eca = 120;
    eh = -10;
    
    v = y(1); h_m=y(2); ca_m=y(3); ca_h = y(4);
     
    iapp = Ain*sin(2*pi*t/1000);  

    h_minf = 1/(1+exp((v+70)/7.0));
    ca_minf =  1/(1+exp(-(v+51)/8.0));
    ca_hinf = 1/(1+exp((v+65)/6.0));
    h_mtau = 2500/(1+exp((v+110)/-13));

%     dy(1) = (1/freq)*(iapp-(gl*(v-el) + gca*ca_m^3*ca_h*(v-eca) + gh*h_m*(v-eh)));
    dy(1) = (1/freq)*(iapp-(gl*(v-el) + gca*ca_m^3*ca_h*(v-eca)));
    dy(2) = (1/freq)*((h_minf-h_m) / h_mtau);
    dy(3) = (1/freq)*((ca_minf-ca_m) / 1);
    dy(4) = (1/freq)*((ca_hinf-ca_h) / 515);
       
end
