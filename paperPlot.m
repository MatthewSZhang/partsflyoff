clear
clc

%% Time domain analysis
f_orbit(9, 1, 1, 1)

%% FFT plot after PCA
freq_IND = 33:32:512;
[PCX, PCY] = f_pcafft(2, 3, 1, 1);
PCX = PCX*2/1024;
PCX(1) = PCX(1)./2;
figure
hold on
plot(PCX, 'b')
h1 = plot(freq_IND, PCX(freq_IND), '*r');
hold off
xlim([0, 1024])
h2 = xline(512, 'k--');
legend([h1, h2], {'Harmonic', 'Nyquist Freq'}, 'Interpreter', 'latex', 'FontSize', 11)
xlabel('Number of points', 'Interpreter', 'latex', 'FontSize', 12)
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 12)
f_trim

%% Cross-validation
load('minAna2/mMCR1.mat')
mMCR1 = mMCR;
load('minAna2/mMCR2.mat')
mMCR2 = mMCR;
load('minAna2/mMCR3.mat')
mMCR3 = mMCR;

figure
hold on
plot(mMCR1, 'b')
plot(mMCR2, 'r')
plot(mMCR3, 'g')
hold off
xlim([1, 15])
xticks(1:2:15)
xlabel('Number of features', 'Interpreter', 'latex', 'FontSize', 12)
ylabel('Misclassification rate', 'Interpreter', 'latex', 'FontSize', 12)
legend('8 Rotors', 'Random Subset', 'All Data', 'Interpreter', 'latex', 'FontSize', 11)
f_trim



