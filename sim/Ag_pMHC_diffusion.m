% Ag_pMHC_diffusion.m

% Consider diffusive moves for all unbounded agonist pMHC molecules
for ii = 1:nAg
    
    % Ensure the agonist pMHC molecule is not in a catch bond
    if( sum( ismember( CC_CatchBond(:,5), ii ) ) == 0 ) 
        
        % Generate random number & compare to probability of diffusive move
        Pran      = rand;
        PAg_diff  = 1 - exp( -propAg_diff(ii,1)*dt );
        
        if( PAg_diff > Pran )       % If the diffusive probability is greater than Pran
            theta = 2*pi()*rand;    % Generate a random angle, theta, for diffusive move
            Check = 1000;           % Variable to check neighboring agonist pMHC distances
            
            % Generate trial coordinates for agonist pMHC molecule
            x_new = CC_Ag(ii,1) + delta_x*cos(theta);
            y_new = CC_Ag(ii,2) + delta_x*sin(theta);
            
            % Ensure trial position does not extend over the boundaries
            if( ( x_new < max_x )&&( x_new > min_x )&&...
                ( y_new < max_y )&&( y_new > min_y ) )
            
                % Compile a list of all agonist pMHC neighbors
                Ag_neighbor = CC_Ag( ( CC_Ag(:,3) ~= ii ), 3 );
                
                for jj = 1:size(Ag_neighbor,1)      % Iterate through neighboring agonist pMHC
                    
                    kk = Ag_neighbor(jj,1);         % Retrieve neighboring agonist pMHC number
                    
                    % Calculate distance between agonist pMHC molecules [nm]
                    Dist_Ag = sqrt( ( x_new - CC_Ag(kk,1) ).^2 + ...
                        ( y_new - CC_Ag(kk,2) ).^2 );
                    
                    % Find smallest distance between trial position and all
                    % other agonist pMHC molecules
                    if( Dist_Ag < Check ) 
                        Check = Dist_Ag;
                    end
                end
                
                for jj = 1:nE1                      % Iterate through all E1 pMHC
                    
                    % Calculate distance between trial agonist pMHC and E1s
                    Dist_Ag = sqrt( ( x_new - CC_E1(jj,1) ).^2 + ...
                        ( y_new - CC_E1(jj,2) ).^2 );
                    
                    if( Dist_Ag < Check )
                        Check = Dist_Ag;
                    end
                end
                
                % Ensure trial position does not overlap with other pMHC
                if( Check > ( 2*Rad_par ) )
                    CC_Ag(ii,1) = x_new;            % Record x-coordinate
                    CC_Ag(ii,2) = y_new;            % Record y-coordinate
                end
            end
        end
    end
end