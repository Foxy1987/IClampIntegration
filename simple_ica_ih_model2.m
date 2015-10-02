function dy = simple_ica_ih_model2(t, y, Ain, freq)

    dy =zeros(1, length(y));
    gl=0.1; 
    gh=0.1; 
    gca=0.25;
    
    el = -60.0;
    eca = 120;
    eh = -10;
    
    v = y(1); h_m=y(2); ca_m=y(3); ca_h = y(4);
     
    iapp = Ain*sin(2*pi*t/1000);  

    h_minf = 1/(1+exp((v+70)/7.0));

    ca_minf =  1/(1+exp(-(v+50)/8.0));
    ca_hinf = 1/(1+exp((v+70)/6.0));
    h_mtau = 500/(1+exp((v+110)/-13));

    dy(1) = (1/freq)*(iapp-(gl*(v-el) + gca*ca_m*ca_h*(v-eca) + gh*h_m*(v-eh)));
    dy(2) = (1/freq)*((h_minf-h_m) / h_mtau);
    dy(3) = (1/freq)*((ca_minf-ca_m) / 7);
    dy(4) = (1/freq)*((ca_hinf-ca_h) / 600);
       
end
