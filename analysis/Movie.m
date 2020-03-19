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
movie_resolution = [1280 720];
movie_mode = 0; % 0 - Follow MV; 1 - Zoomed out view
sim_aspect = L_max/2 / (4.*Rad_mv);

if movie_mode == 1
    movie_resolution = [1920 floor(1920./sim_aspect)];
    marker_size = 2; 
else
    marker_size = 12;
end


movie_file = '0Ag_1drag' % Change export filename
%sampleRate = .1; % In case sim doesn't save it

close all
window = figure('Name', 'Movie', 'Position', [0 0 movie_resolution(1) movie_resolution(2)]);
hold on
set(gca,'NextPlot','ReplaceChildren');
movegui(window,'center');

sample_time = 0:sampleRate:tf-sampleRate;
v = VideoWriter(movie_file);
v.FrameRate = 50; % 2x realtime
open(v)

%if movie_mode == 1
axes('Position', [0 0 1 1]); % Set chart to take entire window
%end
theta_vec = linspace(0, 2*pi, 180);
for i = 1:length(sample_time)
    
    % Plot the microvillus boundary circle
    plot(MV_center(i) + Rad_mv*cos(theta_vec), Rad_mv*sin(theta_vec), 'k', 'LineWidth', 1);
    hold on % Turn on hold after first plot so old elements are removed
    
    title(["Time: "  num2str(sample_time(i), '%.1f')]);  
    
    % Plot TCR circles
    plot(C_TCR(:,1,i), C_TCR(:,2,i), 'bo', 'MarkerSize', marker_size, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b')
    
    % Plot E1 pMHCs
    plot(C_E1(:, 1, i), C_E1(:, 2, i), 'go', 'MarkerSize', marker_size, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g')
    
    % Plot AG pMHCs
    if length(C_Ag) > 0
    plot(C_Ag(:, 1, i), C_Ag(:, 2, i), 'ro', 'MarkerSize', marker_size, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r')
    end
    
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
    
    % Update axis limits
    if movie_mode == 0 % Follow
    axis([-2*Rad_mv*movie_resolution(1)./movie_resolution(2) + MV_center(i), 2*Rad_mv*movie_resolution(1)./movie_resolution(2) + MV_center(i), -2*Rad_mv 2*Rad_mv])
    else % Zoomed out
    axis([0, L_max/2, -2*Rad_mv 2*Rad_mv])
    text(MV_center(i) + 1.5*Rad_mv, 0, "Time: " + num2str(sample_time(i), '%.1f'));
    end
    
    drawnow
    %pause
    writeVideo(v, getframe(window)); % Comment this out to disable saving
    hold off
end
close(v);