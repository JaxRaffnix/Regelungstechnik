clear

LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";

% x-Axis
time = linspace(0, 3e-3, 1e3);

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
sinplots = tiledlayout(2,1);
nexttile
plot(time, f1);
hold on 
plot(time, f2)
hold on 
plot(time, f3)
xlabel('t in s')
legend('x1(t)', 'x2(t)', 'x3(t)')
title('x1(t), x2(t) und x3(t)')
nexttile
plot(f1, f2)
xlabel('x1(t)')
ylabel('x2(t)')
title('Lissajous-Figur')

% exportgraphics(sinplots, "sinus.pdf", 'ContentType','vector') % known bug in matlab: exportgraphics won't save axis exponent!
saveas(sinplots, LOCAL_DIRECTORY + 'sinus.png')

% plot with wrong paramters
figure
lissplots = tiledlayout(2,1);
time_new = linspace(0, 3, 1e3);

nexttile
f1 = sine1(time_new);
f2 = sine2(time_new);
plot(f1, f2)
xlabel('x1(t)')
ylabel('x2(t)')
title('Zeitbereich 0:3 s, 1000 Abtastpunkte')

% another set of wrong paramters
time_new_new = linspace(0, 3, 1e3+1);
nexttile
f1 = sine1(time_new_new);
f2 = sine2(time_new_new);
plot(f1, f2)
xlabel('x1(t)')
ylabel('x2(t)')
title('Zeitbereich 0:3 s, 1001 Abtastpunkte')

saveas(lissplots, LOCAL_DIRECTORY + "lissjaou.png")
