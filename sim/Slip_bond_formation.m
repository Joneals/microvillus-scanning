% Slip_bond_formation.m

% Consider slip bond formation for all ubound T cell receptors based on the
% previously calculated propensity matrix, i.e. before diffusive moves.
SlipRowResize  = 1;                 % Counter used to resize slip bond matrix
CC_Slip_Bond_int = zeros(1,7);      % Intermediate matrix to update slip bond matrix

for ii = 1:size( CC_SlipBond, 1 )   % Iterate through the slip bond matrix
    
    % If there is a slip bond, place all information in intermediate matrix
    if( CC_SlipBond(ii,7) ~= 0 )
        CC_Slip_Bond_int(SlipRowResize,1:7) = CC_SlipBond(ii,1:7);
        SlipRowResize = SlipRowResize + 1;
    end
end

CC_SlipBond = CC_Slip_Bond_int;     % Update the slip bond matrix to reflect changes

% For all unbound T cell receptors, consider slip bond formation to E1 pMHC
for ii = 1:nTCR
    
    % If an individual TCR is not a part of a slip or catch bond, ...
    if( ( sum( ismember( CC_SlipBond(:,6),  ii ) ) == 0 ) && ...
        ( sum( ismember( CC_CatchBond(:,6), ii ) ) == 0 ) )
    
        Pran        = rand;                         % Generate a random number
        kbind_slip  = sum( propSlip_bind(ii,:) );   % Sum all slip bond binding propensities
        Pbind_slip  = 1 - exp( -kbind_slip*dt );    % Calculate slip bond binding probability
        
        if( Pbind_slip > Pran )                     % If Pbind > Pran, consider slip bond formation
            
            aRand   = rand*kbind_slip;              % Selects a random propensity threshold
            aTemp   = 0;                            % Increases until propensity exceeds aRand
            flag    = 0;                            % Flag variable to break out of nested loops
            
            while( aTemp < aRand )                  % Continue until threshold is exceeded
                
                for jj = 1:size(propSlip_bind,2)    % Loop through all E1 pMHC molecules
                    
                    aTemp = aTemp + propSlip_bind(ii,jj);
                    
                    if( aTemp >= aRand )            % If the propensity threshold is met, ...
                        TCR_number  = ii;           % Retrieve the individual TCR number
                        pMHC_number = jj;           % Retrieve the individual pMHC number
                        flag        = 1;            % Flag the condition is met
                    end
                    
                    if( flag == 1 )                 % Break out of loop
                        break;
                    end
                end
            end
        
            % Ensure chosen E1 pMHC molecule is not already in a slip bond.
            % The next slip bond matrix row is indexed by the variable
            % 'SlipRowResize'.
            if( sum( ismember( pMHC_number, CC_SlipBond(:,5) ) ) == 0 )
                CC_SlipBond(SlipRowResize,1:2)  = CC_E1(pMHC_number,1:2);   % Retrieve E1 pMHC coordinates
                CC_SlipBond(SlipRowResize,3:4)  = CC_TCR(TCR_number,1:2);   % Retrieve TCR coordinates
                CC_SlipBond(SlipRowResize,5)    = pMHC_number;              % Record the E1 pMHC number
                CC_SlipBond(SlipRowResize,6)    = TCR_number;               % Record the TCR number
                CC_SlipBond(SlipRowResize,7)    = BondCounter;              % Record the bond number
                Bond_distr(BondCounter,1)       = time;                     % Record time of slip bond formation
                Bond_distr(BondCounter,3)       = 1;                        % Indicate that a slip bond formed
                BondCounter                     = BondCounter + 1;          % Update bond number counter
                SlipRowResize                   = SlipRowResize + 1;        % Update slip bond number counter
            end
        end
    end
    
    flag = 0;                       % Reset the flag variable
end