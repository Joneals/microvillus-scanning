% Velocity_NBonds_Force_calculation.m   

VFSampleCT          = VFSampleCT + 1;   % Update the counter for recording matrices
V_MV(VFSampleCT,1)  = Velocity;         % Record the microvillus velocity
F_MV(VFSampleCT,:)  = MV_Force(1,:);    % Record the forces by slip and catch bonds

SB_matrix_int(:,:)  = 0;                % Set temporary slip bond matrix values to zero
CB_matrix_int(:,:)  = 0;                % Set temporary catch bond matrix values to zero

for ii = 1:size(CC_SlipBond,1)          % Record the values of the slip bond matrix
    for jj = 1:size(CC_SlipBond,2)
        SB_matrix_int(ii,jj) = CC_SlipBond(ii,jj);
    end
end

for ii = 1:size(CC_CatchBond,1)         % Record the values of the catch bond matrix
    for jj = 1:size(CC_CatchBond,2)
        CB_matrix_int(ii,jj) = CC_CatchBond(ii,jj);
    end
end

% Record number of slip bonds, catch bonds, and total bonds in the system.
Bond_total(VFSampleCT,1) = length( find( SB_matrix_int(:,1) ) );
Bond_total(VFSampleCT,2) = length( find( CB_matrix_int(:,1) ) );
Bond_total(VFSampleCT,3) = sum( Bond_total(VFSampleCT,1:2) );