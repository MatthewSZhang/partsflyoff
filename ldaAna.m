% LDA analysis for classification of normal (0) and failure (1)

clear
clc

%% Modelling
load('INDn', 'IND')
load('FY.mat', 'F', 'Y')
F1 = F;
Y(Y==2|Y==3) = 1;
Y(Y==4|Y==5) = 0;
load('FYn.mat', 'F')
F0 = F;
F = [F1; F0];
Y = [Y; zeros(size(F0, 1), 1)];

F = F(:, IND);
Mdl = fitcdiscr(F,Y);
y1 = predict(Mdl,F);

figure
hold on
plot(y1, 'ob')
plot(Y, 'r')
hold off
f_trim

save('Mdl', 'Mdl')

%% Train plot
load('INDn', 'IND')
sf = 800;
addpath('C:\Users\SZhang\Google Drive\Matlab\20180907 Simulation\subtightplot')
subplot = @(m,n,p) subtightplot (m, n, p, [0.09 0.05], [0.05 0.03], [0.04 0.02]);
figure('rend','painters','pos',[100 100 sf*1.618 sf])
P1 = [1, 2, 3, 4, 6, 7, 8, 9, 13];
load('Mdl', 'Mdl')
CLR = 'brymg';
for x = 1:9
    p1 = P1(x);
    
    
    
    
    
    load(['C:\Users\SZhang\Google Drive\Matlab\20190713 DX\F\M', num2str(p1)], 'Flib', 'y')
    

    Flib = Flib(:, IND);
    F = Flib - min(Flib);

    y1 = predict(Mdl,F);
    N = 1:length(y);
    L = sort(unique(y))';
    NL = length(L);

    Rst = cell(NL, 1);

    subplot(3, 3, x)
    hold on
    p = 1;
    for p2 = L
    IND1 = y == p2;
    plot(N(IND1), y1(IND1), [CLR(p2), 'o'])
    Rst{p} = num2str(mean(y1(IND1)));
    p = p+1;
    end
    hold off
    legend(Rst, 'Interpreter', 'latex', 'FontSize', 12)
    title(['M', num2str(p1)], 'Interpreter', 'latex', 'FontSize', 12)

    if x == 4
        ylabel('Classification result', 'Interpreter', 'latex', 'FontSize', 12)
    elseif x == 8
        xlabel('Number of the waves', 'Interpreter', 'latex', 'FontSize', 12)
    end

    
    
    
    ylim([0, 1])
end

%% Test plot
load('INDn', 'IND')
sf = 800;
addpath('C:\Users\SZhang\Google Drive\Matlab\20180907 Simulation\subtightplot')
subplot = @(m,n,p) subtightplot (m, n, p, [0.12 0.05], [0.08 0.05], [0.04 0.02]);
figure('rend','painters','pos',[100 100 sf*1.618 (sf-100)*2/3+100])
P1 = [10, 11, 12, 14, 15, 16];
load('Mdl', 'Mdl')
CLR = 'brymg';
for x = 1:6
    p1 = P1(x);
    
    
    
    
    
    load(['C:\Users\SZhang\Google Drive\Matlab\20190713 DX\F\M', num2str(p1)], 'Flib', 'y')
    

    Flib = Flib(:, IND);
    F = Flib - min(Flib);

    y1 = predict(Mdl,F);
    N = 1:length(y);
    L = sort(unique(y))';
    NL = length(L);

    Rst = cell(NL, 1);

    subplot(2, 3, x)
    hold on
    p = 1;
    for p2 = L
    IND1 = y == p2;
    plot(N(IND1), y1(IND1), [CLR(p2), 'o'])
    Rst{p} = num2str(mean(y1(IND1)));
    p = p+1;
    end
    hold off
    legend(Rst, 'Interpreter', 'latex', 'FontSize', 12)
    title(['M', num2str(p1)], 'Interpreter', 'latex', 'FontSize', 12)

    if x == 4
        ylabel('Classification result', 'Interpreter', 'latex', 'FontSize', 12)
    elseif x == 5
        xlabel('Number of the waves', 'Interpreter', 'latex', 'FontSize', 12)
    end

    
    
    
    ylim([0, 1])
end
