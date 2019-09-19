% Update_propensity.m

% Update all propensity matrices after propagating the microvillus forward.
% Consider binding events, dissociative reactions, and diffusive moves for
% all molecules in the system.

if( nE1 ~= 0 )                          % If there are E1 pMHCs present, ...
    for ii = 1:nTCR                     % Iterate through all T cell receptors
        for jj = 1:nE1                  % Iterate through all E1 pMHC molecules
            
            % Calculate distances between TCRs and E1 pMHCs
            Dist_Slip = sqrt( ( Height )^2 + ( CC_TCR(ii,1) - CC_E1(jj,1) )^2 + ...
                ( CC_TCR(ii,2) - CC_E1(jj,2) )^2 );
            
            % Calculate corresponding binding propensity for a slip bond
            % given (1) the distance between components is less than 50 nm,
            % (2) the TCR is not currently part of a slip/catch bond, and
            % (3) the pMHC is not currently part of a slip bond. If any of
            % the three conditions above are not met, set the propensity of
            % a slip bond binding reaction to zero.
            if( ( Dist_Slip < Binding_rad ) && ...
                ( sum( ismember( CC_SlipBond(:,6),  ii ) ) == 0 ) && ...
                ( sum( ismember( CC_CatchBond(:,6), ii ) ) == 0 ) && ...
                ( sum( ismember( CC_SlipBond(:,5),  jj ) ) == 0 ) )
                propSlip_bind(ii,jj) = kon_E1*exp( -( Dist_Slip - z_bond )^2 / ...
                    ( 2*kon_std^2 ) );
            else
                propSlip_bind(ii,jj) = 0;
            end
        end
    end
end
    
if( nAg ~= 0 )                          % If there are agonist pMHCs present, ...
    for ii = 1:nTCR                     % Iterate through all T cell receptors
        for jj = 1:nAg                  % Iterate through all agonist pMHC molecules
            
            % Calculate distances between TCRs and agonist pMHCs
            Dist_Catch = sqrt( ( Height )^2 + ( CC_TCR(ii,1) - CC_Ag(jj,1) )^2 + ...
                ( CC_TCR(ii,2) - CC_Ag(jj,2) )^2 );
            
            % Calculate corresponding binding propensity for a catch bond
            % given (1) the distance between components is less than 50 nm,
            % (2) the TCR is not currently part of a slip/catch bond, and
            % (3) the pMHC is not currently part of a catch bond. If any of
            % the three conditions above are not met, set the propensity of
            % a slip bond binding reaction to zero.
            if( ( Dist_Catch < Binding_rad ) && ...
                ( sum( ismember( CC_SlipBond(:,6),  ii ) ) == 0 ) && ...
                ( sum( ismember( CC_CatchBond(:,6), ii ) ) == 0 ) && ...
                ( sum( ismember( CC_CatchBond(:,5), jj ) ) == 0 ) )
                propCatch_bind(ii,jj) = kon_Ag*exp( -( Dist_Catch - z_bond )^2 / ...
                    ( 2*kon_std^2 ) );
            else
                propCatch_bind(ii,jj) = 0;
            end
        end
    end
end

propSlip_break  = zeros(nTCR,nE1);          % Reset the slip bond dissociation propensity matrix

for ii = 1:size(CC_SlipBond,1)              % Iterate through the slip bond matrix
    if( CC_SlipBond(ii,7) ~= 0 )            % If there is a slip bond present, ...
        
        TCR_number  = CC_SlipBond(ii,6);    % Retrieve the TCR number
        pMHC_number = CC_SlipBond(ii,5);    % Retrieve the E1 pMHC number
        
        % Calculate the length of the TCR-pMHC complex and resulting force.
        Dist_Slip   = sqrt( ( Height )^2 + ( CC_SlipBond(ii,1) - CC_SlipBond(ii,3) )^2 ...
                        + ( CC_SlipBond(ii,2) - CC_SlipBond(ii,4) )^2 );
                    
        Force_Slip  = k_bond*abs( z_bond - Dist_Slip );
        
        % Calculate the corresponding slip bond dissocation propensity
        propSlip_break(TCR_number,pMHC_number) = koff_E1_0*exp( Force_Slip / koff_E1_f );
    end
end

propCatch_break = zeros(nTCR,nAg);          % Reset the catch bond dissociation propensity matrix

for ii = 1:size( CC_CatchBond, 1 )          % Iterate through the catch bond matrix
    if( CC_CatchBond(ii,7) ~= 0 )           % If there is a catch bond present, ...
        
        TCR_number  = CC_CatchBond(ii,6);   % Retrieve the TCR number
        pMHC_number = CC_CatchBond(ii,5);   % Retrieve the agonist pMHC number
        
        % Calculate the length of the TCR-pMHC complex and resulting force
        Dist_Catch  = sqrt( ( Height )^2 + ( CC_CatchBond(ii,1) - CC_CatchBond(ii,3) )^2 ...
                        + ( CC_CatchBond(ii,2) - CC_CatchBond(ii,4) )^2 );
                    
        Force_Catch = k_bond*abs( z_bond - Dist_Catch );
                
        % Calculate the corresponding catch bond dissociation propensity
        if( Ag_case == 1 )                  % VSV8 pMHC case
            propCatch_break(TCR_number,pMHC_number) = ...
                kc_VSV8*exp( -Force_Catch / fc_VSV8 ) + ks_VSV8*exp( Force_Catch / fs_VSV8 );
        elseif( Ag_case == 2 )              % OVA pMHC case
            propCatch_break(TCR_number,pMHC_number) = ...
                koff_OVA_c0*exp( -Force_Catch / koff_OVA_fc ) + ...
                koff_OVA_s0*exp( Force_Catch / koff_OVA_fs );
        else                                % Strong slip pMHC case
            propCatch_break(TCR_number,pMHC_number) = ...
                koff_E1_Strong*exp( Force_Catch / koff_E1_f );
        end
    end
end

propAg_diff  = khop_Ag*ones(nAg,1);     % Propensity matrix for agonist pMHC diffusion
propE1_diff  = khop_E1*ones(nE1,1);     % Propensity matrix for E1 pMHC diffusion
propTCR_diff = khop_TCR*ones(nTCR,1);   % Propensity matrix for TCR diffusion

aTot = sum( sum( propSlip_bind  ) ) + sum( sum( propSlip_break  ) ) + ...
       sum( sum( propCatch_bind ) ) + sum( sum( propCatch_break ) ) + ...
       sum( propAg_diff ) + sum( propE1_diff ) + sum( propTCR_diff );       