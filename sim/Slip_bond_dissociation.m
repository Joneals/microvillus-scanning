% Slip_bond_dissociation.m

% Consider slip bond dissociaiton for all bound TCRs based on previously
% calculated propensity matrices.
for ii = 1:size(propSlip_break,1)               % Iterate through all TCRs
    
    Pran        = rand;                         % Generate a random number
    kdiss_slip  = sum( propSlip_break(ii,:) );  % Calculate slip bond dissociation propensities
    Pdiss_slip  = 1 - exp( -kdiss_slip*dt );    % Calculate slip bond dissociaiton probability
    
    if( Pdiss_slip > Pran )                     % If Pdiss > Pran, perform slip bond dissociation
        
        TCR_number = ii;                        % Retrieve the TCR number
        
        for jj = 1:size(CC_SlipBond,1)          % Iterate through the slip bond matrix
            
            % If the individual TCR number corresponds to a slip bond
            % matrix entry, ...
            if( CC_SlipBond(jj,6) == TCR_number )           
                Diss_no               = CC_SlipBond(jj,7);  % Retrieve the bond number
                CC_SlipBond(jj,1:7)   = 0;                  % Eliminate entry in slip bond matrix
                Bond_distr(Diss_no,2) = time;               % Record time of slip bond dissociation
            end
        end
    end
end