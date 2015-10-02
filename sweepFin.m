y0 = [-65, 0.1, 0.1, 0.1];
T = 5000;
dt = 0.25;
Nt = floor(T/dt);
t = linspace(0, T, Nt);
lastCycle = floor((T-1000)/dt);


fin = 0.1:0.05:10;
Ain=1.5;
% run simulation with no current
state = simulate(T, dt, y0, Ain, 0.1);



iapp = Ain*sin(2*pi*t/1000);  
figure;
subplot(4, 1, 2); hold on; plot(t(lastCycle:end), iapp(lastCycle:end)); xlim([4000 T])
z = []; phase = [];

for i = 1:length(fin)
    subplot(4, 1, 1); hold on
    state = simulate(T, dt, state(end, :), Ain, fin(i));
    plot(t, state(:, 1));
    %xlim([0 T])
    % measure impedance amplitude and phase and plot
    V = state(lastCycle:end, 1);
    I = iapp(lastCycle:end);
    t2 = t(lastCycle:end);
    
    z = [z abs(((max(V)-min(V)))/(2*Ain))];
    [maxV IdxV] = max(V);
    [maxI IdxI] = max(I);
    tVPeak = t2(IdxV);
    tIPeak = t2(IdxI);
    phase = [phase (2*pi*(tVPeak-tIPeak))/1000];
    
    subplot(4, 1, 3); hold on
    plot(fin(1:i), z(1:i), 'o-', 'linewidth', 1, 'MarkerSize', 12);
    
    subplot(4, 1, 4); hold on
    plot(fin(1:i), phase(1:i), 'o-', 'linewidth', 1, 'MarkerSize', 12);
end

