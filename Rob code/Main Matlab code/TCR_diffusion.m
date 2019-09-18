% TCR_diffusion.m

% For all unbound T cell receptors, consider diffusive motion
for ii = 1:nTCR
    if( ( sum( ismember( CC_SlipBond(:,6),  ii ) ) == 0 )&& ...
            ( sum( ismember( CC_CatchBond(:,6), ii ) ) == 0 ) )
        
        % Generate random number & compare to probability of diffusive move
        Pran      = rand;
        PTCR_diff = 1 - exp( -propTCR_diff(ii,1)*dt );
        
        if( PTCR_diff > Pran )      % If the diffusive probability is greater than Pran
            theta = 2*pi()*rand;    % Generate a random angle, theta, for diffusive move
            Check = 1000;           % Variable to check neighboring TCR distances
            
            % Generate trial coordinates for T cell receptor
            x_new = CC_TCR(ii,1) + delta_x*cos(theta);
            y_new = CC_TCR(ii,2) + delta_x*sin(theta);
            
            % Ensure trial position does not extend beyond the microvillus
            if( sqrt( ( x_new - x_MV0 ).^2 + ( y_new ).^2 ) < ( Rad_mv - Rad_par ) )
                
                % Consider all neighboring TCRs, including those in bonds
                TCR_neighbor = CC_TCR( ( CC_TCR(:,3) ~= ii ), 3 );
                
                for jj = 1:size(TCR_neighbor,1)
                    
                    kk = TCR_neighbor(jj,1);    % Retrieve neighboring TCR number
                    
                    % Calculate distance between T cell receptors [nm]
                    Dist_TCR = sqrt( ( x_new - CC_TCR(kk,1) ).^2 + ...
                        ( y_new - CC_TCR(kk,2) ).^2 );
                    
                    % Find smallest distance between trial position and all
                    % other T cell receptors
                    if( Dist_TCR < Check )
                        Check = Dist_TCR;
                    end
                end
                
                % Ensure trial position does not overlap with other TCRs
                if( Check > ( 2*Rad_par ) )
                    CC_TCR(ii,1) = x_new;       % Record x-coordinate
                    CC_TCR(ii,2) = y_new;       % Record y-coordinate
                end
            end
        end
    end
end