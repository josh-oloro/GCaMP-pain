clearvars
close all
load('E_Pain_adj_ROI')

CA = [mean_adj1_ROI1, mean_adj1_ROI2, mean_adj1_ROI3];
DRN = [mean_adj2_ROI1, mean_adj2_ROI2, mean_adj2_ROI3];
f1 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 1] );

conv_x = 60;
tkmarkers = [1:size(mean_adj1_ROI1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;

min_plot_y = -0.1;
max_plot_y = 0.1;

min_plot_x = -15;
max_plot_x = 95;

imagesc_min = minVal1;
imagesc_max = maxVal1;

prow = 10;
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

subplot(prow,pcol,190)
R3H = text(0, 0.5, 'Behavior', 'FontSize', 16,...
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
FM1_lick = [191 192 193 194 195 196];% ...
%    212 213 214 215 216 217];

for i = 1:3
    subplot(prow,pcol,FM1(i,:))
    pl_mean1 = plot(tkmarker_mins, CA(:, i), 'LineWidth', 3);
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'ROI'; num2str(i)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    %axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if i == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([75 75], [-0.1+0.01 -0.05+0.01], 'Color', 'k','LineWidth',3)
        text(77, -0.075+0.01, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end
    
end

subplot(prow,pcol, FM1_img1)
imagesc(flipud(rot90(image1)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],...
    [A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],...
    [A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],...
    [A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
title({plot_title1, ['Frame ',num2str(sample_frame1)]})
colormap (jet);
colorbar
axis off

for i = 1:3
    subplot(prow,pcol,FM1(i+3,:))
    pl_mean1 = plot(tkmarker_mins, DRN(:, i), 'LineWidth', 3, 'Color', 'r');
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'ROI'; num2str(i)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    %axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if i == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([75 75], [-0.1+0.01 -0.05+0.01], 'Color', 'k','LineWidth',3)
        text(77, -0.075+0.01, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end
    
end

subplot(prow,pcol, FM1_img2)
imagesc(flipud(rot90(image2)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],...
    [B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],...
    [B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],...
    [B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
title({plot_title2, ['Frame ',num2str(sample_frame2)]})
colormap (jet);
colorbar
axis off

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
load('I_PBS_adj_ROI')

CA = [mean_adj1_ROI1, mean_adj1_ROI2, mean_adj1_ROI3];
DRN = [mean_adj2_ROI1, mean_adj2_ROI2, mean_adj2_ROI3];

conv_x = 60;
every_tick = 10;
tkmarkers = [1:size(mean_adj1_ROI1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;

max_plot_y = 0.1;
min_plot_y = -0.1;

tplot2 = [4:7] + ceil(pcol/2);

subplot(prow,pcol,tplot2)
text(0, 0.5, 'PBS Mouse 2', 'FontSize', 20,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

PBSM1 = FM1 + ceil(pcol/2);
PBSM1_img1 = FM1_img1 + ceil(pcol/2);
PBSM1_img2 = FM1_img2 + ceil(pcol/2);
PBSM1_lick = FM1_lick + ceil(pcol/2);

for i = 1:3
    subplot(prow,pcol,PBSM1(i,:))
    pl_mean1 = plot(tkmarker_mins, CA(:, i), 'LineWidth', 3);
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'ROI'; num2str(i)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    %axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if i == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([75 75], [-0.1+0.01 -0.05+0.01], 'Color', 'k','LineWidth',3)
        text(77, -0.075+0.01, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end
    
end

subplot(prow,pcol, PBSM1_img1)
imagesc(flipud(rot90(image1)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],...
    [A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],...
    [A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],...
    [A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
title({plot_title1, ['Frame ',num2str(sample_frame1)]})
colormap (jet);
colorbar
axis off

for i = 1:3
    subplot(prow,pcol,PBSM1(i+3,:))
    pl_mean1 = plot(tkmarker_mins, DRN(:, i), 'LineWidth', 3, 'Color', 'r');
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'ROI'; num2str(i)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    %axis off
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if i == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([75 75], [-0.1+0.01 -0.05+0.01], 'Color', 'k','LineWidth',3)
        text(77, -0.075+0.01, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
        
    end
    
end

subplot(prow,pcol, PBSM1_img2)
imagesc(flipud(rot90(image2)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],...
    [B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+2, '1','FontSize',8, 'Color', 'r');
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],...
    [B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+2, '2','FontSize',8, 'Color', 'r');
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],...
    [B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+2, '3','FontSize',8, 'Color', 'r');
title({plot_title2, ['Frame ',num2str(sample_frame2)]})
colormap (jet);
colorbar
axis off

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
load('BehaviorTally')
subplot(prow,pcol, FM1_lick)
stem(BehTime, Formalin(:,1), 'LineWidth', 3, 'Color', 'k')
xlim([min_plot_x max_plot_x])
ylim([0 max(Beh(:))])
ax = gca;
ax.Box = 'off';
ax.Color = 'none';
ax.XLabel.String = ['Minutes'];
yl = ylabel('# of Licks');
yl.FontSize = 14;
%yl.Rotation = 0;

subplot(prow,pcol, PBSM1_lick)
stem(BehTime, PBS(:,1), 'LineWidth', 3, 'Color', 'k')
xlim([min_plot_x max_plot_x])
ylim([0 max(Beh(:))])
ax = gca;
ax.Box = 'off';
ax.Color = 'none';
ax.XLabel.String = ['Minutes'];
yl = ylabel('# of Licks');
yl.FontSize = 14;
%yl.Rotation = 0;