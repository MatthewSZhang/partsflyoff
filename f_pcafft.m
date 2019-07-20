function [PCX, PCY, X, Y, Sx, Sy] = f_pcafft(p1, p2, p3, p4)
% FFT after PCA.

if nargin < 1
    p1 = 1; % M1
end
if nargin <2
    p2 = 1; % a
end
if nargin < 3
    p3 = 1; % CEX
end
if nargin < 4
    p4 = 1; % wave
end

p2Name = 'abcde';
fileName = ["CEX"; "CEY"; "NCEX"; "NCEY"; "SDA"; "SDB"; "SDC"];

currAddr = pwd;
load([currAddr, '\Data\M', num2str(p1),'\M', num2str(p1), p2Name(p2), '\T_', char(fileName(p3)), '.mat'], 'T')
x = T.wave(p4, :)';
Sx = T.speed(p4);
load([currAddr, '\Data\M', num2str(p1),'\M', num2str(p1), p2Name(p2), '\T_', char(fileName(p3+1)), '.mat'], 'T')
y = T.wave(p4, :)';
Sy = T.speed(p4);

[~, PCs] = pca([x, y]);
PCX = abs(fft(PCs(:, 1)));
PCY = abs(fft(PCs(:, 2)));
X = abs(fft(x));
Y = abs(fft(y));



