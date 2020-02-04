k_spring = 0.1;
u_drag = 2;

for iBond = 1:size(CC_SlipBond,1)
    E1_Velocity = zeros(length(CC_E1),2);
    if CC_SlipBond(iBond,5) == 0
        continue;
    end
    
    vBond = CC_SlipBond(iBond,3:4) - CC_SlipBond(iBond,1:2); % Vector from pMHC -> TCR
    pMHC = CC_SlipBond(iBond,5); % pMHC number
    vForceBond = k_spring .* vBond; % Force vector on pMHC - Need to be squared instead of linear?
    E1_Velocity(pMHC,1:2) = vForceBond ./ u_drag; % Assume no acceleration

    CC_E1(pMHC,1:2) = CC_E1(pMHC,1:2) + E1_Velocity(pMHC,1:2) .* CF .* dt; % Update position based on velocity
    CC_SlipBond(iBond,1:2) = CC_E1(pMHC,1:2); % Update positions in bond matrix
end

for iBond = 1:size(CC_CatchBond,1)
    Ag_Velocity = zeros(length(CC_Ag),2);
    if CC_CatchBond(iBond,5) == 0
        continue;
    end
    
    vBond = CC_CatchBond(iBond,3:4) - CC_CatchBond(iBond,1:2); % Vector from pMHC -> TCR
    pMHC = CC_CatchBond(iBond,5); % pMHC number
    vForceBond = k_spring .* vBond; % Force vector on pMHC - Need to be squared instead of linear?
    Ag_Velocity(pMHC,1:2) = vForceBond ./ u_drag; % Assume no acceleration

    CC_Ag(pMHC,1:2) = CC_Ag(pMHC,1:2) + Ag_Velocity(pMHC,1:2) .* CF .* dt; % Update position based on velocity
    CC_CatchBond(iBond,1:2) = CC_Ag(pMHC,1:2); % Update positions in bond matrix
end
