close all
clearvars

load('E_Pain_adj_ROI')
CA = [mean_adj1_ROI1, mean_adj1_ROI2, mean_adj1_ROI3];
DRN = [mean_adj2_ROI1, mean_adj2_ROI2, mean_adj2_ROI3];
f1 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 1] );

conv_x = 60;
tkmarkers = [1:size(mean_adj1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;

max_y1 = 0.1;
min_y1 = -0.1;

prow = 8;
pcol = 21;

tplot1 = 4:7;

subplot(prow,pcol,tplot1)
text(0, 0.5, 'Formalin Mouse 1', 'FontSize', 20,...
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

FM1 = [23	24	25	26	27	28;
    44	45	46	47	48	49;
    65	66	67	68	69	70;
    107	108	109	110	111	112;
    128	129	130	131	132	133;
    149	150	151	152	153	154];

FM1_img1 = [29 30 31 50 51 52 71 72 73];
FM1_img2 = [113 114 115 134 135 136 155 156 157];

for i = 1:3
    subplot(prow,pcol,FM1(i,:))
    pl_mean1 = plot(tkmarker_mins, CA(:, i), 'LineWidth', 3);
    hold on
    ylim([-0.1 0.1])
    xlim([-15 95])
    yl = ylabel(['ROI', num2str(i)]);
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_y1 min_y1 max_y1 max_y1],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);
end

subplot(prow,pcol, FM1_img1)
%image1 = normrnd(0, 1,50,100);
image1 = rot90(image1);
imagesc(flipud(image1), [minVal1,maxVal1]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],...
    [A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],...
    [A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],...
    [A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title({plot_title1, ['Frame ',num2str(sample_frame)]})
colormap (jet);
colorbar
axis off

for i = 1:3
    subplot(prow,pcol,FM1(i+3,:))
    pl_mean1 = plot(tkmarker_mins, DRN(:, i), 'LineWidth', 3, 'Color', 'r');
    hold on
    ylim([-0.1 0.1])
    xlim([-15 95])
    yl = ylabel(['ROI', num2str(i)]);
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_y1 min_y1 max_y1 max_y1],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);
end

subplot(prow,pcol, FM1_img2)
%image2 = normrnd(0, 1,50,100);
image2 = rot90(image2);
imagesc(flipud(image2), [minVal2,maxVal2]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],...
    [B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],...
    [B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],...
    [B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title({plot_title2, ['Frame ',num2str(sample_frame)]})
colormap (jet);
colorbar
axis off

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%

CA = [mean_adj1_ROI1, mean_adj1_ROI2, mean_adj1_ROI3];
DRN = [mean_adj2_ROI1, mean_adj2_ROI2, mean_adj2_ROI3];

conv_x = 60;
every_tick = 10;
tkmarkers = [1:size(mean_adj1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;

max_y1 = 0.1;
min_y1 = -0.1;

tplot2 = [4:7] + ceil(pcol/2);

subplot(prow,pcol,tplot2)
text(0, 0.5, 'PBS Mouse 1', 'FontSize', 20,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

PBSM1 = FM1 + ceil(pcol/2);
PBSM1_img1 = FM1_img1 + ceil(pcol/2);
PBSM1_img2 = FM1_img2 + ceil(pcol/2);

for i = 1:3
    subplot(prow,pcol,PBSM1(i,:))
    pl_mean1 = plot(tkmarker_mins, CA(:, i), 'LineWidth', 3);
    hold on
    ylim([-0.1 0.1])
    xlim([-15 95])
    yl = ylabel(['ROI', num2str(i)]);
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_y1 min_y1 max_y1 max_y1],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);
end

subplot(prow,pcol, PBSM1_img1)
%image1 = normrnd(0, 1,50,100);
image1 = rot90(image1);
imagesc(flipud(image1), [minVal1,maxVal1]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],...
    [A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],...
    [A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],...
    [A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title({plot_title1, ['Frame ',num2str(sample_frame)]})
colormap (jet);
colorbar
axis off

for i = 1:3
    subplot(prow,pcol,PBSM1(i+3,:))
    pl_mean1 = plot(tkmarker_mins, DRN(:, i), 'LineWidth', 3, 'Color', 'r');
    hold on
    ylim([-0.1 0.1])
    xlim([-15 95])
    yl = ylabel(['ROI', num2str(i)]);
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_y1 min_y1 max_y1 max_y1],'y','LineStyle','none');
    axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    alpha(0.3);
end

subplot(prow,pcol, PBSM1_img2)
%image2 = normrnd(0, 1,50,100);
image2 = rot90(image2);
imagesc(flipud(image2), [minVal2,maxVal2]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],...
    [B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],...
    [B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],...
    [B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title({plot_title2, ['Frame ',num2str(sample_frame)]})
colormap (jet);
colorbar
axis off