% Catch_bond_dissociation.m

% Consider catch bond dissociation for all bound TCRs based on previously
% calculated propensity matrices.
for ii = 1:size(propCatch_break,1)              % Iterate through all TCRs
    
    Pran        = rand;                         % Generate a random number
    kdiss_catch = sum( propCatch_break(ii,:) ); % Calculate catch bond dissociation propensities
    Pdiss_catch = 1 - exp( -kdiss_catch*dt );   % Calculate catch bond dissociation probability
    
    if( Pdiss_catch > Pran )                    % If Pdiss > Pran, perform catch bond dissociation
        
        TCR_number = ii;                        % Retrieve the TCR number
        
        for jj = 1:size(CC_CatchBond,1)         % Iterate through the catch bond matrix
            
            % If the individual TCR number corresponds to a catch bond
            % matrix entry, ...
            if( CC_CatchBond(jj,6) == TCR_number )
                Diss_no               = CC_CatchBond(jj,7); % Retrieve the bond number
                CC_CatchBond(jj,1:7)  = 0;                  % Eliminate entry in catch bond matrix
                Bond_distr(Diss_no,2) = time;               % Record time of catch bond dissociation
            end
        end
    end
end