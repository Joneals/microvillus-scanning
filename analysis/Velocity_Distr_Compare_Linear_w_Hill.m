% Velocity_Distr_Compare_Linear_w_Hill.m

Vel_lim     = [-3.6 9.2];                       % Velocity distribution limits
Vel_bin     = 0.05;                             % Velocity distribution bin width
Vel_bin_vec = Vel_lim(1):Vel_bin:Vel_lim(2);    % Velocity bin vector

% Retrieve all data for the velocity probability distributions
VE1_1       = Velocity_E1_1x_all;               % 100% E1 pMHC linear velocities 
VE1_Hill    = Velocity_E1_1x_Hill_all;          % 100% E1 pMHC Hill velocities

VOVA_1      = Velocity_OVA_1x_all;              % 100% OVA pMHC linear velocities
VOVA_Hill   = Velocity_OVA_1x_Hill_all;         % 100% OVA pMHC Hill velocities

VVSV8_1     = Velocity_VSV8_1x_all;             % 100% VSV8 pMHC linear velocities
VVSV8_Hill  = Velocity_VSV8_1x_Hill_all;        % 100% VSV8 pMHC Hill velocities

% Initialize array to record the distribution of microvillus velocites. The
% order for the pMHC in the third dimension of each matrix is as follows:
% 1. 100% E1 (linear);  2. 100% E1 (Hill);      3. 100% OVA (linear);
% 4. 100% OVA (Hill);   5. 100% VSV8 (linear);  6. 100% VSV8 (Hill);
Vel_Compare_Distr = zeros( length(Vel_bin_vec) - 1, 4, 6 );

for ii = 1:( length(Vel_bin_vec) - 1 )          % Iterate through all bins
    for kk = 1:size(VE1_1,2)                    % Iterate through all trajectories
        for jj = 1:size(VE1_1,1)                % Iterate through all sample points
            
            % Update the count (column 1) within the distributions and add
            % the velocity, slip bond, and catch bond data to each
            % appropriate multi-dimensional matrix.
            
            % If the MV velocity for the 100% E1 (linear) system is w/in the bin
            if( ( VE1_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VE1_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Compare_Distr(ii,1,1)   = Vel_Compare_Distr(ii,1,1) + 1;
                Vel_Compare_Distr(ii,2,1)   = Vel_Compare_Distr(ii,2,1) + VE1_1(jj,kk);
            end
            
            % If the MV velocity for the 100% E1 (Hill) system is w/in the bin
            if( ( VE1_Hill(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VE1_Hill(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Compare_Distr(ii,1,2)   = Vel_Compare_Distr(ii,1,2) + 1;
                Vel_Compare_Distr(ii,2,2)   = Vel_Compare_Distr(ii,2,2) + VE1_Hill(jj,kk);
            end
            
            % If the MV velocity for the 100% OVA (linear) system is w/in the bin
            if( ( VOVA_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VOVA_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Compare_Distr(ii,1,3)   = Vel_Compare_Distr(ii,1,3) + 1;
                Vel_Compare_Distr(ii,2,3)   = Vel_Compare_Distr(ii,2,3) + VOVA_1(jj,kk);
            end
            
            % If the MV velocity for the 100% OVA (Hill) system is w/in the bin
            if( ( VOVA_Hill(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VOVA_Hill(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Compare_Distr(ii,1,4)   = Vel_Compare_Distr(ii,1,4) + 1;
                Vel_Compare_Distr(ii,2,4)   = Vel_Compare_Distr(ii,2,4) + VOVA_Hill(jj,kk);
            end
            
            % If the MV velocity for the 100% VSV8 (linear) system is w/in the bin
            if( ( VVSV8_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Compare_Distr(ii,1,5)   = Vel_Compare_Distr(ii,1,5) + 1;
                Vel_Compare_Distr(ii,2,5)   = Vel_Compare_Distr(ii,2,5) + VVSV8_1(jj,kk);
            end
            
            % If the MV velocity for the 100% VSV8 (Hill) system is w/in the bin
            if( ( VVSV8_Hill(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_Hill(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Compare_Distr(ii,1,6)   = Vel_Compare_Distr(ii,1,6) + 1;
                Vel_Compare_Distr(ii,2,6)   = Vel_Compare_Distr(ii,2,6) + VVSV8_Hill(jj,kk);
            end
        end 
    end
    
    % Output the progress of the calculation of the 1st section
    display( 100*ii / ( length( Vel_bin_vec ) - 1 ) );
end

for ii = 1:size(Vel_Compare_Distr,1)            % Iterate through all bins
    for jj = 1:6                                % Iterate through all pMHC cases
        
        % Record the mean velocity for each pMHC case (column 3)
        Vel_Compare_Distr(ii,3,jj)  = Vel_Compare_Distr(ii,2,jj) / ...
            Vel_Compare_Distr(ii,1,jj);
        
        % Record the probability density within each bin (column 4) for
        % each individual pMHC case
        Vel_Compare_Distr(ii,4,jj)  = Vel_Compare_Distr(ii,1,jj) / ...
            ( Vel_bin*sum( Vel_Compare_Distr(:,1,jj) ) );
        
        % If there are no recordings within a bin, replace the 'NaN' value
        % of the velocity array with the mean velocity of the bin.
        if( Vel_Compare_Distr(ii,1,jj) == 0 )
            Vel_Compare_Distr(ii,3,jj) =  0.5*( Vel_bin_vec(ii) + Vel_bin_vec(ii+1) );
        end
    end
end

clear ii jj kk VE1_1 VE1_Hill VOVA_1 VOVA_Hill VVSV8_1 VVSV8_Hill;

V0          = 5.20;                                 % Initial microvillus velocity      [µm/min]
MV_thresh   = 50;                                   % Set a microvillus threshold force [pN]
K_MV        = 25.0;                                 % Velocity hill function ref. force [pN]
n_MV        = 4.0;                                  % Velocity hill function exponent
Force_vec   = 0:0.001:50;                           % Force vector
VLin_vec    = (V0/MV_thresh)*(MV_thresh-Force_vec); % Linear velocity function
VHill_vec   = V0*(1./(1+(Force_vec./K_MV).^n_MV));  % Hill velocity function

figure(1); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('Force (pN)','FontSize',90,'Interpreter','LaTeX');
ylabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
plot(Force_vec(1,:),VLin_vec(1,:),'g','LineWidth',7);
plot(Force_vec(1,:),VHill_vec(1,:),'b','LineWidth',7);
h = legend('$V_{\mathrm{linear}}$','$V_{\mathrm{hill}}$'); axis([0 50 0 5.5]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(2); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
ylabel('Probability Density','FontSize',90,'Interpreter','LaTeX');
plot(Vel_Compare_Distr(:,3,1),Vel_Compare_Distr(:,4,1),'g','LineWidth',7);
plot(Vel_Compare_Distr(:,3,2),Vel_Compare_Distr(:,4,2),'k','LineWidth',7);
h = legend('$V_{\mathrm{linear}}$','$V_{\mathrm{hill}}$'); xlim([-2 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(3); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
ylabel('Probability Density','FontSize',90,'Interpreter','LaTeX');
plot(Vel_Compare_Distr(:,3,3),Vel_Compare_Distr(:,4,3),'b','LineWidth',7);
plot(Vel_Compare_Distr(:,3,4),Vel_Compare_Distr(:,4,4),'k','LineWidth',7);
h = legend('$V_{\mathrm{linear}}$','$V_{\mathrm{hill}}$'); xlim([-2 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(4); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
ylabel('Probability Density','FontSize',90,'Interpreter','LaTeX');
plot(Vel_Compare_Distr(:,3,5),Vel_Compare_Distr(:,4,5),'r','LineWidth',7);
plot(Vel_Compare_Distr(:,3,6),Vel_Compare_Distr(:,4,6),'k','LineWidth',7);
h = legend('$V_{\mathrm{linear}}$','$V_{\mathrm{hill}}$'); xlim([-2 8]);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;