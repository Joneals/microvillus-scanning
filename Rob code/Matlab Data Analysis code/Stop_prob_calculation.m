% t5 = 5.0; 
t10 = 10; 
% t15 = 15; 
% Vthr_1 = 1; 
Vthr_0_25 = 0.25;

for jj = 1:25
    
%     for ii = 1:(600 - t5/0.1)
%         kk = (t5/0.1) + ii;
%         VVSV8_0_3_tw5(ii,jj) = ( ( MV_center_VSV8_0_3_all(kk,jj) - ...
%             MV_center_VSV8_0_3_all(ii,jj) )/1000 )/( t5/60 );
%     end
%     
%     if( any( VVSV8_0_3_tw5(:,jj) < Vthr_0_25 ) )
%         VVSV8_0_3_Vthr_0_25(1,jj) = 1;
%     else
%         VVSV8_0_3_Vthr_0_25(1,jj) = 0;
%     end
%     
%     if( any( VVSV8_0_3_tw5(:,jj) < Vthr_1 ) )
%         VVSV8_0_3_Vthr_1(1,jj) = 1;
%     else
%         VVSV8_0_3_Vthr_1(1,jj) = 0;
%     end
    
    for ii = 1:(600 - t10/0.1)
        kk = (t10/0.1) + ii;
        VVSV8_0_1_tw10(ii,jj) = ( ( MV_center_VSV8_0_1_all(kk,jj) - ...
            MV_center_VSV8_0_1_all(ii,jj) )/1000 )/( t10/60 );
    end
    
    if( any( VVSV8_0_1_tw10(:,jj) < Vthr_0_25 ) )
        VVSV8_0_1_Vthr_0_25(2,jj) = 1;
    else
        VVSV8_0_1_Vthr_0_25(2,jj) = 0;
    end
    
%     if( any( VVSV8_1x_tw10(:,jj) < Vthr_1 ) )
%         VVSV8_0_3_Vthr_1(2,jj) = 1;
%     else
%         VVSV8_0_3_Vthr_1(2,jj) = 0;
%     end
    
%     for ii = 1:(600 - t15/0.1)
%         kk = (t15/0.1) + ii;
%         VVSV8_0_3_tw15(ii,jj) = ( ( MV_center_VSV8_0_3_all(kk,jj) - ...
%             MV_center_VSV8_0_3_all(ii,jj) )/1000 )/( t15/60 );
%     end
%     
%     if( any( VVSV8_0_3_tw15(:,jj) < Vthr_0_25 ) )
%         VVSV8_0_3_Vthr_0_25(3,jj) = 1;
%     else
%         VVSV8_0_3_Vthr_0_25(3,jj) = 0;
%     end
%     
%     if( any( VVSV8_0_3_tw15(:,jj) < Vthr_1 ) )
%         VVSV8_0_3_Vthr_1(3,jj) = 1;
%     else
%         VVSV8_0_3_Vthr_1(3,jj) = 0;
%     end
end

% for ii = 1:3
%     PVSV8_1x_stop_Vthr_0_25(ii,1) = mean( VVSV8_1x_Vthr_0_25(ii,:) );
% %     PVSV8_0_3_stop_Vthr_1(ii,1)   = mean( VVSV8_0_3_Vthr_1(ii,:) );
% end

clear ii jj kk t5 t10 t15 Vthr_0_5 Vthr_1 VVSV8_0_3_tw5 ...
    VVSV8_0_3_tw15 VVSV8_0_3_Vthr_0_5 VVSV8_0_3_Vthr_1 PVSV8_0_3_stop_Vthr_1 ...
    PVSV8_0_3_stop_Vthr_0_25 PVSV8_0_3_stop_Vthr_1 Vthr_0_25;