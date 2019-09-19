Bond_distr_slip = zeros(1,1); Bond_distr_catch = zeros(1,1);

for n = 1:25
    
    load(['VSV8_0_E1_1_DTCR_0_02_25_T' num2str(n) '.mat']);
    
    Bond_total_VSV8_0_DTCR_0_slip(:,n)  = Bond_total_VSV8_0_DTCR_0_T(:,1);
    Bond_total_VSV8_0_DTCR_0_catch(:,n) = Bond_total_VSV8_0_DTCR_0_T(:,2);
    MV_center_VSV8_0_DTCR_0_all(:,n)    = MV_center_VSV8_0_DTCR_0_T(1,:);
    MV_Force_VSV8_0_DTCR_0_slip(:,n)    = MV_Force_VSV8_0_DTCR_0_T(:,1);
    MV_Force_VSV8_0_DTCR_0_catch(:,n)   = MV_Force_VSV8_0_DTCR_0_T(:,2);
    Velocity_VSV8_0_DTCR_0_all(:,n)     = Velocity_VSV8_0_DTCR_0_T(:,1);
    
    ll = 1; mm = 1; nn = 1;
    
    if( n > 1 )
        ll = length(Bond_distr_slip) + 1; 
        mm = length(Bond_distr_catch) + 1;
    end
    
    for kk = 1:length(Bond_distr_VSV8_0_01_T)
        
        if( Bond_distr_VSV8_0_01_T(kk,3) == 1 )
            Bond_distr_slip(ll,1) = Bond_distr_VSV8_0_01_T(kk,4);
            ll = ll + 1;
        else
            Bond_distr_catch(mm,1) = Bond_distr_VSV8_0_01_T(kk,4);
            mm = mm + 1;
        end
    end
    
%     oo = 1;
%     for ii = 1:(tf/(dt*10))
%         if( Velocity_VSV8_0_DTCR_0_all(ii,n) < 0.50 )
%             SSB_0_1_VMV_leq_0_5(oo,1+2*(n-1)) = (dt*10)*ii;
%             SSB_0_1_VMV_leq_0_5(oo,2*n) = Velocity_VSV8_0_DTCR_0_all(ii,n);
%             oo = oo + 1;
%         end
%     end
    
    clearvars -except Binding_rad Color_array DC_E1 DC_OVA DC_TCR delta_x ...
        delta_x_AM dt dx Height k_bond MV_thresh n nE1 nOVA npMHC nTCR ...
        Rad_mv Rad_par rho_pMHC tf time_vec2 V0 Bond_distr_catch Bond_distr_slip ...
        Bond_total_VSV8_0_DTCR_0_slip Bond_total_VSV8_0_DTCR_0_catch ...
        MV_center_VSV8_0_DTCR_0_all MV_Force_VSV8_0_DTCR_0_slip ...
        MV_Force_VSV8_0_DTCR_0_catch Velocity_VSV8_0_DTCR_0_all;
    
    display(n);
end
      
VSV8_0_DTCR_0_Slip_Lifetimes    = Bond_distr_slip;
VSV8_0_DTCR_0_Catch_Lifetimes   = Bond_distr_catch;
% OVA_1x_Frac_Bound        = mean( OVA_1x_pMHC_bound(end,:) );

VSV8_0_DTCR_0_Bond_Lifetime     = ...
    [ mean(Bond_distr_slip) std(Bond_distr_slip) mean(Bond_distr_catch) std(Bond_distr_catch) ];

VSV8_0_DTCR_0_Bond_tot_avg      = ...
    [ mean2(Bond_total_VSV8_0_DTCR_0_slip)  std2(Bond_total_VSV8_0_DTCR_0_slip) ...
        mean2(Bond_total_VSV8_0_DTCR_0_catch) std2(Bond_total_VSV8_0_DTCR_0_catch) ]; 
        
VSV8_0_DTCR_0_Vel_avg           = ...
    [ mean2(Velocity_VSV8_0_DTCR_0_all) std2(Velocity_VSV8_0_DTCR_0_all) ];

for n = 1:600
    MV_center_VSV8_0_DTCR_0_all(n,26) = mean( MV_center_VSV8_0_DTCR_0_all(n,1:25) );
end

min(min(Velocity_VSV8_0_DTCR_0_all));

clear Bond_distr_catch Bond_distr_slip n ans;