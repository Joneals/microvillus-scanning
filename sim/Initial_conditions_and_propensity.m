% Initial_conditions_and_propensity.m

% Initialize matrices that track all pMHC, TCRs, and bonds. The location of
% the pMHC and TCR within bonds are tracked individually.
CC_E1   = zeros( nE1, 3 );      % Matrix that tracks centers of E1 pMHCs
CC_Ag   = zeros( nAg, 3 );      % Matrix that tracks centers of agonist pMHCs
CC_TCR  = zeros( nTCR, 3 );     % Matrix that tracks centers of TCRs


% Place pMHCs on a grid
% place_pmhcs;

if( nE1 ~= 0 )                  % If E1 pMHCs are present, ...
    counter = 1;                % Counter used to place E1 pMHC molecules
    
    while( counter <= nE1 )     % Initialize E1 pMHCs on the APC surface
        
        % Generate trial x- and y-coordinates for an E1 pMHC molecule
     
        x_trial = Lx( 1, randi( length(Lx) ) );
        y_trial = Ly( 1, randi( length(Ly) ) );
        
        % Ensure trial position does not extend over the boundaries
        if( ( x_trial < max_x )&&( x_trial > min_x )&&...
            ( y_trial < max_y )&&( y_trial > min_y ) )
        
            Check = 1000;       % Variable to check neighboring E1 pMHC distances
            
            for ii = 1:nE1      % Check trial position against neighboring positions
                
                % Calculate distance between E1 pMHC molecules [nm]
                Dist_E1 = sqrt( ( x_trial - CC_E1(ii,1) ).^2 + ...
                    ( y_trial - CC_E1(ii,2) ).^2 );
                
                % Find smallest distance between trial & all other E1 pMHC
                if( Dist_E1 < Check )
                    Check = Dist_E1;
                end
            end
            
            % Ensure trial position does not overlap with other E1 pMHCs
            if( Check > ( 2*Rad_par ) )
                CC_E1(counter,1) = x_trial;     % Record x-coordinate
                CC_E1(counter,2) = y_trial;     % Record y-coordinate
                CC_E1(counter,3) = counter;     % Record the individual E1 pMHC number
                counter = counter + 1;          % Update the counter
            end
        end
    end
end       


E1_Velocity = zeros(length(CC_E1),2);


if( nAg ~= 0 )                  % If agonist pMHCs are present, ...
    counter = 1;                % Counter used to place agonist pMHC molecules
    
    while( counter <= nAg )     % Initialize agonist pMHCs on the APC surface
        
        % Generate trial x- and y-coordinates for an agonist pMHC molecule
        x_trial = Lx( 1, randi( length(Lx) ) );
        y_trial = Ly( 1, randi( length(Ly) ) );
        
        % Ensure trial position does not extend over the boundaries
        if( ( x_trial < max_x )&&( x_trial > min_x )&&...
            ( y_trial < max_y )&&( y_trial > min_y ) )
        
            Check = 1000;       % Variable to check neighboring agonist pMHC distances
            
            for ii = 1:nAg      % Check trial position against neighboring agonist pMHCs
                
                % Calculate distance between agonist pMHC molecules [nm]
                Dist_Ag = sqrt( ( x_trial - CC_Ag(ii,1) ).^2 + ...
                    ( y_trial - CC_Ag(ii,2) ).^2 );
                
                % Find smallest distance between trial & all other agonist pMHC
                if( Dist_Ag < Check )
                    Check = Dist_Ag;
                end
            end
            
            for ii = 1:nE1      % Check trial position against neighboring E1 pMHCs
                
                % Calculate distance between E1 pMHC molecules [nm]
                Dist_E1 = sqrt( ( x_trial - CC_E1(ii,1) ).^2 + ...
                    ( y_trial - CC_E1(ii,2) ).^2 );
                
                % Find smallest distance between trial agonist pMHC & all pMHCs
                if( Dist_E1 < Check )
                    Check = Dist_E1;
                end
            end
            
            % Ensure trial position does not overlap with other agonist pMHCs
            if( Check > ( 2*Rad_par ) )
                CC_Ag(counter,1) = x_trial;    % Record x-coordinate
                CC_Ag(counter,2) = y_trial;    % Record y-coordinate
                CC_Ag(counter,3) = counter;    % Record the individual agonist pMHC number
                counter = counter + 1;         % Update the counter
            end
        end
    end
end

counter = 1;                    % Counter used to place T cell receptors
while( counter <= nTCR )        % Initialize TCRs within the microvillus
    
    % Generate trial x- and y-coordinates for a T cell receptor
    x_trial = x_mv( 1, randi( length(x_mv) ) );
    y_trial = x_mv( 1, randi( length(x_mv) ) );
    
    % Ensure trial position is within the microvillus boundary
    if( sqrt( x_trial^2 + y_trial^2 ) < ( Rad_mv - Rad_par ) )
        
        Check = 1000;           % Variable to check neighboring TCR distances
        
        for ii = 1:nTCR         % Check trial position against other TCRs
            
            % Calculate distance between T cell receptors [nm]
            Dist_TCR = sqrt( ( x_trial - CC_TCR(ii,1) ).^2 + ...
                ( y_trial - CC_TCR(ii,2) ).^2 );
            
            % Find smallest distance between trial & all other TCRs
            if( Dist_TCR < Check )
                Check = Dist_TCR;
            end
        end
        
        % Ensure trial TCR does not overlap with other T cell receptors
        if( Check > ( 2*Rad_par ) )
            CC_TCR(counter,1) = x_trial;    % Record x-coordinate
            CC_TCR(counter,2) = y_trial;    % Record y-coordinate
            CC_TCR(counter,3) = counter;    % Record the individual TCR number
            counter = counter + 1;          % Update the counter
        end
    end
end

% Initialize matrices for tracking slip and catch bonds
CC_SlipBond  = zeros( min( [ nTCR nE1 ] ),  7 );
CC_CatchBond = zeros( min( [ nTCR nAg ] ), 7 );

% Initialize binding, dissociation, and diffusive propensity matrices
propSlip_bind  = zeros(nTCR,nE1);  propCatch_bind  = zeros(nTCR,nAg);
propSlip_break = zeros(nTCR,nE1);  propCatch_break = zeros(nTCR,nAg);

if( nE1 ~= 0 )                  % If E1 pMHCs are present, ...
    for ii = 1:nTCR             % Iterate through all T cell receptors
        for jj = 1:nE1          % Iterate through all E1 pMHC molecules
            
            % Calculate distances between TCRs and E1 pMHCs
            Dist_Slip = sqrt( ( Height )^2 + ( CC_TCR(ii,1) - CC_E1(jj,1) )^2 + ...
                ( CC_TCR(ii,2) - CC_E1(jj,2) )^2 );
            
            % Calculate corresponding binding propensity for a slip bond
            % given the distance between components is less than 26 nm.
            if( Dist_Slip < Binding_rad )
                propSlip_bind(ii,jj) = kon_E1*exp( -( Dist_Slip - z_bond )^2 / ...
                    ( 2*kon_std^2 ) );
            end
        end
    end
end

if( nAg ~= 0 )                  % If there are agonist pMHCs present, ...
    for ii = 1:nTCR             % Iterate through all T cell receptors
        for jj = 1:nAg          % Iterate through all agonist pMHC molecules
            
            % Calculate distances between TCRs and agonist pMHCs
            Dist_Catch = sqrt( ( Height )^2 + ( CC_TCR(ii,1) - CC_Ag(jj,1) )^2 + ...
                ( CC_TCR(ii,2) - CC_Ag(jj,2) )^2 );
            
            % Calculate corresponding binding propensity for a catch bond
            % given the distance between components is less than 26 nm.
            if( Dist_Catch < Binding_rad )
                propCatch_bind(ii,jj) = kon_Ag*exp( -( Dist_Catch - z_bond )^2 / ...
                    ( 2*kon_std^2 ) );
            end
        end
    end 
end     

propE1_diff  = khop_E1*ones(nE1,1);     % Propensity matrix for E1 pMHC diffusion
propAg_diff  = khop_Ag*ones(nAg,1);     % Propensity matrix for agonist pMHC diffusion
propTCR_diff = khop_TCR*ones(nTCR,1);   % Propensity matrix for TCR diffusion

aTot = sum( sum( propSlip_bind  ) ) + sum( sum( propSlip_break  ) ) + ...
       sum( sum( propCatch_bind ) ) + sum( sum( propCatch_break ) ) + ...
       sum( propE1_diff ) + sum( propAg_diff ) + sum( propTCR_diff );
