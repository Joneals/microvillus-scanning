% Average slip bonds and catch bonds into bin width sizes of 0.20 µm/min

NS_tot  = zeros(51,size(Vel_Distr,3));
NC_tot  = zeros(51,size(Vel_Distr,3));
Vel_tot = zeros(51,size(Vel_Distr,3));
Count   = zeros(51,size(Vel_Distr,3));
A       = zeros(51,3,size(Vel_Distr,3));
bin_min = -1.1;             % Minimum microvillus velocity of interest
bin_max = -0.9;             % Bin width is equivalent to difference of max - min
kk = 1;                     % Counter used to store variables in matrix

while( bin_min <= 7.1 )     % Loop through until last desired bin is reached
    
    for ll = 1:size(Vel_Distr,3)        % Iterate through all pMHC cases
        for ii = 1:size(Vel_Distr,1)    % Iterate through all velocity bins
            
            % If the velocity is within the bin of interest, ...
            if( ( Vel_Distr(ii,3,ll) >= bin_min )&& ...
                ( Vel_Distr(ii,3,ll) <  bin_max ) )
                NS_tot(kk,ll)   = NS_tot(kk,ll) + NS_Distr(ii,3,ll);
                NC_tot(kk,ll)   = NC_tot(kk,ll) + NC_Distr(ii,3,ll);
                Vel_tot(kk,ll)  = Vel_tot(kk,ll) + Vel_Distr(ii,3,ll);
                Count(kk,ll)    = Count(kk,ll) + 1;
            end
        end
        
        % Find the average velocity, number of slip bonds, and catch bonds
        % within the bin for each trajectory
        A(kk,1,ll) = Vel_tot(kk,ll)/Count(kk,ll);
        A(kk,2,ll) = NS_tot(kk,ll)/Count(kk,ll);
        A(kk,3,ll) = NC_tot(kk,ll)/Count(kk,ll);
    end
    
    kk = kk + 1;                        % Update the counter for the next bin
    bin_min = bin_min + 0.2;            % Update the minimum bin velocity threshold
    bin_max = bin_max + 0.2;            % Update the maximum bin velocity threshold
end