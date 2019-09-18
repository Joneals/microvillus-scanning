% E1_pMHC_diffusion.m

% Consider diffusive moves for all unbounded E1 pMHC molecules
for ii = 1:nE1
    
    % Ensure the E1 pMHC molecule is not in a slip bond
    if( sum( ismember( CC_SlipBond(:,5), ii ) ) == 0 ) 
        
        % Generate random number & compare to probability of diffusive move
        Pran      = rand;
        PE1_diff  = 1 - exp( -propE1_diff(ii,1)*dt );
        
        if( PE1_diff > Pran )       % If the diffusive probability is greater than Pran
            theta = 2*pi()*rand;    % Generate a random angle, theta, for diffusive move
            Check = 1000;           % Variable to check neighboring E1 pMHC distances
            
            % Generate trial coordinates for E1 pMHC molecule
            x_new = CC_E1(ii,1) + delta_x*cos(theta);
            y_new = CC_E1(ii,2) + delta_x*sin(theta);
            
            % Ensure trial position does not extend over the boundaries
            if( ( x_new < max_x )&&( x_new > min_x )&&...
                ( y_new < max_y )&&( y_new > min_y ) )
            
                % Compile a list of all E1 pMHC neighbors
                E1_neighbor = CC_E1( ( CC_E1(:,3) ~= ii ), 3 );
                
                for jj = 1:size(E1_neighbor,1)  % Iterate through neighboring E1 pMHC
                    
                    kk = E1_neighbor(jj,1);     % Retrieve neighboring E1 pMHC number
                    
                    % Calculate distance between E1 pMHC molecules [nm]
                    Dist_E1 = sqrt( ( x_new - CC_E1(kk,1) ).^2 + ...
                        ( y_new - CC_E1(kk,2) ).^2 );
                    
                    % Find smallest distance between trial position and all
                    % other E1 pMHC molecules
                    if( Dist_E1 < Check )
                        Check = Dist_E1;
                    end
                end
                
                for jj = 1:nAg                  % Iterate through all agonist pMHC
                    
                    % Calculate distance between trial E1 pMHC and agonist pMHCs
                    Dist_E1 = sqrt( ( x_new - CC_Ag(jj,1) ).^2 + ...
                        ( y_new - CC_Ag(jj,2) ).^2 );
                    
                    if( Dist_E1 < Check )
                        Check = Dist_E1;
                    end
                end
                
                % Ensure trial position does not overlap with other pMHC
                if( Check > ( 2*Rad_par ) )
                    CC_E1(ii,1) = x_new;        % Record x-coordinate
                    CC_E1(ii,2) = y_new;        % Record y-coordinate
                end
            end
        end
    end
end