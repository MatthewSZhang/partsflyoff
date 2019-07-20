function f_orbit(p1, p2, p3, p4, rsl)
if nargin < 5
    rsl = 0.5;
end

currAddr = pwd;
p2Name = 'abcde';
fileName = ["CEX"; "CEY"; "NCEX"; "NCEY"; "SDA"; "SDB"; "SDC"];

    
load([currAddr, '\Data\M', num2str(p1),'\M', num2str(p1), p2Name(p2), '\T_', convertStringsToChars(fileName(p3)), '.mat'], 'T')
Ux = T.wave;
load([currAddr, '\Data\M', num2str(p1),'\M', num2str(p1), p2Name(p2), '\T_', convertStringsToChars(fileName(p3+1)), '.mat'], 'T')
Uy = T.wave;

x = Ux(p4, :)';
y = Uy(p4, :)';

    


%%

[~, PCu] = pca([x, y]);
pcx = PCu(:, 1);
pcy = PCu(:, 2);

%%
axs = [floor(min(x)-1), floor(max(x)+1), floor(min(y)-1), floor(max(y)+1)];
figure
plot(x, y, 'b')
yticks(unique([yticks, axs(4)]))
xlabel('wave on X1', 'Interpreter', 'latex', 'FontSize', 12)
ylabel('wave on Y1', 'Interpreter', 'latex', 'FontSize', 12)
axis(axs)
f_trim

figure
N = hist3([x, y], 'Edges', {axs(1):rsl:axs(2) axs(3):rsl:axs(4)});
N_pcolor = N';
N_pcolor(size(N_pcolor,1)+1,size(N_pcolor,2)+1) = 0;
xl = linspace(axs(1),axs(2),size(N_pcolor,2)); % Columns of N_pcolor
yl = linspace(axs(3),axs(4),size(N_pcolor,1)); % Rows of N_pcolor
pcolor(xl,yl,N_pcolor);
colormap('hot') % Change color scheme
yticks(unique([yticks, axs(4)]))
axis(axs)
xlabel('X1', 'Interpreter', 'latex', 'FontSize', 12)
ylabel('Y1', 'Interpreter', 'latex', 'FontSize', 12)
colorbar
f_trim

axs = [floor(min(pcx)-1), floor(max(pcx)+1), floor(min(pcy)-1), floor(max(pcy)+1)];
figure
plot(pcx, pcy, 'b')
yticks(unique([yticks, axs(4)]))
xlabel('PC1', 'Interpreter', 'latex', 'FontSize', 12)
ylabel('PC2', 'Interpreter', 'latex', 'FontSize', 12)
axis(axs)
f_trim

figure
N = hist3([pcx, pcy], 'Edges', {axs(1):rsl:axs(2) axs(3):rsl:axs(4)});
N_pcolor = N';
N_pcolor(size(N_pcolor,1)+1,size(N_pcolor,2)+1) = 0;
xl = linspace(axs(1),axs(2),size(N_pcolor,2)); % Columns of N_pcolor
yl = linspace(axs(3),axs(4),size(N_pcolor,1)); % Rows of N_pcolor
pcolor(xl,yl,N_pcolor);
colormap('hot') % Change color scheme 
yticks(unique([yticks, axs(4)]))
axis(axs)
xlabel('PC1', 'Interpreter', 'latex', 'FontSize', 12)
ylabel('PC2', 'Interpreter', 'latex', 'FontSize', 12)
colorbar
f_trim


