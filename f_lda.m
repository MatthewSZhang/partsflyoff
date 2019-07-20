function f_lda(p1, IND)
% LDA results plot
CLR = 'brymg';
load(['C:\Users\SZhang\Google Drive\Matlab\20190713 DX\F\M', num2str(p1)], 'Flib', 'y')
load('Mdl', 'Mdl')

Flib = Flib(:, IND);
F = Flib - min(Flib);

y1 = predict(Mdl,F);
N = 1:length(y);
L = sort(unique(y))';
NL = length(L);

Rst = cell(NL, 1);

figure
hold on
p = 1;
for p2 = L
IND = y == p2;
plot(N(IND), y1(IND), [CLR(p2), 'o'])
Rst{p} = num2str(mean(y1(IND)));
p = p+1;
end
hold off
legend(Rst, 'Interpreter', 'latex', 'FontSize', 12)
title(['M', num2str(p1)], 'Interpreter', 'latex', 'FontSize', 12)
