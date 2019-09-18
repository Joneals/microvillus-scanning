% Bond_and_Velocity_Calculation.m

Vel_lim     = [-2 6];                       % Velocity distribution limits
Vel_bin     = 0.10;                             % Velocity distribution bin width
Vel_bin_vec = Vel_lim(1):Vel_bin:Vel_lim(2);    % Velocity bin vector

% Retrieve all data for the velocity probability distributions
VE1_1       = Velocity_E1_1x_all;               % 100% E1 pMHC velocities 

VSSB_0_1    = Velocity_SSB_0_1_all;             % 10/90% strong slip/E1 pMHC velocities
VSSB_0_2    = Velocity_SSB_0_2_all;             % 20/80% strong slip/E1 pMHC velocities
VSSB_0_3    = Velocity_SSB_0_3_all;             % 30/70% strong slip/E1 pMHC velocities
VSSB_1      = Velocity_SSB_1x_all;              % 100% strong slip pMHC velocities

VOVA_0_1    = Velocity_OVA_0_1_all;             % 10/90% OVA/E1 pMHC velocities
VOVA_0_2    = Velocity_OVA_0_2_all;             % 20/80% OVA/E1 pMHC velocities
VOVA_0_3    = Velocity_OVA_0_3_all;             % 30/70% OVA/E1 pMHC velocities
VOVA_1      = Velocity_OVA_1x_all;              % 100% OVA pMHC velocities

VVSV8_0_1   = Velocity_VSV8_0_1_all;            % 10/90% VSV8/E1 pMHC velocities
VVSV8_0_2   = Velocity_VSV8_0_2_all;            % 20/80% VSV8/E1 pMHC velocities
VVSV8_0_3   = Velocity_VSV8_0_3_all;            % 30/70% VSV8/E1 pMHC velocities
VVSV8_1     = Velocity_VSV8_1x_all;             % 100% VSV8 pMHC velocities

% Retrieve data for TCR-E1 pMHC complex probability distributions
NS_E1_1     = Bond_total_E1_1x_slip;            % N_{slip} for 100% E1 pMHC

NS_SSB_0_1  = Bond_total_SSB_0_1_slip;   % N_{slip} for 10/90% strong slip/E1 pMHC
NS_SSB_0_2  = Bond_total_SSB_0_2_slip;   % N_{slip} for 20/80% strong slip/E1 pMHC
NS_SSB_0_3  = Bond_total_SSB_0_3_slip;   % N_{slip} for 30/70% strong slip/E1 pMHC
NS_SSB_1    = Bond_total_SSB_1x_slip;           % N_{slip} for 100% strong slip pMHC

NS_OVA_0_1  = Bond_total_OVA_0_1_slip;   % N_{slip} for 10/90% OVA/E1 pMHC
NS_OVA_0_2  = Bond_total_OVA_0_2_slip;   % N_{slip} for 20/80% OVA/E1 pMHC
NS_OVA_0_3  = Bond_total_OVA_0_3_slip;   % N_{slip} for 30/70% OVA/E1 pMHC
NS_OVA_1    = Bond_total_OVA_1x_slip;           % N_{slip} for 100% OVA pMHC

NS_VSV8_0_1 = Bond_total_VSV8_0_1_slip;  % N_{slip} for 10/90% VSV8/E1 pMHC
NS_VSV8_0_2 = Bond_total_VSV8_0_2_slip;  % N_{slip} for 20/80% VSV8/E1 pMHC
NS_VSV8_0_3 = Bond_total_VSV8_0_3_slip;  % N_{slip} for 30/70% VSV8/E1 pMHC
NS_VSV8_1   = Bond_total_VSV8_1x_slip;          % N_{slip} for 100% VSV8 pMHC

% Retrieve data for TCR-(SSB/OVA/VSV8) pMHC complex probability distributions
NC_E1_1     = Bond_total_E1_1x_catch;           % N_{catch} for 100% E1 pMHC

NC_SSB_0_1  = Bond_total_SSB_0_1_catch;  % N_{catch} for 10/90% strong slip/E1 pMHC
NC_SSB_0_2  = Bond_total_SSB_0_2_catch;  % N_{catch} for 20/80% strong slip/E1 pMHC
NC_SSB_0_3  = Bond_total_SSB_0_3_catch;  % N_{catch} for 30/70% strong slip/E1 pMHC
NC_SSB_1    = Bond_total_SSB_1x_catch;          % N_{catch} for 100% strong slip pMHC

NC_OVA_0_1  = Bond_total_OVA_0_1_catch;  % N_{catch} for 10/90% OVA/E1 pMHC
NC_OVA_0_2  = Bond_total_OVA_0_2_catch;  % N_{catch} for 20/80% OVA/E1 pMHC
NC_OVA_0_3  = Bond_total_OVA_0_3_catch;  % N_{catch} for 30/70% OVA/E1 pMHC
NC_OVA_1    = Bond_total_OVA_1x_catch;          % N_{catch} for 100% OVA pMHC

NC_VSV8_0_1 = Bond_total_VSV8_0_1_catch; % N_{catch} for 10/90% VSV8/E1 pMHC
NC_VSV8_0_2 = Bond_total_VSV8_0_2_catch; % N_{catch} for 20/80% VSV8/E1 pMHC
NC_VSV8_0_3 = Bond_total_VSV8_0_3_catch; % N_{catch} for 30/70% VSV8/E1 pMHC
NC_VSV8_1   = Bond_total_VSV8_1x_catch;         % N_{catch} for 100% VSV8 pMHC

% Initialize arrays to record the distribution of microvillus velocities
% and the number of slip and catch bonds within each bin. For each array,
% the pMHC system in the third dimension of each matrix is as follows:
% 1. 100% E1;           2. 10/90% SSB/E1;   3. 20/80% SSB/E1;   
% 4. 30/70% SSB/E1;     5. 100% SSB;        6. 10/90% OVA/E1; 
% 7. 20/80% OVA/E1;     8. 30/70% OVA/E1;   9. 100% OVA; 
% 10. 10/90% VSV8/E1;   11. 20/80% VSV8/E1; 12. 30/70% VSV8/E1; 
% 13. 100% VSV8;
Vel_Distr   = zeros( length(Vel_bin_vec) - 1, 4, 13 );
NS_Distr    = zeros( length(Vel_bin_vec) - 1, 3, 13 );
NC_Distr    = zeros( length(Vel_bin_vec) - 1, 3, 13 );

for ii = 1:( length(Vel_bin_vec) - 1 )          % Iterate through all bins
    for kk = 1:size(VE1_1,2)                    % Iterate through all trajectories
        for jj = 1:size(VE1_1,1)                % Iterate through all sample points
            
            % Update the count (column 1) within the distributions and add
            % the velocity, slip bond, and catch bond data to each
            % appropriate multi-dimensional matrix.
            
            % If the MV velocity for the 100% E1 system is w/in the bin
            if( ( VE1_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VE1_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,1)   = Vel_Distr(ii,1,1) + 1;
                Vel_Distr(ii,2,1)   = Vel_Distr(ii,2,1) + VE1_1(jj,kk);
                NS_Distr(ii,1,1)    = NS_Distr(ii,1,1) + 1;
                NS_Distr(ii,2,1)    = NS_Distr(ii,2,1) + NS_E1_1(jj,kk);
                NC_Distr(ii,1,1)    = NC_Distr(ii,1,1) + 1;
                NC_Distr(ii,2,1)    = NC_Distr(ii,2,1) + NC_E1_1(jj,kk);
            end
            
            % If the MV velocity for the 10% SSB system is w/in the bin
            if( ( VSSB_0_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSSB_0_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,2)   = Vel_Distr(ii,1,2) + 1;
                Vel_Distr(ii,2,2)   = Vel_Distr(ii,2,2) + VSSB_0_1(jj,kk);
                NS_Distr(ii,1,2)    = NS_Distr(ii,1,2) + 1;
                NS_Distr(ii,2,2)    = NS_Distr(ii,2,2) + NS_SSB_0_1(jj,kk);
                NC_Distr(ii,1,2)    = NC_Distr(ii,1,2) + 1;
                NC_Distr(ii,2,2)    = NC_Distr(ii,2,2) + NC_SSB_0_1(jj,kk);
            end
               
            % If the MV velocity for the 20% SSB system is w/in the bin
            if( ( VSSB_0_2(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSSB_0_2(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,3)   = Vel_Distr(ii,1,3) + 1;
                Vel_Distr(ii,2,3)   = Vel_Distr(ii,2,3) + VSSB_0_2(jj,kk);
                NS_Distr(ii,1,3)    = NS_Distr(ii,1,3) + 1;
                NS_Distr(ii,2,3)    = NS_Distr(ii,2,3) + NS_SSB_0_2(jj,kk);
                NC_Distr(ii,1,3)    = NC_Distr(ii,1,3) + 1;
                NC_Distr(ii,2,3)    = NC_Distr(ii,2,3) + NC_SSB_0_2(jj,kk);
            end
            
            % If the MV velocity for the 30% SSB system is w/in the bin
            if( ( VSSB_0_3(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSSB_0_3(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,4)   = Vel_Distr(ii,1,4) + 1;
                Vel_Distr(ii,2,4)   = Vel_Distr(ii,2,4) + VSSB_0_3(jj,kk);
                NS_Distr(ii,1,4)    = NS_Distr(ii,1,4) + 1;
                NS_Distr(ii,2,4)    = NS_Distr(ii,2,4) + NS_SSB_0_3(jj,kk);
                NC_Distr(ii,1,4)    = NC_Distr(ii,1,4) + 1;
                NC_Distr(ii,2,4)    = NC_Distr(ii,2,4) + NC_SSB_0_3(jj,kk);
            end
            
            % If the MV velocity for the 100% SSB system is w/in the bin
            if( ( VSSB_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSSB_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,5)   = Vel_Distr(ii,1,5) + 1;
                Vel_Distr(ii,2,5)   = Vel_Distr(ii,2,5) + VSSB_1(jj,kk);
                NS_Distr(ii,1,5)    = NS_Distr(ii,1,5) + 1;
                NS_Distr(ii,2,5)    = NS_Distr(ii,2,5) + NS_SSB_1(jj,kk);
                NC_Distr(ii,1,5)    = NC_Distr(ii,1,5) + 1;
                NC_Distr(ii,2,5)    = NC_Distr(ii,2,5) + NC_SSB_1(jj,kk);
            end
            
            % If the MV velocity for the 10% OVA system is w/in the bin
            if( ( VOVA_0_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VOVA_0_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,6)   = Vel_Distr(ii,1,6) + 1;
                Vel_Distr(ii,2,6)   = Vel_Distr(ii,2,6) + VOVA_0_1(jj,kk);
                NS_Distr(ii,1,6)    = NS_Distr(ii,1,6) + 1;
                NS_Distr(ii,2,6)    = NS_Distr(ii,2,6) + NS_OVA_0_1(jj,kk);
                NC_Distr(ii,1,6)    = NC_Distr(ii,1,6) + 1;
                NC_Distr(ii,2,6)    = NC_Distr(ii,2,6) + NC_OVA_0_1(jj,kk);
            end
            
            % If the MV velocity for the 20% OVA system is w/in the bin
            if( ( VOVA_0_2(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VOVA_0_2(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,7)   = Vel_Distr(ii,1,7) + 1;
                Vel_Distr(ii,2,7)   = Vel_Distr(ii,2,7) + VOVA_0_2(jj,kk);
                NS_Distr(ii,1,7)    = NS_Distr(ii,1,7) + 1;
                NS_Distr(ii,2,7)    = NS_Distr(ii,2,7) + NS_OVA_0_2(jj,kk);
                NC_Distr(ii,1,7)    = NC_Distr(ii,1,7) + 1;
                NC_Distr(ii,2,7)    = NC_Distr(ii,2,7) + NC_OVA_0_2(jj,kk);
            end
            
            % If the MV velocity for the 30% OVA system is w/in the bin
            if( ( VOVA_0_3(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VOVA_0_3(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,8)   = Vel_Distr(ii,1,8) + 1;
                Vel_Distr(ii,2,8)   = Vel_Distr(ii,2,8) + VOVA_0_3(jj,kk);
                NS_Distr(ii,1,8)    = NS_Distr(ii,1,8) + 1;
                NS_Distr(ii,2,8)    = NS_Distr(ii,2,8) + NS_OVA_0_3(jj,kk);
                NC_Distr(ii,1,8)    = NC_Distr(ii,1,8) + 1;
                NC_Distr(ii,2,8)    = NC_Distr(ii,2,8) + NC_OVA_0_3(jj,kk);
            end
            
            % If the MV velocity for the 100% OVA system is w/in the bin
            if( ( VOVA_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VOVA_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,9)   = Vel_Distr(ii,1,9) + 1;
                Vel_Distr(ii,2,9)   = Vel_Distr(ii,2,9) + VOVA_1(jj,kk);
                NS_Distr(ii,1,9)    = NS_Distr(ii,1,9) + 1;
                NS_Distr(ii,2,9)    = NS_Distr(ii,2,9) + NS_OVA_1(jj,kk);
                NC_Distr(ii,1,9)    = NC_Distr(ii,1,9) + 1;
                NC_Distr(ii,2,9)    = NC_Distr(ii,2,9) + NC_OVA_1(jj,kk);
            end
            
            % If the MV velocity for the 10% VSV8 system is w/in the bin
            if( ( VVSV8_0_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_0_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,10)  = Vel_Distr(ii,1,10) + 1;
                Vel_Distr(ii,2,10)  = Vel_Distr(ii,2,10) + VVSV8_0_1(jj,kk);
                NS_Distr(ii,1,10)   = NS_Distr(ii,1,10) + 1;
                NS_Distr(ii,2,10)   = NS_Distr(ii,2,10) + NS_VSV8_0_1(jj,kk);
                NC_Distr(ii,1,10)   = NC_Distr(ii,1,10) + 1;
                NC_Distr(ii,2,10)   = NC_Distr(ii,2,10) + NC_VSV8_0_1(jj,kk);
            end
            
            % If the MV velocity for the 20% VSV8 system is w/in the bin
            if( ( VVSV8_0_2(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_0_2(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,11)  = Vel_Distr(ii,1,11) + 1;
                Vel_Distr(ii,2,11)  = Vel_Distr(ii,2,11) + VVSV8_0_2(jj,kk);
                NS_Distr(ii,1,11)   = NS_Distr(ii,1,11) + 1;
                NS_Distr(ii,2,11)   = NS_Distr(ii,2,11) + NS_VSV8_0_2(jj,kk);
                NC_Distr(ii,1,11)   = NC_Distr(ii,1,11) + 1;
                NC_Distr(ii,2,11)   = NC_Distr(ii,2,11) + NC_VSV8_0_2(jj,kk);
            end
            
            % If the MV velocity for the 30% VSV8 system is w/in the bin
            if( ( VVSV8_0_3(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_0_3(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,12)  = Vel_Distr(ii,1,12) + 1;
                Vel_Distr(ii,2,12)  = Vel_Distr(ii,2,12) + VVSV8_0_3(jj,kk);
                NS_Distr(ii,1,12)   = NS_Distr(ii,1,12) + 1;
                NS_Distr(ii,2,12)   = NS_Distr(ii,2,12) + NS_VSV8_0_3(jj,kk);
                NC_Distr(ii,1,12)   = NC_Distr(ii,1,12) + 1;
                NC_Distr(ii,2,12)   = NC_Distr(ii,2,12) + NC_VSV8_0_3(jj,kk);
            end
            
            % If the MV velocity for the 100% VSV8 system is w/in the bin
            if( ( VVSV8_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,13)  = Vel_Distr(ii,1,13) + 1;
                Vel_Distr(ii,2,13)  = Vel_Distr(ii,2,13) + VVSV8_1(jj,kk);
                NS_Distr(ii,1,13)   = NS_Distr(ii,1,13) + 1;
                NS_Distr(ii,2,13)   = NS_Distr(ii,2,13) + NS_VSV8_1(jj,kk);
                NC_Distr(ii,1,13)   = NC_Distr(ii,1,13) + 1;
                NC_Distr(ii,2,13)   = NC_Distr(ii,2,13) + NC_VSV8_1(jj,kk);
            end
        end
    end
    
    % Output the progress of the calculation of the 1st section
    display( 100*ii / ( length( Vel_bin_vec ) - 1 ) );
end

for ii = 1:size(Vel_Distr,1)                    % Iterate through all bins
    for jj = 1:13                               % Iterate through all pMHC cases
        
        % Record the mean velocity, number of TCR-E1 pMHC complexes, and
        % TCR-(SSB/OVA/VSV8) pMHC complexes for each pMHC case (column 3)
        Vel_Distr(ii,3,jj)  = Vel_Distr(ii,2,jj) / Vel_Distr(ii,1,jj);
        NS_Distr(ii,3,jj)   = NS_Distr(ii,2,jj) / NS_Distr(ii,1,jj);
        NC_Distr(ii,3,jj)   = NC_Distr(ii,2,jj) / NC_Distr(ii,1,jj);
        
        % Record the probability density within each bin (column 4) for
        % each individual pMHC case
        Vel_Distr(ii,4,jj)  = Vel_Distr(ii,1,jj) / ( Vel_bin*sum( Vel_Distr(:,1,jj) ) );
        
        % If there are no recordings within a bin, replace the 'NaN' value
        % of the velocity array with the mean velocity of the bin.
        % Likewise, replace 'NaN' values of the slip and catch bond
        % distributions with a zero.
        if( Vel_Distr(ii,1,jj) == 0 )
            Vel_Distr(ii,3,jj) =  0.5*( Vel_bin_vec(ii) + Vel_bin_vec(ii+1) );
        end
        
        if( NS_Distr(ii,1,jj) == 0 )
            NS_Distr(ii,3,jj) =  0;
        end
        
        if( NC_Distr(ii,1,jj) == 0 )
            NC_Distr(ii,3,jj) =  0;
        end
    end
end

clear ii jj kk VE1_1 VSSB_0_1 VSSB_0_2 VSSB_0_3 VSSB_1 VOVA_0_1 VOVA_0_2 ...
    VOVA_0_3 VOVA_1 VVSV8_0_1 VVSV8_0_2 VVSV8_0_3 VVSV8_1 NS_E1_1 NS_SSB_0_1 ...
    NS_SSB_0_2 NS_SSB_0_3 NS_SSB_1 NS_OVA_0_1 NS_OVA_0_2 NS_OVA_0_3 NS_OVA_1 ...
    NS_VSV8_0_1 NS_VSV8_0_2 NS_VSV8_0_3 NS_VSV8_1 NC_E1_1 NC_SSB_0_1 NC_SSB_0_2 ...
    NC_SSB_0_3 NC_SSB_1 NC_OVA_0_1 NC_OVA_0_2 NC_OVA_0_3 NC_OVA_1 NC_VSV8_0_1 ...
    NC_VSV8_0_2 NC_VSV8_0_3 NC_VSV8_1;

% String arrays for pMHC case and line color according to titration level 
Color_array = [ 0 1 0; 0 0.749 1; 0 0 1; 0.502 0 1; 1 0 0 ];
SSB_string  = {'$0 \%$ $\mathrm{strong}$ $\mathrm{slip}$',...
    '$10 \%$ $\mathrm{strong}$ $\mathrm{slip}$',...
    '$20 \%$ $\mathrm{strong}$ $\mathrm{slip}$',...
    '$30 \%$ $\mathrm{strong}$ $\mathrm{slip}$',...
    '$100 \%$ $\mathrm{strong}$ $\mathrm{slip}$'};
SSB_string_mod = SSB_string(2:5);
OVA_string  = {'$0 \%$ $\mathrm{OVA}$','$10 \%$ $\mathrm{OVA}$',...
    '$20 \%$ $\mathrm{OVA}$','$30 \%$ $\mathrm{OVA}$','$100 \%$ $\mathrm{OVA}$'};
OVA_string_mod = OVA_string(2:5);
VSV8_string = {'$0 \%$ $\mathrm{VSV8}$','$10 \%$ $\mathrm{VSV8}$',...
    '$20 \%$ $\mathrm{VSV8}$','$30 \%$ $\mathrm{VSV8}$','$100 \%$ $\mathrm{VSV8}$'};
VSV8_string_mod = VSV8_string(2:5);

figure(1); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('Probability Density','FontSize',70,'Interpreter','LaTeX');
for ii = 1:5
    plot(Vel_Distr(:,3,ii),Vel_Distr(:,4,ii),'Color',Color_array(ii,:),'LineWidth',7);
end
h = legend(SSB_string); xlim([-2 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(2); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('Probability Density','FontSize',70,'Interpreter','LaTeX');
plot(Vel_Distr(:,3,1),Vel_Distr(:,4,1),'Color',Color_array(1,:),'LineWidth',7);
for ii = 6:9
    plot(Vel_Distr(:,3,ii),Vel_Distr(:,4,ii),'Color',Color_array(ii-4,:),'LineWidth',7);
end
h = legend(OVA_string); xlim([-2 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(13); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('Probability Density','FontSize',70,'Interpreter','LaTeX');
plot(Vel_Distr(:,3,1),Vel_Distr(:,4,1),'Color',Color_array(1,:),'LineWidth',7);
for ii = 10:13
    plot(Vel_Distr(:,3,ii),Vel_Distr(:,4,ii),'Color',Color_array(ii-8,:),'LineWidth',7);
end
h = legend(VSV8_string); xlim([-2 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(4); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{slip}}$','FontSize',70,'Interpreter','LaTeX');
for ii = 1:4
    plot(NS_NC_Vel_avg_BW_0_2(:,1,ii),NS_NC_Vel_avg_BW_0_2(:,2,ii),'s',...
        'MarkerFaceColor','w','MarkerEdgeColor',Color_array(ii,:),'MarkerSize',20,...
        'LineStyle','-','LineWidth',3,'Color',Color_array(ii,:));
end
h = legend(SSB_string); xlim([-2.01 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(5); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{strong} \, \, \mathrm{slip}}$','FontSize',70,...
    'Interpreter','LaTeX');
for ii = 2:5
    plot(NS_NC_Vel_avg_BW_0_2(:,1,ii),NS_NC_Vel_avg_BW_0_2(:,3,ii),'d',...
        'MarkerFaceColor',Color_array(ii,:),'MarkerEdgeColor',Color_array(ii,:),...
        'MarkerSize',20,'LineStyle','-','LineWidth',3,'Color',Color_array(ii,:));
end
h = legend(SSB_string_mod); xlim([-2.01 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(6); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{slip}}$','FontSize',70,'Interpreter','LaTeX');
plot(NS_NC_Vel_avg_BW_0_2(:,1,1),NS_NC_Vel_avg_BW_0_2(:,2,1),'s',...
        'MarkerFaceColor','w','MarkerEdgeColor',Color_array(1,:),'MarkerSize',20,...
        'LineStyle','-','LineWidth',3,'Color',Color_array(1,:));
for ii = 6:8
    plot(NS_NC_Vel_avg_BW_0_2(:,1,ii),NS_NC_Vel_avg_BW_0_2(:,2,ii),'s',...
        'MarkerFaceColor','w','MarkerEdgeColor',Color_array(ii-4,:),'MarkerSize',20,...
        'LineStyle','-','LineWidth',3,'Color',Color_array(ii-4,:));
end
h = legend(OVA_string); xlim([-2.01 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(7); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{catch}}$','FontSize',70,'Interpreter','LaTeX');
for ii = 6:9
    plot(NS_NC_Vel_avg_BW_0_2(:,1,ii),NS_NC_Vel_avg_BW_0_2(:,3,ii),'d',...
        'MarkerFaceColor',Color_array(ii-5,:),'MarkerEdgeColor',Color_array(ii-5,:),...
        'MarkerSize',20,'LineStyle','-','LineWidth',3,'Color',Color_array(ii-5,:));
end
h = legend(OVA_string_mod); xlim([-2.01 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(8); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{slip}}$','FontSize',70,'Interpreter','LaTeX');
plot(NS_NC_Vel_avg_BW_0_2(:,1,1),NS_NC_Vel_avg_BW_0_2(:,2,1),'s',...
        'MarkerFaceColor','w','MarkerEdgeColor',Color_array(1,:),'MarkerSize',20,...
        'LineStyle','-','LineWidth',3,'Color',Color_array(1,:));
for ii = 10:12
    plot(NS_NC_Vel_avg_BW_0_2(:,1,ii),NS_NC_Vel_avg_BW_0_2(:,2,ii),'s',...
        'MarkerFaceColor','w','MarkerEdgeColor',Color_array(ii-8,:),'MarkerSize',20,...
        'LineStyle','-','LineWidth',3,'Color',Color_array(ii-8,:));
end
h = legend(VSV8_string); xlim([-2.01 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(9); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',55);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',70,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{catch}}$','FontSize',70,'Interpreter','LaTeX');
for ii = 10:13
    plot(NS_NC_Vel_avg_BW_0_2(:,1,ii),NS_NC_Vel_avg_BW_0_2(:,3,ii),'d',...
        'MarkerFaceColor',Color_array(ii-9,:),'MarkerEdgeColor',Color_array(ii-9,:),...
        'MarkerSize',20,'LineStyle','-','LineWidth',3,'Color',Color_array(ii-9,:));
end
h = legend(VSV8_string_mod); xlim([-2.01 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;