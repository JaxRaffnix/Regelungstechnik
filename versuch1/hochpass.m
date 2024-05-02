clear

LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";

FREQUENCY = 100e3;
RESISTOR = 1e3;
CAPACITOR = 1 / (2.*pi.*FREQUENCY.*RESISTOR)    % = 1.59e-9

numerator = [RESISTOR*CAPACITOR, 0];
denominator = [RESISTOR*CAPACITOR, 1];
system = tf(numerator, denominator);

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
