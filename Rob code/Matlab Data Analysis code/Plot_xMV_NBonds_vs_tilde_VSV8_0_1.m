TP_VSV8_0_1 = [338 600; 177 381; 230 395;];
t_VSV8_0_1_T9 = -5:0.1:21.2; 
t_VSV8_0_1_T17 = -5:0.1:15.4; t_VSV8_0_1_T25 = -5:0.1:11.5; 

NCatch_tilde_VSV8_0_1(1:length(t_VSV8_0_1_T9),1)  = NCatch_VSV8_0_1(338:600,9);
NCatch_tilde_VSV8_0_1(1:length(t_VSV8_0_1_T17),2) = NCatch_VSV8_0_1(177:381,17);
NCatch_tilde_VSV8_0_1(1:length(t_VSV8_0_1_T25),3) = NCatch_VSV8_0_1(230:395,25);

NSlip_tilde_VSV8_0_1(1:length(t_VSV8_0_1_T9),1)  = NSlip_VSV8_0_1(338:600,9);
NSlip_tilde_VSV8_0_1(1:length(t_VSV8_0_1_T17),2) = NSlip_VSV8_0_1(177:381,17);
NSlip_tilde_VSV8_0_1(1:length(t_VSV8_0_1_T25),3) = NSlip_VSV8_0_1(230:395,25);

MV_center_VSV8_0_1(1:length(t_VSV8_0_1_T9),1) = MV_center_VSV8_0_1_all(338:600,9);
MV_center_VSV8_0_1(1:length(t_VSV8_0_1_T9),2) = MV_center_VSV8_0_1_all(177:381,17);
MV_center_VSV8_0_1(1:length(t_VSV8_0_1_T9),3) = MV_center_VSV8_0_1_all(230:395,25);

figure(4); hold on; set(gca,'LineWidth',2.5,'FontSize',75);
xlabel('$\tilde{t}$ $(\mathrm{s})$','FontSize',90,'Interpreter','LaTeX');
ylabel('$\overline{N}_{\mathrm{bonds}}$','FontSize',90,'Interpreter','LaTeX');
title('$10\%$ $\mathrm{VSV8}$','FontSize',90,'Interpreter','LaTeX');
