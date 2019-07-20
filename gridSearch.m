clear
clc

%% Modified cross-validation
load('FY.mat', 'F', 'Y')
F1 = F;
Y(Y==2|Y==3) = 1;
Y(Y==4|Y==5) = 0;
load('FYn.mat', 'F')
F0 = F;
F = [F1; F0];
Y = [Y; zeros(size(F0, 1), 1)];
indices = [ones(1354, 1); 2*ones(1069, 1); 3*ones(1073, 1); 4*ones(1606, 1); 5*ones(1439, 1);...
         6*ones(1439, 1); 7*ones(1423, 1); 8*ones(1421, 1); 9*ones(1462, 1)]; % novel cross-validation: partition based on rotors
Ntimes = 1e5;
mMCR = nan(15, 1);
x = 1;
for Nf = 1:15

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

mMCR(x) = mean(cvMCR);
x = x+1;
end
save('mMCR1', 'mMCR')

%% Traditional cross-validation
load('FY.mat', 'F', 'Y')
F1 = F;
Y(Y==2|Y==3) = 1;
Y(Y==4|Y==5) = 0;
load('FYn.mat', 'F')
F0 = F;
F = [F1; F0];
Y = [Y; zeros(size(F0, 1), 1)];
indices = crossvalind('Kfold',Y,9); % traditional cross-validation
Ntimes = 1e4;
mMCR = nan(15, 1);
x = 1;
for Nf = 1:15

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

mMCR(x) = mean(cvMCR);
x = x+1;
end
save('mMCR2', 'mMCR')

%% All data cross-validation
load('FY.mat', 'F', 'Y')
F1 = F;
Y(Y==2|Y==3) = 1;
Y(Y==4|Y==5) = 0;
load('FYn.mat', 'F')
F0 = F;
F = [F1; F0];
Y = [Y; zeros(size(F0, 1), 1)];
indices = crossvalind('Kfold',Y,9); % traditional cross-validation
Ntimes = 1e4;
mMCR = nan(15, 1);
x = 1;
for Nf = 1:15

cvMCR = nan(Ntimes, 1);
IND_lib = nan(Ntimes, Nf);
parfor p = 1:Ntimes
    IND_lib(p, :) = randsample(64, Nf);
    F_temp = F(:, IND_lib(p, :));
    cp = classperf(Y);
    for i = 1:max(indices)
        test = (indices == i); 
        class = classify(F_temp(test,:),F_temp,Y);
        classperf(cp,class,test);
    end
    cvMCR(p) = cp.ErrorRate;
end

mMCR(x) = mean(cvMCR);
x = x+1;
end
save('mMCR3', 'mMCR')



