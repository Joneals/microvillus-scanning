% Persisting_forces_calculation.m

SB_row  = 2;                        % Row counter used for tracking slip bond forces
CB_row  = 2;                        % Row counter used for tracking catch bond forces
size_SB = size(CC_SlipBond,1);      % Determine the size of the slip bond matrix
size_CB = size(CC_CatchBond,1);     % Determine the size of the catch bond matrix
SB_persist_forces = zeros(2,2);		% 4/21/20 - Clear perisisting forces to fix bug below
CB_persist_forces = zeros(2,2);		% This shouldn't have any side effects since the matrix is updated no matter what

% If (1) there is a slip bond and (2) the bond has persisted >= 1 dt
% BUG - These loops only clear forces up to the current number of active bonds
% If the number of bonds decreases, the broken bond won't have its force removed
for ii = 1:size_SB                  % Iterate through the slip bond matrix
    
    % Ensure there is a slip bond and retrieve the bond formation time
    if( ( CC_SlipBond(ii,7) ~= 0 )&& ...
        ( time > Bond_distr( CC_SlipBond(ii,7), 1 ) ) )
    
        % Calculate the length of the TCR-pMHC complex and resulting force
        Dist_Slip   = sqrt( ( Height )^2 + ( CC_SlipBond(ii,1) - CC_SlipBond(ii,3) )^2 ...
                      + ( CC_SlipBond(ii,2) - CC_SlipBond(ii,4) )^2 );
                  
        Delta_xc_slip = sqrt( ( CC_SlipBond(ii,1) - CC_SlipBond(ii,3) )^2 );
                  
        % The first row of the persist forces matrix records the time. The
        % subsequent rows of a given column record all of the forces at
        % that given time point. Determine the direction of the force by
        % comparing the x-coordinates of the E1 pMHC and T cell receptor.
        SB_persist_forces(1,1)      = time;
        
        % If the E1 pMHC is ahead of the T cell receptor, impose a
        % "negative" force on the microvillus.
        if( CC_SlipBond(ii,1) > CC_SlipBond(ii,3) )
            SB_persist_forces(SB_row,1) = -k_bond*( Delta_xc_slip/Dist_Slip )*...
                abs( z_bond - Dist_Slip );
        else
            SB_persist_forces(SB_row,1) = k_bond*( Delta_xc_slip/Dist_Slip )*...
                abs( z_bond - Dist_Slip );
        end
        
        SB_row      = SB_row + 1;   % Update the counter for slip bond force matrix
    end
end


% Consider the cases that (1) there are no slip bonds at the time point, or
% (2) the slip bond(s) present in the system have not persisted for more
% than one time step.
if( ( sum( CC_SlipBond(:,7) ) == 0 )||( ...
    sum( Bond_distr( CC_SlipBond( find( CC_SlipBond(:,7) ), 7 ), 1 ) - time ) == 0 ) ) 
    SB_persist_forces(1,1)      = time;
    SB_persist_forces(SB_row,1) = 0; % BUG - This only clears row two of persisting forces
end

% If (1) there is a catch bond and (2) the bond has persisted >= 1 dt
for ii = 1:size_CB                  % Iterate through the catch bond matrix
    
    % Ensure there is a catch bond and retrieve the bond formation time
	if( ( CC_CatchBond(ii,7) ~= 0 )&& ...
        ( time > Bond_distr( CC_CatchBond(ii,7), 1 ) ) )
    
        % Calculate the length of the TCR-pMHC complex and resulting force
        Dist_Catch  = sqrt( ( Height )^2 + ( CC_CatchBond(ii,1) - CC_CatchBond(ii,3) )^2 ...
                      + ( CC_CatchBond(ii,2) - CC_CatchBond(ii,4) )^2 );

        Delta_xc_catch = sqrt( ( CC_CatchBond(ii,1) - CC_CatchBond(ii,3) )^2 );
                  
        % The first row of the persist forces matrix records the time. The
        % subsequent rows of a given column record all of the forces at
        % that given time point.  Determine the direction of the force by
        % comparing the x-coordinates of the agonist pMHC and TCR.
        CB_persist_forces(1,1)      = time;
        
        % If the agonist pMHC is ahead of the T cell receptor, impose a
        % "negative" force on the microvillus.
        if( CC_CatchBond(ii,1) > CC_CatchBond(ii,3) )
            CB_persist_forces(CB_row,1) = -k_bond*( Delta_xc_catch/Dist_Catch )*...
                abs( z_bond - Dist_Catch );
        else
            CB_persist_forces(CB_row,1) = k_bond*( Delta_xc_catch/Dist_Catch )*...
                abs( z_bond - Dist_Catch );
        end
        
        CB_row      = CB_row + 1;
    end
end

% Consider the cases that (1) there are no catch bonds at the time point, 
% or (2) the catch bond(s) present in the system have not persisted for 
% more than one time step.
if( ( sum( CC_CatchBond(:,7) ) == 0 )||( ...
    sum( Bond_distr( CC_CatchBond( find( CC_CatchBond(:,7) ), 7), 1 ) - time ) == 0 ) )
    CB_persist_forces(1,1)      = time;
    CB_persist_forces(CB_row,1) = 0; % BUG
end

% Initialize entry for the slip and catch bond forces on the microvillus.
MV_Force(1,1:3) = 0;

% Calculate the total force on the microvillus at a given time point.
if( SB_persist_forces(1,1) == time )
    MV_Force(1,1) = sum( SB_persist_forces(2:end,1) );
end

if( CB_persist_forces(1,1) == time )
    MV_Force(1,2) = sum( CB_persist_forces(2:end,1) );
end

MV_Force(1,3) = sum( MV_Force(1,1:2) );
