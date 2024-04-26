clear

LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";

FREQUENCY = 100e3;
CAPACITOR = 1e-9;
RESISTOR = 1 / (2.*pi.*FREQUENCY.*CAPACITOR)    % = 1.5915e+03
denominator = [RESISTOR*CAPACITOR, 1];
system = tf(1, denominator);

figure;
bode = bodeplot(system);
setoptions(bode, ...
    'FreqUnits','Hz', ...
    'PhaseVisible','off', ...
    'xlim', {[1e2, 1e7]} ...
);
title('');

saveas(gcf, LOCAL_DIRECTORY + 'bode.png')

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

saveas(gcf, LOCAL_DIRECTORY + 'ortskurve.png')
