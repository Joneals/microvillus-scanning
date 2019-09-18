% Calculation_Velocity_Distr.m

Vel_lim     = [-3.5 10];                                    % Velocity distribution limits
Vel_bin     = 0.05;                                         % Velocity distribution bin width
Vel_bin_vec = Vel_lim(1):Vel_bin:Vel_lim(2);                % Velocity bin vector

% Retrieve all data for the velocity probability distributions
VVSV8_0_1_DTCR_0     = Velocity_VSV8_0_10_DTCR_0_all;       % DTCR = 0
VVSV8_0_1_DTCR_1e4   = Velocity_VSV8_0_1_all;               % DTCR = 1e4
VVSV8_0_1_DTCR_3_4e4 = Velocity_VSV8_0_10_DTCR_0_034_all;   % DTCR = 3.4e4

VVSV8_0_3_DTCR_0     = Velocity_VSV8_0_30_DTCR_0_all;       % DTCR = 0
VVSV8_0_3_DTCR_1e4   = Velocity_VSV8_0_3_all;               % DTCR = 1e4
VVSV8_0_3_DTCR_3_4e4 = Velocity_VSV8_0_30_DTCR_0_034_all;   % DTCR = 3.4e4

% Initialize arrays to record the distribution of microvillus velocities
% and the number of slip and catch bonds within each bin. For each array,
% the pMHC system in the third dimension of each matrix is as follows:
% 1. 100% E1;   2. 10% VSV8;   3. 20% VSV8;   4. 30% VSV8;   5. 100% VSV8;        
% 6. 100% E1, DTCR = 0;        7. 10% VSV8, DTCR = 0;        8. 20% VSV8, DTCR = 0;   
% 9. 30% VSV8, DTCR = 0;       10. 00% VSV8, DTCR = 0;
Vel_Distr   = zeros( length(Vel_bin_vec) - 1, 4, 10 );

for ii = 1:( length(Vel_bin_vec) - 1 )          % Iterate through all bins
    for kk = 1:size(VE1_1,2)                    % Iterate through all trajectories
        for jj = 1:size(VE1_1,1)                % Iterate through all sample points
            
            % Update the count (column 1) within the distributions and add
            % the velocity, slip bond, and catch bond data to each
            % appropriate multi-dimensional matrix.
            
            % If the MV velocity for the 10% VSV8 system is w/in the bin
            if( ( VVSV8_0_1_DTCR_0(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_0_1_DTCR_0(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,1)   = Vel_Distr(ii,1,1) + 1;
                Vel_Distr(ii,2,1)   = Vel_Distr(ii,2,1) + VVSV8_0_1_DTCR_0(jj,kk);
            end
               
            % If the MV velocity for the 20% VSV8 system is w/in the bin
            if( ( VVSV8_0_1_DTCR_1e4(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_0_1_DTCR_1e4(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,2)   = Vel_Distr(ii,1,2) + 1;
                Vel_Distr(ii,2,2)   = Vel_Distr(ii,2,2) + VVSV8_0_1_DTCR_1e4(jj,kk);
            end
            
            % If the MV velocity for the 30% VSV8 system is w/in the bin
            if( ( VVSV8_0_1_DTCR_3_4e4(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_0_1_DTCR_3_4e4(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,4)   = Vel_Distr(ii,1,4) + 1;
                Vel_Distr(ii,2,4)   = Vel_Distr(ii,2,4) + VVSV8_0_1_DTCR_3_4e4(jj,kk);
            end
            
            % If the MV velocity for the 100% VSV8 system is w/in the bin
            if( ( VVSV8_1(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VVSV8_1(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,5)   = Vel_Distr(ii,1,5) + 1;
                Vel_Distr(ii,2,5)   = Vel_Distr(ii,2,5) + VVSV8_1(jj,kk);
            end
            
            % Check the MV velocity for the 100% E1, DTCR = 0 system
            if( ( VE1_1_DTCR_0(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VE1_1_DTCR_0(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,6)   = Vel_Distr(ii,1,6) + 1;
                Vel_Distr(ii,2,6)   = Vel_Distr(ii,2,6) + VE1_1_DTCR_0(jj,kk);
            end
            
            % Check the MV velocity for the 10% VSV8, DTCR = 0 system
            if( ( VSV8_0_10_DTCR_0(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSV8_0_10_DTCR_0(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,7)   = Vel_Distr(ii,1,7) + 1;
                Vel_Distr(ii,2,7)   = Vel_Distr(ii,2,7) + VSV8_0_10_DTCR_0(jj,kk);
            end
            
            % Check the MV velocity for the 20% VSV8, DTCR = 0 system
            if( ( VSV8_0_20_DTCR_0(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSV8_0_20_DTCR_0(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,8)   = Vel_Distr(ii,1,8) + 1;
                Vel_Distr(ii,2,8)   = Vel_Distr(ii,2,8) + VSV8_0_20_DTCR_0(jj,kk);
            end
            
            % Check the MV velocity for the 30% VSV8, DTCR = 0 system
            if( ( VSV8_0_30_DTCR_0(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSV8_0_30_DTCR_0(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,9)   = Vel_Distr(ii,1,9) + 1;
                Vel_Distr(ii,2,9)   = Vel_Distr(ii,2,9) + VSV8_0_30_DTCR_0(jj,kk);
            end
            
            % Check the MV velocity for the 100% VSV8, DTCR = 0 system
            if( ( VSV8_1_DTCR_0(jj,kk) >= Vel_bin_vec(ii) )&& ...
                ( VSV8_1_DTCR_0(jj,kk) <  Vel_bin_vec(ii+1) ) )
                Vel_Distr(ii,1,10)  = Vel_Distr(ii,1,10) + 1;
                Vel_Distr(ii,2,10)  = Vel_Distr(ii,2,10) + VSV8_1_DTCR_0(jj,kk);
            end
            
        end
    end
    
    % Output the progress of the calculation of the 1st section
    display( 100*ii / ( length( Vel_bin_vec ) - 1 ) );
end

for ii = 1:size(Vel_Distr,1)                    % Iterate through all bins
    for jj = 1:10                               % Iterate through all pMHC cases
        
        % Record the mean velocity, number of TCR-E1 pMHC complexes, and
        % TCR-(SSB/OVA/VSV8) pMHC complexes for each pMHC case (column 3)
        Vel_Distr(ii,3,jj)  = Vel_Distr(ii,2,jj) / Vel_Distr(ii,1,jj);
        
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
    end
end

clear ii jj kk VE1_1 VVSV8_0_1 VVSV8_0_2 VVSV8_0_3 VVSV8_1 VE1_1_DTCR_0 ...
    VSV8_0_10_DTCR_0 VSV8_0_20_DTCR_0 VSV8_0_30_DTCR_0 VSV8_1_DTCR_0;

% String arrays for pMHC case and line color according to titration level 
Color_array = [ 0 1 0; 0 0.749 1; 0 0 1; 0.502 0 1; 1 0 0 ]; time_vec2 = 0:60/599:60;
VSV8_string = {'$0 \%$ $\mathrm{VSV8}$','$10 \%$ $\mathrm{VSV8}$',...
    '$20 \%$ $\mathrm{VSV8}$','$30 \%$ $\mathrm{VSV8}$','$100 \%$ $\mathrm{VSV8}$'};

figure(1); hold on; set(gca,'LineWidth',2.5,'FontSize',75,'XTick',-1:2:7);
set(gcf,'Color','w'); box on; xlim([-1 7]);
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
ylabel('Probability Density','FontSize',90,'Interpreter','LaTeX');
for ii = 1:5
    plot(Vel_Distr(:,3,ii),Vel_Distr(:,4,ii),'Color',Color_array(ii,:),'LineWidth',7);
end
for ii = 6:10
     plot(Vel_Distr(:,3,ii),Vel_Distr(:,4,ii),'LineStyle','--',...
         'Color',Color_array(ii-5,:),'LineWidth',7);
end
h = legend(VSV8_string);
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

figure(2); hold on; set(gca,'LineWidth',2.5,'FontSize',75,'XTick',0:20:60,'YTick',0:1:4);
set(gcf,'Color','w'); xlabel('Time (s)','FontSize',90,'Interpreter','LaTeX');
ylabel('$\overline{x}_{\mathrm{MV}}$ ($\mu m$)','FontSize',90,'Interpreter','LaTeX');
plot(time_vec2,MV_center_E1_1x_all(:,end)/1000,'LineWidth',7,'Color',Color_array(1,1:3));
plot(time_vec2,MV_center_VSV8_0_1_all(:,end)/1000,'LineWidth',7,'Color',Color_array(2,1:3));
plot(time_vec2,MV_center_VSV8_0_2_all(:,end)/1000,'LineWidth',7,'Color',Color_array(3,1:3));
plot(time_vec2,MV_center_VSV8_0_3_all(:,end)/1000,'LineWidth',7,'Color',Color_array(4,1:3));
plot(time_vec2,MV_center_VSV8_1x_all(:,end)/1000,'LineWidth',7,'Color',Color_array(5,1:3));
plot(time_vec2,MV_center_VSV8_0_DTCR_0_all(:,end)/1000,'LineStyle','--','LineWidth',7,...
    'Color',Color_array(1,1:3));
plot(time_vec2,MV_center_VSV8_0_10_DTCR_0_all(:,end)/1000,'LineStyle','--','LineWidth',7,...
    'Color',Color_array(2,1:3));
plot(time_vec2,MV_center_VSV8_0_20_DTCR_0_all(:,end)/1000,'LineStyle','--','LineWidth',7,...
    'Color',Color_array(3,1:3));
plot(time_vec2,MV_center_VSV8_0_30_DTCR_0_all(:,end)/1000,'LineStyle','--','LineWidth',7,...
    'Color',Color_array(4,1:3));
plot(time_vec2,MV_center_VSV8_1_DTCR_0_all(:,end)/1000,'LineStyle','--','LineWidth',...
    7,'Color',Color_array(5,1:3));
h = legend(VSV8_string); 
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthWest'); hold off;

figure(3); hold on; set(gcf,'Color','w'); 
set(gca,'LineWidth',2.5,'FontSize',75,'XTick',-1:2:7,'YTick',0:0.2:1,'ColorOrder',Color_array);
for ii = 1:5
    cdfplot(Velocity_matrix_compare_DTCR(:,ii));
end
xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
ylabel('CDF','FontSize',90,'Interpreter','LaTeX');
h = legend(VSV8_string); axis([-1 7 0 1]); grid off; box on;
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','SouthEast'); hold off;

% figure(3); hold on; set(gca,'LineWidth',2.5,'FontSize',75,'XTick',-1:2:7);
% set(gcf,'Color','w'); box on; xlim([-1 7]);
% xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
% ylabel('Probability Density','FontSize',90,'Interpreter','LaTeX');
% for ii = 1:5
%     plot(Vel_Distr(:,3,ii),Vel_Distr(:,4,ii),'Color',Color_array(ii,:),'LineWidth',7);
% end
% h = legend(VSV8_string); 
% set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

% figure(4); hold on; set(gca,'LineWidth',2.5,'FontSize',75,'XTick',-1:2:7);
% set(gcf,'Color','w'); box on; xlim([-1 7]);
% xlabel('$V_{\mathrm{MV}}$ ($\mu m$/$\mathrm{min}$)','FontSize',90,'Interpreter','LaTeX');
% ylabel('Probability Density','FontSize',90,'Interpreter','LaTeX');
% title('$D_{\mathrm{TCR}}$ $=$ $0$ $\mu \mathrm{m}^2/s$','FontSize',90,'Interpreter','LaTeX');
% for ii = [6 7 9 10]
%     plot(Vel_Distr(:,3,ii),Vel_Distr(:,4,ii),'Color',Color_array(ii-5,:),'LineWidth',7);
% end
% h = legend(VSV8_string); 
% set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

% figure(5); hold on; set(gca,'LineWidth',2.5,'FontSize',75,'XTick',0:20:60,'YTick',0:1:4);
% set(gcf,'Color','w'); xlabel('Time (s)','FontSize',90,'Interpreter','LaTeX');
% ylabel('$\overline{x}_{\mathrm{MV}}$ ($\mu m$)','FontSize',90,'Interpreter','LaTeX');
% plot(time_vec2,MV_center_E1_1x_all(:,end)/1000,'LineWidth',12,'Color',Color_array(1,1:3));
% plot(time_vec2,MV_center_VSV8_0_1_all(:,end)/1000,'LineWidth',12,'Color',Color_array(2,1:3));
% plot(time_vec2,MV_center_VSV8_0_2_all(:,end)/1000,'LineWidth',12,'Color',Color_array(3,1:3));
% plot(time_vec2,MV_center_VSV8_0_3_all(:,end)/1000,'LineWidth',12,'Color',Color_array(4,1:3));
% plot(time_vec2,MV_center_VSV8_1x_all(:,end)/1000,'LineWidth',12,'Color',Color_array(5,1:3));
% h = legend(VSV8_string); 
% set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;

% figure(6); hold on; set(gca,'LineWidth',2.5,'FontSize',75,'XTick',0:20:60,'YTick',0:1:4);
% set(gcf,'Color','w'); xlabel('Time (s)','FontSize',90,'Interpreter','LaTeX');
% title('$D_{\mathrm{TCR}}$ $=$ $0$ $\mu \mathrm{m}^2/s$','Interpreter','LaTeX','FontSize',90);
% ylabel('$\overline{x}_{\mathrm{MV}}$ ($\mu m$)','FontSize',90,'Interpreter','LaTeX');
% plot(time_vec2,MV_center_VSV8_0_DTCR_0_all(:,end)/1000,'LineWidth',12,'Color',Color_array(1,1:3));
% plot(time_vec2,MV_center_VSV8_0_10_DTCR_0_all(:,end)/1000,'LineWidth',12,'Color',Color_array(2,1:3));
% plot(time_vec2,MV_center_VSV8_0_20_DTCR_0_all(:,end)/1000,'LineWidth',12,'Color',Color_array(3,1:3));
% plot(time_vec2,MV_center_VSV8_0_30_DTCR_0_all(:,end)/1000,'LineWidth',12,'Color',Color_array(4,1:3));
% plot(time_vec2,MV_center_VSV8_1_DTCR_0_all(:,end)/1000,'LineWidth',12,'Color',Color_array(5,1:3));
% h = legend(VSV8_string); 
% set(h,'EdgeColor','w','Interpreter','LaTeX','Location','NorthEast'); hold off;