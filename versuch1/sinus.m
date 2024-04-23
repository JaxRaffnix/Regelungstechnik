clear

% x-Axis
time = linspace(0, 3e-3);

% declare functions
function f1 = sine1(time)
    f1 = 2 * sin(2 * pi * 2e3 * time - 0);
end
function f2 = sine2(time)
    f2 = 4 * sin(2 * pi * 6e3 * time - pi./4);
end

f1 = sine1(time);
f2 = sine2(time);
f3 = f1 .* f1;

% plot functions
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

% plot with wrong paramters
figure
lissplots = tiledlayout(2,1);
time = linspace(0, 3, 1e3);

nexttile
f1 = sine1(time);
f2 = sine2(time);
plot(f1, f2)
xlabel('x1(t)')
ylabel('x2(t)')
title('Zeitbereich 0:3 s, 1000 Intervalle')

% another set of wrong paramters
time = linspace(0, 3, 1e3+1);
nexttile
f1 = sine1(time);
f2 = sine2(time);
plot(f1, f2)
xlabel('x1(t)')
ylabel('x2(t)')
title('Zeitbereich 0:3 s, 1001 Intervalle')

exportgraphics(lissplots, "lissjaou.pdf", 'ContentType','vector')
