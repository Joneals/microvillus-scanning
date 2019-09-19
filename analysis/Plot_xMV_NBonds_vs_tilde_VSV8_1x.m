% Array that indicates each set of time points for all trajectories that 
% satisfy the  the microvillus velocity threshold conditions.
TP_VSV8_1x = [1 600; 1 132; 1 600; 1 600; 1 600; 209 600; 11 600; 53 600; 81 232; ...
    31 600; 110 600; 1 124; 15 600; 1 600; 11 600; 31 600; 8 173; 20 172; 1 600; ...
    1 128; 1 124; 18 600; 1 600; 76 600; 107 600;];

% Create arrays that will be used for plotting variables against tilde
t_VSV8_1x_T1 = -2.7:0.1:57.2;  t_VSV8_1x_T2 = -3.1:0.1:10; 
t_VSV8_1x_T3 = -2.5:0.1:57.4;  t_VSV8_1x_T4 = -5:0.1:54.9;
t_VSV8_1x_T5 = -0.5:0.1:59.4;  t_VSV8_1x_T6 = -5:0.1:34.1;
t_VSV8_1x_T7 = -5:0.1:53.9;    t_VSV8_1x_T8 = -5:0.1:49.7;
t_VSV8_1x_T9 = -5:0.1:10.1;    t_VSV8_1x_T10 = -5:0.1:51.9;
t_VSV8_1x_T11 = -5:0.1:44.0;   t_VSV8_1x_T12 = -1.4:0.1:10.9;
t_VSV8_1x_T13 = -5:0.1:53.5;   t_VSV8_1x_T14 = -2.8:0.1:57.1;
t_VSV8_1x_T15 = -5:0.1:53.9;   t_VSV8_1x_T16 = -5:0.1:51.9;
t_VSV8_1x_T17 = -5:0.1:11.5;   t_VSV8_1x_T18 = -5:0.1:10.2;
t_VSV8_1x_T19 = -3.4:0.1:56.5; t_VSV8_1x_T20 = -2.2:0.1:10.5;
t_VSV8_1x_T21 = -1.8:0.1:10.5; t_VSV8_1x_T22 = -5:0.1:53.2;
t_VSV8_1x_T23 = -2:0.1:57.9;   t_VSV8_1x_T24 = -5:0.1:47.4;
t_VSV8_1x_T25 = -5:0.1:44.3;

NCatch_tilde_VSV8_1x(:,1)  = NCatch_VSV8_1x(TP_VSV8_1x(1,1):TP_VSV8_1x(1,2),1);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T2),2)  = NCatch_VSV8_1x(TP_VSV8_1x(2,1):TP_VSV8_1x(2,2),2);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T3),3)  = NCatch_VSV8_1x(TP_VSV8_1x(3,1):TP_VSV8_1x(3,2),3);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T4),4)  = NCatch_VSV8_1x(TP_VSV8_1x(4,1):TP_VSV8_1x(4,2),4);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T5),5)  = NCatch_VSV8_1x(TP_VSV8_1x(5,1):TP_VSV8_1x(5,2),5);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T6),6)  = NCatch_VSV8_1x(TP_VSV8_1x(6,1):TP_VSV8_1x(6,2),6);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T7),7)  = NCatch_VSV8_1x(TP_VSV8_1x(7,1):TP_VSV8_1x(7,2),7);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T8),8)  = NCatch_VSV8_1x(TP_VSV8_1x(8,1):TP_VSV8_1x(8,2),8);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T9),9)  = NCatch_VSV8_1x(TP_VSV8_1x(9,1):TP_VSV8_1x(9,2),9);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T10),10) = NCatch_VSV8_1x(TP_VSV8_1x(10,1):TP_VSV8_1x(10,2),10);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T11),11) = NCatch_VSV8_1x(TP_VSV8_1x(11,1):TP_VSV8_1x(11,2),11);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T12),12) = NCatch_VSV8_1x(TP_VSV8_1x(12,1):TP_VSV8_1x(12,2),12);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T13),13) = NCatch_VSV8_1x(TP_VSV8_1x(13,1):TP_VSV8_1x(13,2),13);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T14),14) = NCatch_VSV8_1x(TP_VSV8_1x(14,1):TP_VSV8_1x(14,2),14);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T15),15) = NCatch_VSV8_1x(TP_VSV8_1x(15,1):TP_VSV8_1x(15,2),15);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T16),16) = NCatch_VSV8_1x(TP_VSV8_1x(16,1):TP_VSV8_1x(16,2),16);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T17),17) = NCatch_VSV8_1x(TP_VSV8_1x(17,1):TP_VSV8_1x(17,2),17);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T18),18) = NCatch_VSV8_1x(TP_VSV8_1x(18,1):TP_VSV8_1x(18,2),18);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T19),19) = NCatch_VSV8_1x(TP_VSV8_1x(19,1):TP_VSV8_1x(19,2),19);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T20),20) = NCatch_VSV8_1x(TP_VSV8_1x(20,1):TP_VSV8_1x(20,2),20);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T21),21) = NCatch_VSV8_1x(TP_VSV8_1x(21,1):TP_VSV8_1x(21,2),21);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T22),22) = NCatch_VSV8_1x(TP_VSV8_1x(22,1):TP_VSV8_1x(22,2),22);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T23),23) = NCatch_VSV8_1x(TP_VSV8_1x(23,1):TP_VSV8_1x(23,2),23);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T24),24) = NCatch_VSV8_1x(TP_VSV8_1x(24,1):TP_VSV8_1x(24,2),24);
NCatch_tilde_VSV8_1x(1:length(t_VSV8_1x_T25),25) = NCatch_VSV8_1x(TP_VSV8_1x(25,1):TP_VSV8_1x(25,2),25);

figure(2); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$\tilde{t}$ $(\mathrm{s})$','FontSize',90,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{bonds}}$','FontSize',90,'Interpreter','LaTeX');
title('$30\%$ $\mathrm{VSV8}$','FontSize',90,'Interpreter','LaTeX');
plot(tilde_VSV8_0_3_T17,Catch_no_tilde_VSV8_0_3(:,19),'b','LineWidth',8);
plot([0 0],[0 20],'k--','LineWidth',4); axis([-5 60 0 20]); 
h = legend('$N_{\mathrm{slip}}$','$N_{\mathrm{catch}}$');
set(h,'EdgeColor','w','Interpreter','LaTeX','Location','SouthEast'); hold off;

figure(3); hold on; set(gcf,'Color','w'); set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$\tilde{t}$ $(\mathrm{s})$','FontSize',90,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{bonds}}$','FontSize',90,'Interpreter','LaTeX');
title('$100\%$ $\mathrm{VSV8}$','FontSize',90,'Interpreter','LaTeX');
