% Play animated figure
% All variables must be loaded and correctly named prior to running script
% Required Variables:
% MV_center - Vector of MV positions
% Rad_mv    - Radius of MV
% C_TCR     - Vector of TCR positions
% C_E1      - Vector of E1 positions
% C_Ag      - Vector of Ag positions
% C_Slip    - Vector of active slip bonds

movie_resolution = [1280 640];
sampleRate = .1; % Eventually change simulation to export this

window = figure('Name', 'Movie', 'Position', [0 0 movie_resolution(1) movie_resolution(2)]);
hold on
set(gca,'NextPlot','ReplaceChildren');
movegui(window,'center');

sample_time = 0:sampleRate:tf;
pause(1)

theta_vec = linspace(0, 2*pi, 180);
for i = 1:length(sample_time)-1
    
    
    % Plot the microvillus boundary circle
    plot(MV_center(i) + Rad_mv*cos(theta_vec), Rad_mv*sin(theta_vec), 'b')
    
    hold on % Turn on hold after first plot so old elements are removed
    
    title("Time: " + num2str(sample_time(i)));
    
    % Plot TCR circles
    plot(C_TCR(:,1,i), C_TCR(:,2,i), 'go', 'MarkerSize', 12, 'MarkerFaceColor', 'g')
    
    % Plot E1 pMHCs
    plot(C_E1(:, 1, i), C_E1(:, 2, i), 'gx', 'MarkerSize', 12, 'MarkerEdgeColor', 'k')
    
    % Plot AG pMHCs
    plot(C_Ag(:, 1, i), C_Ag(:, 2, i), 'rx')
    
    % Plot bond connections
    for iSlip = 1:size(C_Slip,1)
       plot([C_Slip(iSlip,1,i) C_Slip(iSlip, 3, i)],...
             [C_Slip(iSlip, 2, i) C_Slip(iSlip, 4, i)],...
         'r-', 'LineWidth', 2);
    end
 
    
    % Update axis limits
    axis([MV_center(i) - 4*Rad_mv, MV_center(i) + 4*Rad_mv, -2*Rad_mv 2*Rad_mv])
    drawnow
    hold off
end
