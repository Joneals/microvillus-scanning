k_spring = 0.1;
u_drag = 2;

for iBond = 1:size(CC_SlipBond,1)

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
