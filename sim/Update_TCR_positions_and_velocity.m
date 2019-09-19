% Update_TCR_positions_and_velocity.m

% Update TCR x-coordinates in the TCR, slip bond, and catch bond matrices.
CC_TCR(:,1) = CC_TCR(:,1) + Velocity*CF*dt;     % Update x-coordinate in TCR matrix

for ii = 1:size(CC_SlipBond,1)      % Iterate through the slip bond matrix
    if( CC_SlipBond(ii,7) ~= 0 )    % Update TCR x-coordinates in slip bond matrix
        CC_SlipBond(ii,3) = CC_SlipBond(ii,3) + Velocity*CF*dt;
    end
end

for ii = 1:size(CC_CatchBond,1)     % Iterate through the catch bond matrix
    if( CC_CatchBond(ii,7) ~= 0 )   % Update TCR x-coordinates in catch bond matrix
        CC_CatchBond(ii,3) = CC_CatchBond(ii,3) + Velocity*CF*dt;
    end
end

% Update the microvillus center coordinate given the current velocity.
x_MV0       = x_MV0 + Velocity*CF*dt;   

% Calculate the microvillus velocity at next time step given the current
% total force, microvillus threshold force, and MV velocity model.
if( Vel_case == 1 )                 % Linear microvillus velocity model
    Velocity     = (V0/MV_thresh)*( MV_thresh - MV_Force(1,3) );
else                                % Hill function microvillus velocity
    if( MV_Force(1,3) < 0 )         % If VMV < 0, VMV = V0
        Velocity = V0;
    else
        Velocity = V0*( 1 / ( 1 + ( MV_Force(1,3)/K_MV )^n_MV ) );
    end
end