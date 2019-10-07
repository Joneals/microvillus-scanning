% Use trajectory 25 for VSV8 0_1 case and trajectory 22 for VSV8 0_3 case

Traj_no = 22;
time_vec = linspace(0,60,600);
t = 0:.01:2*pi;
figure(1); hold on; set(gcf,'Color','w'); 
set(gca,'LineWidth',2.5,'FontSize',75,'NextPlot','ReplaceChildren');
F( size(time_vec,2) ) = struct('cdata',[],'colormap',[]);
pause
if( 1 == 1 )                         % Probably remove
    C_catch     = C_Catch;     % Retrieve catch bond data
    C_E1        = C_E1;        % Retrieve slip pMHC data
    C_slip      = C_Slip;      % Retrieve slip bond data
    C_TCR       = C_TCR;       % Retrieve T cell receptor data
    C_VSV8      = C_Ag           % Retrieve VSV8 pMHC data
    MV_center   = MV_center_VSV8_0_10_T;   % Retrieve microvillus center data
    for n = 1:size(time_vec,2)             % Iterate through all recorded time points
        
        hold on; box on;
        time_str    = time_vec(1,n);        % Retrieve time point
        x_MV0       = MV_center(1,n);       % Retrieve microvillus center position
        
        % Generate reference frame, label axes and stream time point
        axis([(-2*Rad_mv+x_MV0) (2*Rad_mv+x_MV0) -2*Rad_mv 2*Rad_mv]);
        xlabel('x (nm)','FontSize',90,'Interpreter','LaTeX');
        ylabel('y (nm)','FontSize',90,'Interpreter','LaTeX');
        title(['$t$ $=$ ' num2str(time_str,'%.2f') ' $s$'],'FontSize',90,...
            'Interpreter','LaTeX');
        
        % Plot the circle indicating the outside of the microvillus tip
        m1 = plot(x_MV0 + Rad_mv*cos(t),Rad_mv*sin(t),'k','LineWidth',5);
        
        % Plot the T cell receptor distribution within the axes of interest
        m2 = plot(C_TCR(:,1,n),C_TCR(:,2,n),'ko','MarkerSize',36,...
            'MarkerFaceColor','c');
        
        % Plot the E1 pMHC molecule distribution within the axes of interest
        m3 = plot(C_E1(:,1,n),C_E1(:,2,n),'gx','MarkerSize',36,...
            'MarkerFaceColor','g','LineWidth',7);
        
        % Plot the VSV8 pMHC molecule distribution within the axes of interest
        m4 = plot(C_VSV8(:,1,n),C_VSV8(:,2,n),'bx','MarkerSize',36,...
            'MarkerFaceColor','b','LineWidth',7);
        
        % Plot the slip bonds present within the axes of interest
        m5  = plot([-1e3 -1e3],[0 0],'g'); m6  = plot([-1e3 -1e3],[0 0],'g');
        m7  = plot([-1e3 -1e3],[0 0],'g'); m8  = plot([-1e3 -1e3],[0 0],'g');
        m9  = plot([-1e3 -1e3],[0 0],'g'); m10 = plot([-1e3 -1e3],[0 0],'g');
        m11 = plot([-1e3 -1e3],[0 0],'g'); m12 = plot([-1e3 -1e3],[0 0],'g');
        
        for ii = 1:size(C_slip,1)
            if( C_slip(1,5,n) ~= 0 )
                m5  = plot( [C_slip(1,1,n) C_slip(1,3,n)], ...
                    [C_slip(1,2,n) C_slip(1,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(2,5,n) ~= 0 )
                m6  = plot( [C_slip(2,1,n) C_slip(2,3,n)], ...
                    [C_slip(2,2,n) C_slip(2,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(3,5,n) ~= 0 )
                m7  = plot( [C_slip(3,1,n) C_slip(3,3,n)], ...
                    [C_slip(3,2,n) C_slip(3,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(4,5,n) ~= 0 )
                m8  = plot( [C_slip(4,1,n) C_slip(4,3,n)], ...
                    [C_slip(4,2,n) C_slip(4,4,n)],'g','LineWidth',7 );
            end
        end
        
        % Plot the catch bonds present within the axes of interest
        m13 = plot([-1e3 -1e3],[0 0],'g'); m14 = plot([-1e3 -1e3],[0 0],'g');
        m15 = plot([-1e3 -1e3],[0 0],'g');
        
        for ii = 1:size(C_catch,1)
            if( C_catch(1,5,n) ~= 0 )
                m13  = plot( [C_catch(1,1,n) C_catch(1,3,n)], ...
                    [C_catch(1,2,n) C_catch(1,4,n)],'b','LineWidth',7 );
            end
        end
        
        hold off;
        F(n) = getframe(gcf);           % Retrieve frame from the figure
        pause(0.001);                    % Pause frame for a desired number of seconds
        if( n < size(time_vec,2) )
            cla;
        end
    end
else                                        % Generate 30% VSV8 case movie
    C_catch     = C_catch_VSV8_0_3_T22;     % Retrieve catch bond data
    C_E1        = C_E1_VSV8_0_3_T22;        % Retrieve slip pMHC data
    C_slip      = C_Slip_VSV8_0_3_T22;      % Retrieve slip bond data
    C_TCR       = C_TCR_VSV8_0_3_T22;       % Retrieve T cell receptor data
    C_VSV8      = C_VSV8_0_3_T22;           % Retrieve VSV8 pMHC data
    MV_center   = MV_center_VSV8_0_3_T22;   % Retrieve microvillus center data
    
    for n = 1:size(time_vec,2)              % Iterate through all recorded time points
        
        hold on; box on;
        time_str    = time_vec(1,n);        % Retrieve time point
        x_MV0       = MV_center(1,n);       % Retrieve microvillus center position
        
        % Generate reference frame, label axes and stream time point
        axis([(-2*Rad_mv+x_MV0) (2*Rad_mv+x_MV0) -2*Rad_mv 2*Rad_mv]);
        xlabel('x (nm)','FontSize',90,'Interpreter','LaTeX');
        ylabel('y (nm)','FontSize',90,'Interpreter','LaTeX');
        title(['$t$ $=$ ' num2str(time_str,'%.2f') ' $s$'],'FontSize',90,...
            'Interpreter','LaTeX');
        
        % Plot the circle indicating the outside of the microvillus tip
        m1 = plot(x_MV0 + Rad_mv*cos(t),Rad_mv*sin(t),'k','LineWidth',5);
        
        % Plot the T cell receptor distribution within the axes of interest
        m2 = plot(C_TCR(:,1,n),C_TCR(:,2,n),'ko','MarkerSize',36,...
            'MarkerFaceColor','c');
        
        % Plot the E1 pMHC molecule distribution within the axes of interest
        m3 = plot(C_E1(:,1,n),C_E1(:,2,n),'gx','MarkerSize',36,...
            'MarkerFaceColor','g','LineWidth',7);
        
        % Plot the VSV8 pMHC molecule distribution within the axes of interest
        m4 = plot(C_VSV8(:,1,n),C_VSV8(:,2,n),'bx','MarkerSize',36,...
            'MarkerFaceColor','b','LineWidth',7);
        
        % Plot the slip bonds present within the axes of interest
        m5  = plot([-1e3 -1e3],[0 0],'g'); m6  = plot([-1e3 -1e3],[0 0],'g');
        m7  = plot([-1e3 -1e3],[0 0],'g'); m8  = plot([-1e3 -1e3],[0 0],'g');
        m9  = plot([-1e3 -1e3],[0 0],'g'); m10 = plot([-1e3 -1e3],[0 0],'g');
        m11 = plot([-1e3 -1e3],[0 0],'g'); m12 = plot([-1e3 -1e3],[0 0],'g');
        m13 = plot([-1e3 -1e3],[0 0],'g'); m14 = plot([-1e3 -1e3],[0 0],'g');
        
        for ii = 1:size(C_slip,1)
            if( C_slip(1,5,n) ~= 0 )
                m5  = plot( [C_slip(1,1,n) C_slip(1,3,n)], ...
                    [C_slip(1,2,n) C_slip(1,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(2,5,n) ~= 0 )
                m6  = plot( [C_slip(2,1,n) C_slip(2,3,n)], ...
                    [C_slip(2,2,n) C_slip(2,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(3,5,n) ~= 0 )
                m7  = plot( [C_slip(3,1,n) C_slip(3,3,n)], ...
                    [C_slip(3,2,n) C_slip(3,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(4,5,n) ~= 0 )
                m8  = plot( [C_slip(4,1,n) C_slip(4,3,n)], ...
                    [C_slip(4,2,n) C_slip(4,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(5,5,n) ~= 0 )
                m9  = plot( [C_slip(5,1,n) C_slip(5,3,n)], ...
                    [C_slip(5,2,n) C_slip(5,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(6,5,n) ~= 0 )
                m10 = plot( [C_slip(1,1,n) C_slip(1,3,n)], ...
                    [C_slip(1,2,n) C_slip(1,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(7,5,n) ~= 0 )
                m11 = plot( [C_slip(2,1,n) C_slip(2,3,n)], ...
                    [C_slip(2,2,n) C_slip(2,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(8,5,n) ~= 0 )
                m12 = plot( [C_slip(3,1,n) C_slip(3,3,n)], ...
                    [C_slip(3,2,n) C_slip(3,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(9,5,n) ~= 0 )
                m13 = plot( [C_slip(4,1,n) C_slip(4,3,n)], ...
                    [C_slip(4,2,n) C_slip(4,4,n)],'g','LineWidth',7 );
            end
            if( C_slip(10,5,n) ~= 0 )
                m14 = plot( [C_slip(5,1,n) C_slip(5,3,n)], ...
                    [C_slip(5,2,n) C_slip(5,4,n)],'g','LineWidth',7 );
            end
        end
        
        % Plot the catch bonds present within the axes of interest
        m15 = plot([-1e3 -1e3],[0 0],'g'); m16 = plot([-1e3 -1e3],[0 0],'g');
        m17 = plot([-1e3 -1e3],[0 0],'g'); m18 = plot([-1e3 -1e3],[0 0],'g');
        m19 = plot([-1e3 -1e3],[0 0],'g'); m20 = plot([-1e3 -1e3],[0 0],'g');
        
        for ii = 1:size(C_catch,1)
            if( C_catch(1,5,n) ~= 0 )
                m15  = plot( [C_catch(1,1,n) C_catch(1,3,n)], ...
                    [C_catch(1,2,n) C_catch(1,4,n)],'b','LineWidth',7 );
            end
            if( C_catch(2,5,n) ~= 0 )
                m16  = plot( [C_catch(2,1,n) C_catch(2,3,n)], ...
                    [C_catch(2,2,n) C_catch(2,4,n)],'b','LineWidth',7 );
            end
            if( C_catch(3,5,n) ~= 0 )
                m17  = plot( [C_catch(3,1,n) C_catch(3,3,n)], ...
                    [C_catch(3,2,n) C_catch(3,4,n)],'b','LineWidth',7 );
            end
            if( C_catch(4,5,n) ~= 0 )
                m18  = plot( [C_catch(4,1,n) C_catch(4,3,n)], ...
                    [C_catch(4,2,n) C_catch(4,4,n)],'b','LineWidth',7 );
            end
            if( C_catch(5,5,n) ~= 0 )
                m19  = plot( [C_catch(5,1,n) C_catch(5,3,n)], ...
                    [C_catch(5,2,n) C_catch(5,4,n)],'b','LineWidth',7 );
            end
            if( C_catch(6,5,n) ~= 0 )
                m20  = plot( [C_catch(6,1,n) C_catch(6,3,n)], ...
                    [C_catch(6,2,n) C_catch(6,4,n)],'b','LineWidth',7 );
            end
        end
        
        hold off;
        F(n) = getframe(gcf);           % Retrieve frame from the figure
        pause(0.001);                    % Pause frame for a desired number of seconds
        if( n < size(time_vec,2) )
            cla;
        end
    end
end

% Create a video file, control the frame rate, and write data to the movie
if( Traj_no == 25 ) 
    obj = VideoWriter('VSV8_0_1_T25_movie.avi','Uncompressed AVI');
    obj.FrameRate = 24; open(obj); writeVideo(obj,F); close(obj); clear F;
else
    obj = VideoWriter('VSV8_0_3_T22_movie.avi','Uncompressed AVI');
    obj.FrameRate = 24; open(obj); writeVideo(obj,F); close(obj); clear F;
end