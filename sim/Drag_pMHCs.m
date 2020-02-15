k_spring = k_bond; % [pN/nm]
u_drag = 1 * 10 ^ ( 2 - mod(iii,5) ); % [pN/(um/min)]

for iBond = 1:size(CC_SlipBond,1)
    E1_Velocity = zeros(length(CC_E1),2);
    if CC_SlipBond(iBond,5) == 0
        continue;
    end
    
    vBond = [CC_SlipBond(iBond,3:4) - CC_SlipBond(iBond,1:2) Height]; % Vector from pMHC -> TCR, 3d, includes height (nm)
    pMHC = CC_SlipBond(iBond,5); % pMHC number
%              Spring const   delta from natural length    Only xy comp
    vForceBond = k_spring .* ( norm(vBond) - z_bond ) .* ( norm(vBond(1:2))./norm(vBond) ) .* ( vBond(1:2)./norm(vBond(1:2)) ); % Force vector (pN)
    E1_Velocity(pMHC,1:2) = vForceBond ./ u_drag; % Assume no acceleration

    CC_E1(pMHC,1:2) = CC_E1(pMHC,1:2) + E1_Velocity(pMHC,1:2) .* CF .* dt; % Update position based on velocity
    CC_SlipBond(iBond,1:2) = CC_E1(pMHC,1:2); % Update positions in bond matrix
end

for iBond = 1:size(CC_CatchBond,1)
    Ag_Velocity = zeros(length(CC_Ag),2);
    if CC_CatchBond(iBond,5) == 0
        continue;
    end
    
    vBond = [ CC_CatchBond(iBond,3:4) - CC_CatchBond(iBond,1:2) Height ]; % Vector from pMHC -> TCR
    pMHC = CC_CatchBond(iBond,5); % pMHC number
    vForceBond = k_spring .* ( norm(vBond) - z_bond ) .* ( norm(vBond(1:2))./norm(vBond) ) .* ( vBond(1:2)./norm(vBond(1:2)) ); % Force vector
    Ag_Velocity(pMHC,1:2) = vForceBond ./ u_drag; % Assume no acceleration

    CC_Ag(pMHC,1:2) = CC_Ag(pMHC,1:2) + Ag_Velocity(pMHC,1:2) .* CF .* dt; % Update position based on velocity
    CC_CatchBond(iBond,1:2) = CC_Ag(pMHC,1:2); % Update positions in bond matrix
end
