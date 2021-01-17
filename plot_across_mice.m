Formalin = {'E_Pain_adj', 'F_Pain_adj', 'G_Pain_adj'};
PBS = {'H_PBS_adj', 'I_PBS_adj', 'J_PBS_adj'};
nFilesA = numel (Formalin);
nFilesB = numel (PBS);

f1 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 1] );
min_plot_x = -15;
max_plot_x = 95;
min_plot_y = -0.1;
max_plot_y = 0.1;

prow = 8;
pcol = 21;

tplot1 = 4:7;

subplot(prow,pcol,tplot1)
text(0, 0.5, 'Formalin Group', 'FontSize', 20,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

subplot(prow,pcol,[22,43,64])
R1H = text(0, 0.5, 'Central Amygdala', 'FontSize', 16,...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
    'fontweight', 'bold', 'Rotation', 90);
axis off

subplot(prow,pcol,[106,127,148])
R2H = text(0, 0.5, 'Dorsal Raphe Nucleus', 'FontSize', 16,...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
    'fontweight', 'bold', 'Rotation', 90);
axis off

FM1 = [23	24	25	26	27	28 29 30 31;
    44	45	46	47	48	49 50 51 52;
    65	66	67	68	69	70 71 72 73;
    107	108	109	110	111	112 113 114 115;
    128	129	130	131	132	133 134 135 136;
    149	150	151	152	153	154 155 156 157];

% FM1_img1 = [29 30 31 50 51 52 71 72 73];
% FM1_img2 = [113 114 115 134 135 136 155 156 157];

% imagesc_min = -0.1;
% imagesc_max = 0.1;

tplot2 = [4:7] + ceil(pcol/2);

subplot(prow,pcol,tplot2)
text(0, 0.5, 'PBS Mouse 1', 'FontSize', 20,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

PBSM1 = FM1 + ceil(pcol/2);
% PBSM1_img1 = FM1_img1 + ceil(pcol/2);
% PBSM1_img2 = FM1_img2 + ceil(pcol/2);

for j = 1:nFilesA
load(Formalin{j})

CA = [mean_adj1];
DRN = [mean_adj2];

conv_x = 60;
tkmarkers = [1:size(mean_adj1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;


    subplot(prow,pcol,FM1(j,:))
    pl_mean1 = plot(tkmarker_mins, CA, 'LineWidth', 3);
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(j)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);


% subplot(prow,pcol, FM1_img1)
% imagesc(flipud(rot90(image1)), [imagesc_min,imagesc_max]);
% set(gca,'XDir','reverse','YDir','normal')
% hold on
% plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],...
%     [A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
% text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
% plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],...
%     [A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
% text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
% plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],...
%     [A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
% text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
% title({plot_title1, ['Frame ',num2str(sample_frame1)]})
% colormap (jet);
% colorbar
% axis off


    subplot(prow,pcol,FM1(j+nFilesA,:))
    pl_mean1 = plot(tkmarker_mins, DRN, 'LineWidth', 3, 'Color', 'r');
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(j)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);


% subplot(prow,pcol, FM1_img2)
% imagesc(flipud(rot90(image2)), [imagesc_min,imagesc_max]);
% set(gca,'XDir','reverse','YDir','normal')
% hold on
% plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],...
%     [B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
% text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
% plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],...
%     [B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
% text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
% plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],...
%     [B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
% text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
% title({plot_title2, ['Frame ',num2str(sample_frame2)]})
% colormap (jet);
% colorbar
% axis off

end
%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:nFilesB
load(PBS{k})

CA = [mean_adj1];
DRN = [mean_adj2];

conv_x = 60;
tkmarkers = [1:size(mean_adj1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;

    subplot(prow,pcol,PBSM1(k,:))
    pl_mean1 = plot(tkmarker_mins, CA, 'LineWidth', 3);
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(k)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);


% subplot(prow,pcol, PBSM1_img1)
% imagesc(flipud(rot90(image1)), [imagesc_min,imagesc_max]);
% set(gca,'XDir','reverse','YDir','normal')
% hold on
% plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],...
%     [A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
% text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
% plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],...
%     [A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
% text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
% plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],...
%     [A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
% text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
% title({plot_title1, ['Frame ',num2str(sample_frame1)]})
% colormap (jet);
% colorbar
% axis off


    subplot(prow,pcol,PBSM1(k+nFilesB,:))
    pl_mean1 = plot(tkmarker_mins, DRN, 'LineWidth', 3, 'Color', 'r');
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(k)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);


% subplot(prow,pcol, PBSM1_img2)
% imagesc(flipud(rot90(image2)), [imagesc_min,imagesc_max]);
% set(gca,'XDir','reverse','YDir','normal')
% hold on
% plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],...
%     [B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
% text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
% plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],...
%     [B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
% text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
% plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],...
%     [B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
% text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
% title({plot_title2, ['Frame ',num2str(sample_frame2)]})
% colormap (jet);
% colorbar
% axis off
end