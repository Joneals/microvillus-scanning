% Upon reaching the 1st stopping point, t0, plot number of bonds and x_{MV}
% vs. relative time, tilde, for the 30% VSV8 case. Make sure to include 
% tilde = -5 seconds on the negative axis.

% Array that indicates each set of time points for all trajectories that 
% satisfy the  the microvillus velocity threshold conditions.
Tp_VSV8_0_3 = [206 431; 108 600; 96 267; 66 600; 7 210; 92 243; 91 242; 424 600;...
    237 529; 284 456; 30 600; 171 600; 409 590; 190 600; 127 446; 179 339; 28 316;];

% Create arrays that will be used for plotting variables against tilde
tilde_VSV8_0_3_T3  = -5:0.1:17.5; tilde_VSV8_0_3_T5  = -5:0.1:44.2;
tilde_VSV8_0_3_T8  = -5:0.1:12.1; tilde_VSV8_0_3_T10 = -5:0.1:48.4;
tilde_VSV8_0_3_T11 = -5:0.1:15.3; tilde_VSV8_0_3_T12 = -5:0.1:10.1;
tilde_VSV8_0_3_T13 = -5:0.1:10.1; tilde_VSV8_0_3_T14 = -5:0.1:12.6;
tilde_VSV8_0_3_T15 = -5:0.1:24.2; tilde_VSV8_0_3_T16 = -5:0.1:12.2;
tilde_VSV8_0_3_T17 = -5:0.1:52.0; tilde_VSV8_0_3_T18 = -5:0.1:37.9;
tilde_VSV8_0_3_T21 = -5:0.1:13.1; tilde_VSV8_0_3_T22 = -5:0.1:36.0;
tilde_VSV8_0_3_T23 = -5:0.1:26.9; tilde_VSV8_0_3_T24 = -5:0.1:11.0;
tilde_VSV8_0_3_T25 = -5:0.1:23.8; 

Catch_no_tilde_VSV8_0_3(:,11) = NCatch_VSV8_0_3(Tp_VSV8_0_3(11,1):Tp_VSV8_0_3(11,2),17);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T3),1)   = NCatch_VSV8_0_3(Tp_VSV8_0_3(1,1):Tp_VSV8_0_3(1,2),3);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T5),2)   = NCatch_VSV8_0_3(Tp_VSV8_0_3(2,1):Tp_VSV8_0_3(2,2),5);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T8),3)   = NCatch_VSV8_0_3(Tp_VSV8_0_3(3,1):Tp_VSV8_0_3(3,2),8);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T10),4)  = NCatch_VSV8_0_3(Tp_VSV8_0_3(4,1):Tp_VSV8_0_3(4,2),10);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T11),5)  = NCatch_VSV8_0_3(Tp_VSV8_0_3(5,1):Tp_VSV8_0_3(5,2),11);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T12),6)  = NCatch_VSV8_0_3(Tp_VSV8_0_3(6,1):Tp_VSV8_0_3(6,2),12);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T13),7)  = NCatch_VSV8_0_3(Tp_VSV8_0_3(7,1):Tp_VSV8_0_3(7,2),13);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T14),8)  = NCatch_VSV8_0_3(Tp_VSV8_0_3(8,1):Tp_VSV8_0_3(8,2),14);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T15),9)  = NCatch_VSV8_0_3(Tp_VSV8_0_3(9,1):Tp_VSV8_0_3(9,2),15);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T16),10) = NCatch_VSV8_0_3(Tp_VSV8_0_3(10,1):Tp_VSV8_0_3(10,2),16);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T18),12) = NCatch_VSV8_0_3(Tp_VSV8_0_3(12,1):Tp_VSV8_0_3(12,2),18);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T21),13) = NCatch_VSV8_0_3(Tp_VSV8_0_3(13,1):Tp_VSV8_0_3(13,2),21);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T22),14) = NCatch_VSV8_0_3(Tp_VSV8_0_3(14,1):Tp_VSV8_0_3(14,2),22);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T23),15) = NCatch_VSV8_0_3(Tp_VSV8_0_3(15,1):Tp_VSV8_0_3(15,2),23);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T24),16) = NCatch_VSV8_0_3(Tp_VSV8_0_3(16,1):Tp_VSV8_0_3(16,2),24);
Catch_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T25),17) = NCatch_VSV8_0_3(Tp_VSV8_0_3(17,1):Tp_VSV8_0_3(17,2),25);

Slip_no_tilde_VSV8_0_3(:,11) = NSlip_VSV8_0_3(Tp_VSV8_0_3(11,1):Tp_VSV8_0_3(11,2),17);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T3),1)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(1,1):Tp_VSV8_0_3(1,2),3);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T5),2)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(2,1):Tp_VSV8_0_3(2,2),5);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T8),3)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(3,1):Tp_VSV8_0_3(3,2),8);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T10),4)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(4,1):Tp_VSV8_0_3(4,2),10);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T11),5)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(5,1):Tp_VSV8_0_3(5,2),11);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T12),6)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(6,1):Tp_VSV8_0_3(6,2),12);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T13),7)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(7,1):Tp_VSV8_0_3(7,2),13);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T14),8)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(8,1):Tp_VSV8_0_3(8,2),14);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T15),9)  = NSlip_VSV8_0_3(Tp_VSV8_0_3(9,1):Tp_VSV8_0_3(9,2),15);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T16),10) = NSlip_VSV8_0_3(Tp_VSV8_0_3(10,1):Tp_VSV8_0_3(10,2),16);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T18),12) = NSlip_VSV8_0_3(Tp_VSV8_0_3(12,1):Tp_VSV8_0_3(12,2),18);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T21),13) = NSlip_VSV8_0_3(Tp_VSV8_0_3(13,1):Tp_VSV8_0_3(13,2),21);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T22),14) = NSlip_VSV8_0_3(Tp_VSV8_0_3(14,1):Tp_VSV8_0_3(14,2),22);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T23),15) = NSlip_VSV8_0_3(Tp_VSV8_0_3(15,1):Tp_VSV8_0_3(15,2),23);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T24),16) = NSlip_VSV8_0_3(Tp_VSV8_0_3(16,1):Tp_VSV8_0_3(16,2),24);
Slip_no_tilde_VSV8_0_3(1:length(tilde_VSV8_0_3_T25),17) = NSlip_VSV8_0_3(Tp_VSV8_0_3(17,1):Tp_VSV8_0_3(17,2),25);

for ii = 1:length(Catch_no_tilde_VSV8_0_3)
    Catch_no_tilde_VSV8_0_3(ii,18) = sum( Catch_no_tilde_VSV8_0_3(ii,1:17) )/sum( Catch_no_tilde_VSV8_0_3(ii,1:17) ~= 0 );
    Slip_no_tilde_VSV8_0_3(ii,18) = sum( Slip_no_tilde_VSV8_0_3(ii,1:17) )/sum( Slip_no_tilde_VSV8_0_3(ii,1:17) ~= 0 );
end

figure(1); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$\tilde{t}$ $(\mathrm{s})$','FontSize',90,'Interpreter','LaTeX');
ylabel('$x_{\mathrm{MV}}$ ($\mu \mathrm{m}$)','FontSize',90,'Interpreter','LaTeX');
plot(tilde_VSV8_0_3_T3,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(1,1):Tp_VSV8_0_3(1,2),3)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T5,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(2,1):Tp_VSV8_0_3(2,2),5)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T8,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(3,1):Tp_VSV8_0_3(3,2),8)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T10,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(4,1):Tp_VSV8_0_3(4,2),10)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T11,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(5,1):Tp_VSV8_0_3(5,2),11)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T12,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(6,1):Tp_VSV8_0_3(6,2),12)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T13,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(7,1):Tp_VSV8_0_3(7,2),13)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T14,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(8,1):Tp_VSV8_0_3(8,2),14)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T15,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(9,1):Tp_VSV8_0_3(9,2),15)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T16,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(10,1):Tp_VSV8_0_3(10,2),16)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T17,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(11,1):Tp_VSV8_0_3(11,2),17)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T18,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(12,1):Tp_VSV8_0_3(12,2),18)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T21,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(13,1):Tp_VSV8_0_3(13,2),21)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T22,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(14,1):Tp_VSV8_0_3(14,2),22)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T23,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(15,1):Tp_VSV8_0_3(15,2),23)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T24,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(16,1):Tp_VSV8_0_3(16,2),24)/1000,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T25,MV_center_VSV8_0_3_all(Tp_VSV8_0_3(17,1):Tp_VSV8_0_3(17,2),25)/1000,'LineWidth',6.5);
plot([0 0],[0 1.5],'k--'); axis([-5 55 0 1.5]); hold off;

figure(2); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$\tilde{t}$ $(\mathrm{s})$','FontSize',90,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{bonds}}$','FontSize',90,'Interpreter','LaTeX');
title('$30\%$ $\mathrm{VSV8}$','FontSize',90,'Interpreter','LaTeX');
plot(tilde_VSV8_0_3_T17,Slip_no_tilde_VSV8_0_3(:,19),'g','LineWidth',8);
plot(tilde_VSV8_0_3_T17,Catch_no_tilde_VSV8_0_3(:,19),'b','LineWidth',8);
plot([0 0],[0 10],'k--','LineWidth',4); axis([-5 55 0 10]); 
h = legend('$N_{\mathrm{slip}}$','$N_{\mathrm{catch}}$');
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','SouthEast'); hold off;

figure(3); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$\tilde{t}$ $(\mathrm{s})$','FontSize',90,'Interpreter','LaTeX');
ylabel('$N_{\mathrm{catch}}$','FontSize',90,'Interpreter','LaTeX');
title('$30\%$ $\mathrm{VSV8}$','FontSize',90,'Interpreter','LaTeX');
yplot2 = Catch_no_tilde_VSV8_0_3(:,1:17); yplot2(yplot2==0)=nan;
plot(tilde_VSV8_0_3_T17,yplot2,'LineWidth',6.5);
plot(tilde_VSV8_0_3_T17,Catch_no_tilde_VSV8_0_3(:,18),'k','LineWidth',13);
plot([0 0],[0 10],'k--','LineWidth',4); axis([-5 55 0 10]); hold off;