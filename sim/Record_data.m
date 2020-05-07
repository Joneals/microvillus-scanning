% Record_data.m

% If a sample point is reached, record chemical species matrices and forces
C_Ag(:,:,sampleCount)   = CC_Ag(:,:);       % Record the OVA / SSB / VSV8 pMHC positions
C_E1(:,:,sampleCount)   = CC_E1(:,:);       % Record the E1 pMHC positions
C_Catch(:,:,sampleCount)= 0;                % Set all current values to zero for catch bond matrix
C_Slip(:,:,sampleCount) = 0;                % Set all current values to zero for slip bond matrix
C_TCR(:,:,sampleCount)  = CC_TCR(:,:);      % Record the T cell receptor positions
MV_center(sampleCount)  = x_MV0;            % Record the microvillus center

% Use the C_Slip and C_Catch matrices to record bonds at sample points. The
% matrices are structures s.t. the first two columns record the x- and y-
% coordinates of the pMHC, respectively. Similarly, the third and fourth
% columns record the x- and y-coordinates of the TCR, respectively. The
% individual pMHC and TCR are recorded in the fifth and sixth columns. The
% seventh column represents the individual bond number. The eighth column
% calculates the force on the bond (pN) at the given sample point.

for ii = 1:size(CC_SlipBond,1)
    for jj = 1:size(CC_SlipBond,2)
        C_Slip(ii,jj,sampleCount)   = CC_SlipBond(ii,jj);   % Record the slip bond matrix
    end
end

for ii = 1:size(CC_CatchBond,1)
    for jj = 1:size(CC_CatchBond,2)
        C_Catch(ii,jj,sampleCount)  = CC_CatchBond(ii,jj);  % Record the catch bond matrix
    end
end

% Calculate the forces on each slip and catch bond present in the system.
if( nE1 ~= 0 )
    for ii = 1:size(C_Slip,1)
        if( sum( C_Slip(ii,1:7,sampleCount) ) ~= 0 )
            
            Dist_Slip  = sqrt( ( Height )^2 + ...
                ( C_Slip(ii,1,sampleCount) - C_Slip(ii,3,sampleCount) )^2 + ...
                ( C_Slip(ii,2,sampleCount) - C_Slip(ii,4,sampleCount) )^2 );
            
            Delta_xc_slip = sqrt( ( C_Slip(ii,1,sampleCount) - C_Slip(ii,3,sampleCount) )^2 );

            C_Slip(ii,8,sampleCount) = k_bond*( Delta_xc_slip/Dist_Slip )*abs( z_bond - Dist_Slip );
            
            % Compare x-coordinates of the E1 pMHC and TCR to determine if
            % if the force imposed on the microvillus is "negative".
            if( C_Slip(ii,1,sampleCount) > C_Slip(ii,3,sampleCount) )
                C_Slip(ii,8,sampleCount) = -C_Slip(ii,8,sampleCount);
            end
            
        else
            C_Slip(ii,8,sampleCount)    = 0;
        end
    end
end

if( nAg ~= 0 )
    for ii = 1:size(C_Catch,1)
        if( sum( C_Catch(ii,1:7,sampleCount) ) ~= 0 )
            
            Dist_Catch  = sqrt( ( Height )^2 + ...
                ( C_Catch(ii,1,sampleCount) - C_Catch(ii,3,sampleCount) )^2 + ...
                ( C_Catch(ii,2,sampleCount) - C_Catch(ii,4,sampleCount) )^2 );
            
            Delta_xc_catch = sqrt( ( C_Catch(ii,1,sampleCount) - C_Catch(ii,3,sampleCount) )^2 );
            
            C_Catch(ii,8,sampleCount) = k_bond*( Delta_xc_catch/Dist_Catch )*abs( z_bond - Dist_Catch );
            
            % Compare x-coordinates of the E1_Strong pMHC and TCR to determine if
            % the force imposed on the microvillus is "negative".
            if( C_Catch(ii,1,sampleCount) > C_Catch(ii,3,sampleCount) )
                C_Catch(ii,8,sampleCount) = -C_Catch(ii,8,sampleCount);
            end
            
        else
            C_Catch(ii,8,sampleCount)   = 0;
        end
    end
end
