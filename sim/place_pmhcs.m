
clear CC_E1 CC_Ag nE1 nAg


% Grid placement
xGrid = min(Lx):density:max(Lx); 
yGrid = min(Ly):density:max(Ly); 
[xGrid, yGrid] = meshgrid(xGrid, yGrid);
pMHCs = [xGrid(:) yGrid(:)];
npMHCs = length(pMHCs);

nE1 = floor( (1-jjj)*npMHCs);
nAg = npMHCs - nE1;

CC_E1 = [];
for i = 1:nE1
    r = randi(size(pMHCs,1));
    CC_E1 = [CC_E1; pMHCs(r,:), i];
    pMHCs(r,:) = [];
end

CC_Ag = [];
for i = 1:nAg
    r = randi(size(pMHCs,1));
    CC_Ag = [CC_Ag; pMHCs(r,:), i];
    pMHCs(r,:) = [];
end

