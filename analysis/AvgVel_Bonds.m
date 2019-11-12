% Slip and strong slip, look at differences
% Spacial gradients (density, distribution)
folder = 'KOFF_2/'
files = dir([folder '*.mat']);
output = zeros(1,2);

for f = 1:length(files)
    filename = fullfile(folder, files(f).name)
    load(filename)
    MV_center = MV_center_VSV8_0_10_T;
    breaks = 0:200:max(MV_center);
    samples = zeros(length(breaks)-1,3);
    
    for i = 1:length(breaks)
       [x,ind] = min(abs(MV_center - breaks(i))); 
       samples(i,1) = ind.*.1;
       samples(i,2) = MV_center(ind);
    end
    
    for i = 2:length(samples)
        avg_vel = (samples(i,2) - samples(i-1,2))/(samples(i,1)-samples(i-1,1))./1000*60;
        n_pMHC = sum(sum(C_E1(:,1,1) < samples(i,2) & C_E1(:,1,1) > samples(i-1,2)));
        output = [output ; [avg_vel, n_pMHC]];
    end
       
end
output = output(2:end,:);
plot(output(:,2),output(:,1), 'b.')
boxplot(output(:,1), output(:,2))
ylabel('Avg Velocity')
xlabel('# pMHC in sector')
