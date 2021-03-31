clearvars
load('E_Pain_adj_ROI')

CA = [mean_adj1_ROI1, mean_adj1_ROI2, mean_adj1_ROI3, mean_adj1_bg];	
DRN = [mean_adj2_ROI1, mean_adj2_ROI2, mean_adj2_ROI3, mean_adj2_bg];	
f1 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 1] );

%%
fps = 10.68;
%%
conv_x = 60;
tkmarkers = [1:size(mean_adj1_ROI1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;

min_plot_y = -0.02;
max_plot_y = 0.15;

min_plot_x = -10;
max_plot_x = 65;

imagesc_min = minVal1;
imagesc_max = maxVal1;

prow = 10;
pcol = 21;

tplot1 = 4:7;

subplot(prow,pcol,tplot1)
text(0, 0.5, 'Formalin-injected', 'FontSize', 21,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

subplot(prow,pcol,[22,43,64 85])
R1H = text(0, 0.5, 'Central Amygdala', 'FontSize', 18,...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
    'fontweight', 'bold', 'Rotation', 90);
axis off
	
subplot(prow,pcol,[127,148, 169, 190])	
R2H = text(0, 0.5, 'Dorsal Raphe Nucleus', 'FontSize', 18,...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
    'fontweight', 'bold', 'Rotation', 90);
axis off

FM1 = [23	24	25	26	27	28;
    44	45	46	47	48	49;
    65	66	67	68	69	70;
    86  87  88  89  90  91;
    128	129	130	131	132	133;
    149	150	151	152	153	154;  
    170	171	172	173	174	175;	
    191	192	193	194	195 196];

FM1_img1 = [29 30 31 50 51 52 71 72 73 92 93 94];
FM1_img2 = [134 135 136 155 156 157 176 177 178 197 198 199];

for i = 1:4
    subplot(prow,pcol,FM1(i,:))
    pl_mean1 = plot(tkmarker_mins, CA(:, i), 'LineWidth', 1.5);
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
    
    if i == 4
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        %ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.String = ['BG'];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 15;
        ax.XAxis.FontSize = 14;
        ax.YLabel.Position = newPost + [1 0 0];
        
       plot([max_plot_x-16 max_plot_x-16], [0.07 0.05+0.07], 'Color', 'k','LineWidth',3)
        text(50, 0.120, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end
    
end

subplot(prow,pcol, FM1_img1)
imagesc(flipud(rot90(image1)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],[A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'k')
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+3, '1','FontSize',10,'FontWeight', 'bold', 'Color', 'k');
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],[A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'k')
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+3, '2','FontSize',10,'FontWeight', 'bold', 'Color', 'k');
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],[A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'k')
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+3, '3','FontSize',10,'FontWeight', 'bold', 'Color', 'k');
% title('\Delta F/F - CeLC', ['Frame ',num2str(sample_frame1)])
time_frame1 = time_frame1 + 1;
title(['\DeltaF/F CeLC - Minute ', num2str(time_frame1)])
colormap (jet);
colorbar
axis off

for i = 1:4
    subplot(prow,pcol,FM1(i+4,:))
    pl_mean1 = plot(tkmarker_mins, DRN(:, i), 'LineWidth', 1.5, 'Color', 'r');
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
    
    if i == 4
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        %ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.String = ['BG'];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 15;
        ax.XAxis.FontSize = 14;
        ax.YLabel.Position = newPost + [1 0 0];
        
       plot([max_plot_x-16 max_plot_x-16], [0.07 0.05+0.07], 'Color', 'k','LineWidth',3)
        text(50, 0.120, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end
    
end

subplot(prow,pcol, FM1_img2)
imagesc(flipud(rot90(image2)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],[B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'k')
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+3, '1','FontSize',10,'FontWeight', 'bold','Color', 'k');
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],[B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'k')
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+3, '2','FontSize',10,'FontWeight', 'bold', 'Color', 'k');
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],[B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'k')
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+3, '3','FontSize',10,'FontWeight', 'bold', 'Color', 'k');
% title('\Delta F/F - DRN', ['Frame ',num2str(sample_frame2)])
time_frame2 = time_frame2 + 1;
title(['\DeltaF/F DRN - Minute ', num2str(time_frame2)])
colormap (jet);
colorbar
axis off

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
load('I_PBS_adj_ROI')

CA = [mean_adj1_ROI1, mean_adj1_ROI2, mean_adj1_ROI3, mean_adj1_bg];
DRN = [mean_adj2_ROI1, mean_adj2_ROI2, mean_adj2_ROI3, mean_adj2_bg];
% CA = [detrend(mean_adj1_ROI1), detrend(mean_adj1_ROI2), detrend(mean_adj1_ROI3), detrend(mean_adj1_bg)];
% DRN = [detrend(mean_adj2_ROI1), detrend(mean_adj2_ROI2), detrend(mean_adj2_ROI3), detrend(mean_adj2_bg)];

%%
fps = 10.68;
%%

conv_x = 60;
every_tick = 10;
tkmarkers = [1:size(mean_adj1_ROI1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

min_plot_y = -0.02;
max_plot_y = 0.15;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;


tplot2 = [4:7] + ceil(pcol/2);

subplot(prow,pcol,tplot2)
text(0, 0.5, 'PBS-injected', 'FontSize', 21,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

PBSM1 = FM1 + ceil(pcol/2);
PBSM1_img1 = FM1_img1 + ceil(pcol/2);
PBSM1_img2 = FM1_img2 + ceil(pcol/2);

for i = 1:4
    subplot(prow,pcol,PBSM1(i,:))
    pl_mean1 = plot(tkmarker_mins, CA(:, i), 'LineWidth', 1.5);
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
    
    if i == 4
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        %ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.String = ['BG'];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 15;
        ax.XAxis.FontSize = 14;
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([max_plot_x-16 max_plot_x-16], [0.07 0.05+0.07], 'Color', 'k','LineWidth',3)
        text(50, 0.120, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end
    
end

subplot(prow,pcol, PBSM1_img1)
imagesc(flipud(rot90(image1)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],[A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')	
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+3, '1','FontSize',10,'FontWeight', 'bold', 'Color', 'r');	
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],[A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')	
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+3, '2','FontSize',10,'FontWeight', 'bold', 'Color', 'r');	
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],[A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')	
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+3, '3','FontSize',10,'FontWeight', 'bold', 'Color', 'r');	
% title('\Delta F/F - CeLC', ['Frame ',num2str(sample_frame1)])	
title(['\DeltaF/F CeLC - Minute ', num2str(time_frame1)])
colormap (jet);
colorbar
axis off

for i = 1:4
    subplot(prow,pcol,PBSM1(i+4,:))
    pl_mean1 = plot(tkmarker_mins, DRN(:, i), 'LineWidth', 1.5, 'Color', 'r');
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
    
    if i == 4
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        %ax.YLabel.String = [{'ROI'; num2str(i)}];
        ax.YLabel.String = ['BG'];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 15;
        ax.XAxis.FontSize = 14;
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([max_plot_x-16 max_plot_x-16], [0.07 0.05+0.07], 'Color', 'k','LineWidth',3)
        text(50, 0.120, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
        
    end
    
end

subplot(prow,pcol, PBSM1_img2)
imagesc(flipud(rot90(image2)), [imagesc_min,imagesc_max]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],[B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')	
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+3, '1','FontSize',10,'FontWeight', 'bold','Color', 'r');	
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],[B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')	
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+3, '2','FontSize',10,'FontWeight', 'bold', 'Color', 'r');	
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],[B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')	
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+3, '3','FontSize',10,'FontWeight', 'bold', 'Color', 'r');	
% title('\Delta F/F - CeLC', ['Frame ',num2str(sample_frame2)])	
title(['\DeltaF/F DRN - Minute ', num2str(time_frame2)])
colormap (jet);
colorbar
axis off