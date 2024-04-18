clear

% x-Axis
time = linspace(0, 3e-3, 10e3);  % seconds

% declare sine function
function f1 = myfun(amplitude, frequency, time, offset)
    f1 = amplitude * sin(2 * pi * frequency * time - offset);
end


f1 = myfun(2, 2e3, time, 0);
f2 = myfun(4, 6e3, time, -pi./4);
f3 = f1 .* f1;

% plotting
sinplots = tiledlayout(4,1);
nexttile
plot(time, f1)
xlabel('t in s')
title('x1(t)')
nexttile
plot(time, f2)
xlabel('t in s')
title('x2(t)')
nexttile
plot(time, f3)
xlabel('t in s')
title('x3(t)')
nexttile
plot(f1, f2)
xlabel('x1(t)')
ylabel('x2(t)')
title('Lissajous-Figur')

exportgraphics(sinplots, "sinus.pdf", 'ContentType','vector')

% task d
figure
t=linspace(0.3,1e3);
lissplots = tiledlayout(2,1);
nexttile
plot(myfun(2, 2e3, t, 0), myfun(2, 6e3, t, -pi./4))
xlabel('x1(t)')
ylabel('x2(t)')
title('Zeitbereich 0:3 s, 1000 Intervalle')

% task e
t=linspace(0.3,1e3+1);
nexttile
plot(myfun(2, 2e3, t, 0), myfun(2, 6e3, t, -pi./4))
xlabel('x1(t)')
ylabel('x2(t)')
title('Zeitbereich 0:3 s, 1001 Intervalle')

exportgraphics(lissplots, "lissjaou.pdf", 'ContentType','vector')
