close all
clearvars

load('E_Pain_adj_ROI')
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

subplot(8,10,2:5)
text(0, 0.5, 'Formalin Mouse 1', 'FontSize', 20,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

subplot(8,10,[11,21,31])
R1H = text(0, 0.5, 'Central Amygdala', 'FontSize', 16,...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
    'fontweight', 'bold', 'Rotation', 90);
axis off

subplot(8,10,[51,61,71])
R2H = text(0, 0.5, 'Dorsal Raphe Nucleus', 'FontSize', 16,...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom',...
    'fontweight', 'bold', 'Rotation', 90);
axis off

FM1 = [12:15;22:25;32:35;52:55;62:65;72:75];

for i = 1:3
    subplot(8,10,FM1(i,:))
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


for i = 1:3
    subplot(8,10,FM1(i+3,:))
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

subplot(8,10,7:10)
text(0, 0.5, 'PBS Mouse 1', 'FontSize', 20,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

PBSM1 = [12:15;22:25;32:35;52:55;62:65;72:75]+5;

for i = 1:3
    subplot(8,10,PBSM1(i,:))
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


for i = 1:3
    subplot(8,10,PBSM1(i+3,:))
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