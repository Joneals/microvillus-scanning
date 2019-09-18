% Catch_bond_formation.m

% Consider catch bond formation for all unbound T cell receptors based on
% the previously calculated propensity matrix.
CatchRowResize  = 1;                % Counter used to resize catch bond matrix  
CC_Catch_Bond_int = zeros(1,7);     % Intermediate matrix to update catch bond matrix

for ii = 1:size(CC_CatchBond,1)     % Iterate through the catch bond matrix
    
    % If there is a catch bond, transfer information to intermediate matrix
    if( CC_CatchBond(ii,7) ~= 0 )
        CC_Catch_Bond_int(CatchRowResize,1:7) = CC_CatchBond(ii,1:7);
        CatchRowResize = CatchRowResize + 1;
    end
end

CC_CatchBond = CC_Catch_Bond_int;   % Update the catch bond matrix

% For all unbound TCRs, consider catch bond formation to unbound OVA pMHC
for ii = 1:nTCR
    
    % If an individual TCR is not part of a slip or catch bond, ...
    if( ( sum( ismember( CC_SlipBond(:,6),  ii ) ) == 0 ) && ...
        ( sum( ismember( CC_CatchBond(:,6), ii ) ) == 0 ) )
    
        Pran        = rand;                         % Generate a random number
        kbind_catch = sum( propCatch_bind(ii,:) );  % Sum all catch bond binding propensities
        Pbind_catch = 1 - exp( -kbind_catch*dt );   % Calculate catch bond binding probability
        
        if( Pbind_catch > Pran )                    % If Pbind > Pran, consider catch bond formation
            
            aRand   = rand*kbind_catch;             % Selects a random propensity threshold
            aTemp   = 0;                            % Increases until propensity exceeds aRand
            flag    = 0;                            % Flag variable to break out of nested loops
            
            while( aTemp < aRand )                  % Continue until threshold is exceeded
                
                for jj = 1:size(propCatch_bind,2)   % Loop through all OVA pMHC molecules
                    
                    aTemp = aTemp + propCatch_bind(ii,jj);
                    
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
            
            % Ensure chosen agonist pMHC molecule is not w/in a catch bond.
            % The next catch bond matrix row is indexed by the variable
            % 'Catch_Row_Resize'.
            if( sum( ismember( pMHC_number, CC_CatchBond(:,5) ) == 0 ) )
                CC_CatchBond(CatchRowResize,1:2) = CC_Ag(pMHC_number,1:2);  % Retrieve agonist pMHC coordinates
                CC_CatchBond(CatchRowResize,3:4) = CC_TCR(TCR_number,1:2);  % Retrieve TCR coordinates
                CC_CatchBond(CatchRowResize,5)   = pMHC_number;             % Record the OVA pMHC number
                CC_CatchBond(CatchRowResize,6)   = TCR_number;              % Record the TCR number
                CC_CatchBond(CatchRowResize,7)   = BondCounter;             % Record the bond number
                Bond_distr(BondCounter,1)        = time;                    % Record time of catch bond formation
                Bond_distr(BondCounter,3)        = 2;                       % Indicate that a catch bond formed
                BondCounter                      = BondCounter + 1;         % Update bond number counter 
                CatchRowResize                   = CatchRowResize + 1;      % Update catch bond number counter
            end
        end
    end
    
    flag = 0;                   % Reset the flag variable
end