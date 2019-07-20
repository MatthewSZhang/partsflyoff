% Provide 10 optimal features IND.mat
% Training data 9 rotors in total
clear
clc

%%
load('FY.mat', 'F', 'Y') % The data from faulty rotors. 1 to 5 in Y means a to e time-segments.
F1 = F;
Y(Y==2|Y==3) = 1;
Y(Y==4|Y==5) = 0;
load('FYn.mat', 'F') % The data from normal rotors
F0 = F;
F = [F1; F0];
Y = [Y; zeros(size(F0, 1), 1)];
indices = [ones(1354, 1); 2*ones(1069, 1); 3*ones(1073, 1); 4*ones(1606, 1); 5*ones(1439, 1);...
         6*ones(1439, 1); 7*ones(1423, 1); 8*ones(1421, 1); 9*ones(1462, 1)]; % modified cross-validation: partition based on rotors
Ntimes = 1e5;

Nf = 10;

cvMCR = nan(Ntimes, 1);
IND_lib = nan(Ntimes, Nf);
parfor p = 1:Ntimes
    IND_lib(p, :) = randsample(64, Nf);
    F_temp = F(:, IND_lib(p, :));
    cp = classperf(Y);
    for i = 1:max(indices)
        test = (indices == i); 
        train = ~test;
        class = classify(F_temp(test,:),F_temp(train,:),Y(train,:));
        classperf(cp,class,test);
    end
    cvMCR(p) = cp.ErrorRate;
end
[~, A] = min(cvMCR);
IND = IND_lib(A, :);

save('IND', 'IND')


