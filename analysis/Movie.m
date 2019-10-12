% Play animated figure
% All variables must be loaded and correctly named prior to running script
% Required Variables:
% MV_center - Vector of MV positions
% Rad_mv    - Radius of MV
% C_TCR     - Vector of TCR positions
% C_E1      - Vector of E1 positions
% C_Ag      - Vector of Ag positions
% C_Slip    - Vector of active slip bonds
% C_Catch   - Vector of active catch bonds

% Set the dimensions of the figure
movie_resolution = [1280 640];
movie_file = 'movie'
sampleRate = .1; % change simulation to save this

close all
window = figure('Name', 'Movie', 'Position', [0 0 movie_resolution(1) movie_resolution(2)]);
hold on
set(gca,'NextPlot','ReplaceChildren');
movegui(window,'center');

sample_time = 0:sampleRate:tf-sampleRate;
v = VideoWriter(movie_file);
open(v)
pause(1)

theta_vec = linspace(0, 2*pi, 180);
for i = 1:length(sample_time)
    
    
    % Plot the microvillus boundary circle
    plot(MV_center(i) + Rad_mv*cos(theta_vec), Rad_mv*sin(theta_vec), 'k', 'LineWidth', 1);
    hold on % Turn on hold after first plot so old elements are removed
    
    title("Time: " + num2str(sample_time(i)));
    
    % Plot bond connections
    for iSlip = 1:size(C_Slip,1)
       plot([C_Slip(iSlip,1,i) C_Slip(iSlip, 3, i)],...
             [C_Slip(iSlip, 2, i) C_Slip(iSlip, 4, i)],...
         'r-', 'LineWidth', 2);
    end
    for iCatch = 1:size(C_Catch,1)
       plot([C_Catch(iCatch,1,i) C_Catch(iCatch, 3, i)],...
             [C_Catch(iCatch, 2, i) C_Catch(iCatch, 4, i)],...
         'r-', 'LineWidth', 2);
    end
    
    % Plot TCR circles
    plot(C_TCR(:,1,i), C_TCR(:,2,i), 'bo', 'MarkerSize', 12, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b')
    
    % Plot E1 pMHCs
    plot(C_E1(:, 1, i), C_E1(:, 2, i), 'go', 'MarkerSize', 12, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g')
    
    % Plot AG pMHCs
    plot(C_Ag(:, 1, i), C_Ag(:, 2, i), 'ro', 'MarkerSize', 12, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r')
    
    
 
    
    % Update axis limits
    axis([MV_center(i) - 4*Rad_mv, MV_center(i) + 4*Rad_mv, -2*Rad_mv 2*Rad_mv])
    drawnow
    writeVideo(v, getframe(window)); % Comment this out to disable saving
    hold off
end
close(v);