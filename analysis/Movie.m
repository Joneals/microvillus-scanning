movie_resolution = [1280 640];

window = figure('Name', 'Movie', 'Position', [0 0 movie_resolution(1) movie_resolution(2)]);
hold on
set(gca,'NextPlot','ReplaceChildren');
movegui(window,'center');



sample_time = 0:sampleRate:tf;
pause(1)


for i = 1:length(sample_time)-1
    
    % Plot the microvillus boundary circle
    plot(MV_center(i) + Rad_mv*cos(theta_vec), Rad_mv*sin(theta_vec), 'b')
    hold on
    % Plot TCR circles
    for iTCR = 1:length(C_TCR)
        % C_TCR(TCR_index, 1:x/2:y/3:id, sample)
        pos = [C_TCR(iTCR, 1, i) C_TCR(iTCR, 2, i) 10 10];
        % Use rectangle to plot a circle, why not
        rectangle('Position', pos, 'Curvature', [1 1])
    end
    
    % Plot E1 pMHCs
    plot(C_E1(:, 1, i), C_E1(:, 2, i), 'go')
    % Plot AG pMHCs
    plot(C_Ag(:, 1, i), C_Ag(:, 2, i), 'rx')
    
    % Plot bond connections

 
    % Update axis limits so MV is center with +/- 2*radius
    axis([MV_center(i) - 4*Rad_mv, MV_center(i) + 4*Rad_mv, -2*Rad_mv 2*Rad_mv])
    pause(2)
    hold off
end
