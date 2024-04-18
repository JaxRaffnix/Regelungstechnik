clear

FREQUENCY = 10^5;
RESISTOR = 1560;
CAPACITOR = 10^-9;
denominator = [RESISTOR*CAPACITOR*2*pi, 1];
system = tf(1, denominator);

figure;
bode = bodeplot(system);
setoptions(bode, ...
    'FreqUnits','Hz', ...
    'PhaseVisible','off', ...
    'xlim', {[10^2, 10^7]} ...
);
title('');

exportgraphics(gcf, "bode.pdf", 'ContentType','vector')

figure;
subplot(1,2,1)      % rows, columns, position
    ny = nyquistplot(system);
    setoptions(ny, ...
        'Xlim', {[0,1]}, ...
        'YLim', {[-1, 1]} ...
    );
    title('Vollkreis');

subplot(1,2,2)
    ny_half = nyquistplot(system);
    setoptions(ny_half, ...
        'ShowFullContour', 'off', ...
        'Xlim', {[0,1]}, ...
        'YLim', {[-1, 1]} ...
    );
    title('Halbkreis');

exportgraphics(gcf, "ortskurve.pdf", 'ContentType','vector')
