% Drag_pMHCs.m

% Consider all slip bonds
for iBond = 1:size(CC_SlipBond,1)

    E1_Velocity = zeros(length(CC_E1),2);

    if CC_SlipBond(iBond,5) == 0
		% Skip if slip bond doesn't exist
        continue;
    end
    % 3D vector from pMHC -> TCR [nm]
    vBond = [CC_SlipBond(iBond,3:4) - CC_SlipBond(iBond,1:2) Height];
    pMHC = CC_SlipBond(iBond,5);

	% 2D (x-y) force vector from pMHC -> TCR [pN]
    vForceBond = k_bond .* ( norm(vBond) - z_bond ) ...
	.* ( norm(vBond(1:2))./norm(vBond) ) .* ( vBond(1:2)./norm(vBond(1:2)) );

	% Calculate velocity assuming no net force
    E1_Velocity(pMHC,1:2) = vForceBond ./ u_drag;

	% Update position based on velocity
    CC_E1(pMHC,1:2) = CC_E1(pMHC,1:2) + E1_Velocity(pMHC,1:2) .* CF .* dt;
    CC_SlipBond(iBond,1:2) = CC_E1(pMHC,1:2);
end

% Consider all catch/strongslip bonds
for iBond = 1:size(CC_CatchBond,1)
    Ag_Velocity = zeros(length(CC_Ag),2);
    if CC_CatchBond(iBond,5) == 0
        continue; % Skip if slip bond doesn't exist
    end

    % 3D vector from pMHC -> TCR [nm]
    vBond = [CC_CatchBond(iBond,3:4) - CC_CatchBond(iBond,1:2) Height];
    pMHC = CC_CatchBond(iBond,5);

	% 2D (x-y) force vector from pMHC -> TCR [pN]
    vForceBond = k_bond .* ( norm(vBond) - z_bond ) ...
	.* ( norm(vBond(1:2))./norm(vBond) ) .* ( vBond(1:2)./norm(vBond(1:2)) );

	% Calculate velocity assuming no net force
    Ag_Velocity(pMHC,1:2) = vForceBond ./ u_drag;

	% Update position based on velocity
    CC_Ag(pMHC,1:2) = CC_Ag(pMHC,1:2) + Ag_Velocity(pMHC,1:2) .* CF .* dt;
    CC_CatchBond(iBond,1:2) = CC_Ag(pMHC,1:2);
end
