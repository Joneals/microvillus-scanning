k_slip  = 1;                        % Counter for slip bond distribution matrix
k_catch = 1;                        % Counter for catch bond distribution matrix
k_tot   = 1;                        % Counter for total bond distribution matrix

RL_engage_slip  = zeros(60001,25);  % Initialize slip bond engagement matrix
RL_engage_catch = zeros(60001,25);  % Initialize catch bond engagement matrix
RL_engage_tot   = zeros(60001,25);  % Initialize total bond engagement matrix

for n = 1:25
    load(['VSV8_1x_08_13_T' num2str(n) '.mat']);
    
    for ii = 1:size(Bond_distr_VSV8_1x_T,1)
        
        if( Bond_distr_VSV8_1x_T(ii,3) == 1 )
            Bond_distr_slip(k_slip,1:2) = Bond_distr_VSV8_1x_T(ii,1:2);
            k_slip = k_slip + 1;
        else
            Bond_distr_catch(k_catch,1:2) = Bond_distr_VSV8_1x_T(ii,1:2);
            k_catch = k_catch + 1;
        end
        
        Bond_distr_tot(k_tot,1:2) = Bond_distr_VSV8_1x_T(ii,1:2);
        k_tot = k_tot + 1;
    end
    
    jj = 1;                 % Counter for RL_engagement matrices (tracks time)
    
    for t = 0:0.001:60
        
        for ii = 1:length(Bond_distr_slip)
            if( ( t > Bond_distr_slip(ii,1) )&&( t <= Bond_distr_slip(ii,2) ) )
                RL_engage_slip(jj,n) = RL_engage_slip(jj,n) + ...
                    ( t - Bond_distr_slip(ii,1) );
            end
        end
        
        for ii = 1:length(Bond_distr_catch)
            if( ( t > Bond_distr_catch(ii,1) )&&( t <= Bond_distr_catch(ii,2) ) )
                RL_engage_catch(jj,n) = RL_engage_catch(jj,n) + ...
                    ( t - Bond_distr_catch(ii,1) );
            end
        end
        
        RL_engage_tot(jj,n) = RL_engage_slip(jj,n) + RL_engage_catch(jj,n);
        jj = jj + 1;
    end
    
    clear Bond_distr_VSV8_1x_T Bond_distr_slip Bond_distr_catch Bond_distr_tot; 
    display(n);
end

for n = 1:60001
    RL_engage_slip(n,26)    = mean( RL_engage_slip(n,1:25) );
    RL_engage_catch(n,26)   = mean( RL_engage_catch(n,1:25) );
    RL_engage_tot(n,26)     = mean( RL_engage_tot(n,1:25) );
end
            
RL_engage_VSV8_1x_slip  = RL_engage_slip;
RL_engage_VSV8_1x_catch = RL_engage_catch;
RL_engage_VSV8_1x_total = RL_engage_tot;