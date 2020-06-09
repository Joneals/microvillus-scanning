% MV_scan_APC.m
function MV_scan_APC(iteration)

addpath('./sim');

%-------------------------------------------------------------------------%
% OUTPUT OPTIONS
%-------------------------------------------------------------------------%

outputFolder = "output";
outputBasename = "";
saveInterval = 1.0;
   
%-------------------------------------------------------------------------%
% PROVIDE RNG SEED 
%-------------------------------------------------------------------------%

rng('shuffle');									% Initialize the generator with a random seed
seed = rng;             						% Store the seed for reproducibility

%-------------------------------------------------------------------------%
% DEFINE PARAMETERS
%-------------------------------------------------------------------------%

u_drag 		= 1;								% Drag coefficient for pMHCs			[pN-min/um]
jjj         = 0.3;					            % Fraction of agonist pMHC molecules
Ag_case     = 3;                                % State agonist pMHC case (VSV8-1, OVA-2, strong slip-3)
Vel_case    = 1;                                % State which velocity case (Linear - 1, Hill - 2)
L_max       = 5.20*1000;                        % Length of the domain w/o microvillus  [nm]
V0          = 5.20;                             % Initial microvillus velocity          [um/min]
CF          = 1000/60;                          % Conversion factor         [um/min] -> [nm/s]
tf          = 0.01;                             % Final time point of the simulation    [s]
time        = 0.0;                              % Starting point for the simulation     [s]
sampleRate  = 1/60;                             % Rate at which matrices are sampled    [s]
VFsampleRate=  1e-3;							% Sample rate of forces and velocity    [s]
dx          = 0.10;                             % Spatial discretization                [nm]
Rad_mv      = 50.0;                             % Radius of microvillus                 [nm]
x_mv        = -Rad_mv:dx:Rad_mv;                % Microvillus tip on the APC            [nm]
Rad_par     = 5.00;                             % Particle radius                       [nm]
Lx          = -Rad_mv:dx:(L_max+Rad_mv);        % Vector in x-direction for the box     [nm]
Ly          = -100:dx:100;                      % Vector in y-direction for the box     [nm]
z_bond      = 13.0;                             % TCR-pMHC complex natural length       [nm]
Height      = 13.0;                             % Height diff. between the T cell & APC [nm]
x_MV0       = 0.0;                              % Initial microvillus displacement      [nm]
Binding_rad = 2*z_bond;                         % Max distance a TCR-pMHC bond can form [nm]
MV_thresh   = 50;                               % Set a microvillus threshold force     [pN]
Box_area    = (L_max+2*Rad_mv)*(2*max(Ly));     % Total area of the domain              [nm^2]
rho_pMHC    = 400;                              % Density of pMHC molecules on APC      [1/um^2]
min_x       = min(Lx) + Rad_par;                % Min point in x-direction for particle [nm]
max_x       = max(Lx) - Rad_par;                % Max point in x-direction for particle [nm]
min_y       = min(Ly) + Rad_par;                % Min point in y-direction for particle [nm]
max_y       = max(Ly) - Rad_par;                % Max point in y-direction for particle [nm]

npMHC       = floor(Box_area/1e6*rho_pMHC);     % Total number of pMHC molecules
nE1         = floor( (1-jjj)*npMHC );           % Number of E1 pMHC molecules
nAg         = npMHC - nE1;                      % Number of agonist pMHC molecules
TCR_rest    = ceil(1e-3*Rad_mv^2*pi()*2.91);    % Number of TCRs in a resting T cell
nTCR        = TCR_rest;                         % Number of T-cell receptors

kon_Ag      = 2.4e5;                            % TCR-agonist pMHC complex binding rate [nm^2/s]
kon_E1      = 2.6e2;                            % TCR-E1 pMHC complex binding rate      [nm^2/s]
kon_std     = 5.00;                             % Binding rate standard deviation       [nm]
k_bond      = 1.00;                             % TCR-pMHC complex spring constant      [pN/nm]
koff_E1_0   = 2.514;                            % E1 slip bond unstressed off-rate      [1/s]
koff_E1_Strong = 0.302525;                      % Strong E1 slip bond unstressed off-rate [1/s]
koff_E1_f   = 5.533;                            % E1 slip bond characteristic force     [pN]
koff_OVA_c0 = 4.241;                            % OVA catch phase unstressed off-rate   [1/s]
koff_OVA_fc = 3.150;                            % OVA catch phase characteristic force  [pN]
koff_OVA_s0 = 0.374;                            % OVA slip phase unstressed off-rate    [1/s]
koff_OVA_fs = 9.280;                            % OVA slip phase characteristic force   [pN]
kc_VSV8     = 40.0;                             % VSV8 catch phase unstressed off-rate  [1/s]
fc_VSV8     = 2.286;                            % VSV8 catch phase characteristic force [pN]
ks_VSV8     = 0.05;                             % VSV8 slip phase unstressed off-rate   [1/s]
fs_VSV8     = 9.413;                            % VSV8 slip phase characteristic force  [pN]

delta_x     = 10.0;                             % Total displacement in diffusive move  [nm]
n_MV        = 4.0;                              % Velocity hill function exponent
K_MV        = 25.0;                             % Velocity hill function ref. force     [pN]
DC_E1       = 3e3;    % Also used 3e4           % E1 pMHC diffusion coefficient         [nm^2/s]
DC_Ag       = 3e3;    % Also used 3e4           % Agonist pMHC diffusion coefficient    [nm^2/s]
DC_TCR      = 1e4;    % Also used 3.4e4         % T cell receptor diffusion coefficient [nm^2/s]

khop_E1     = 4*DC_E1/(delta_x^2);              % Hopping rate of E1 pMHC molecule      [1/s]
khop_Ag     = 4*DC_Ag/(delta_x^2);              % Hopping rate of agonist pMHC molecule [1/s]
khop_TCR    = 4*DC_TCR/(delta_x^2);             % Hopping rate for a T cell receptor    [1/s]

dt          = -(delta_x^2*log(0.99))/(4*DC_TCR);% Time step for the simulation          [s]
dt          = round(dt,6);                      % Round the time step to e-06 decimal   [s]

Bond_distr  = zeros(1,4);                       % Matrix tracks bond lifetime distributions
Bond_total  = zeros(1,3);                       % Matrix tracks bond slip and catch bonds
MV_Force    = zeros(1,3);                       % Matrix tracks total force on microvillus
CC_SlipBond = zeros(1,7);                       % Initialize slip bond tracking matrix
CC_CatchBond= zeros(1,7);                       % Initialize catch bond tracking matrix

sampleCount = 0;                                % Counter used for tracking matrices
VFSampleCT  = 0;                                % Counter used to track velocity and forces
BondCounter = 1;                                % Counter used to record individual bonds

Initial_conditions_and_propensity;              % Initialize all species and calculate aTot
Velocity                = V0;                   % Record the initial microvillus velocity
SB_persist_forces       = zeros(2,2);           % Initialize slip bond force matrix
CB_persist_forces       = zeros(2,2);           % Initialize catch bond force matrix

filename = fullfile(outputFolder, num2str(iteration, '%03i') + outputBasename + '.mat');
display(filename)

if isfile(filename)
	load(filename)
	if time >= tf
		exit
	end
end

nextSave = saveInterval;

while( time < tf )                              % Run the simulation until t > tf
    
    % Consider binding / dissociation reactions within the sytem
    Slip_bond_formation;                        % Consider slip bond formation events
    Catch_bond_formation;                       % Consider catch bond formation events
    Slip_bond_dissociation;                     % Consider slip bond dissociation events
    Catch_bond_dissociation;                    % Consider catch bond dissociation events
	
	% Consider dragging of pMHCs along APC
    Drag_pMHCs;
    
    % Consider diffusive motion for all chemical species within the system
%   E1_pMHC_diffusion;                          % Consider diffusive motion for all E1 pMHC
%   Ag_pMHC_diffusion;                          % Consider diffusive motion for all agonist pMHC
%   TCR_diffusion;                              % Consider diffusive motion for all TCRs
    
    % Calculate forces bonds are experiencing if they've persisted >= 1 dt
    Persisting_forces_calculation;              % Calculate forces of bonds that have persisted
    
    while( time >= ( VFSampleCT*VFsampleRate ) )% If the time reaches a sample point, ...
        Velocity_NBonds_Force_calculation;      % Record velocity, number of bonds, & forces
    end
    
    while( time >= ( sampleCount*sampleRate ) ) % If the time reaches a sample point, ...
        sampleCount = sampleCount + 1;          % Update the counter for recording matrices
        Record_data;                            % Record chemical species matrices & forces
        display(time);                          % Print the current time to the screen
    end
    
    % Propagate the microvillus (and TCRs) forward, and update propensities
    Update_TCR_positions_and_velocity;          % Update the position of TCRs w/in all matrices
    Update_propensity;                          % Update propensity after diffusions & reactions    

    time = time + dt;                           % Update the time of the simulation
	if (time >= nextSave)
		save(filename);
		nextSave = time + saveInterval;
	end
end

for ii = 1:size(Bond_distr,1)                   % Iterate through the bond distribution matrix
    
    if( Bond_distr(ii,2) == 0 )                 % If a rupture was not recorded, ...
        Bond_distr(ii,2) = tf;                  % Input the final time of the simulation
    end
    
    % Calculate bond lifetime for each individual receptor-ligand complex.
    Bond_distr(ii,4) = Bond_distr(ii,2) - Bond_distr(ii,1);
end

save(filename);

end
