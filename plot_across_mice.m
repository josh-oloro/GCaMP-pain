clearvars
Formalin_mat = {'L_Pain_adj', 'M_Pain_adj', 'N_Pain_adj'};
PBS_mat = {'P_PBS_adj', 'Q_PBS_adj', 'R_PBS_adj'};
nFilesA = numel (Formalin_mat);
nFilesB = numel (PBS_mat);

f1 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 1] );
min_plot_x = -15;
max_plot_x = 65;
min_plot_y = -0.1;
max_plot_y = 0.1;

prow = 10;
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

subplot(prow,pcol,190)
R3H = text(0, 0.5, 'Behavior', 'FontSize', 16,...
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
FM1_lick = [191 192 193 194 195 196 197 198 199];

% imagesc_min = -0.1;
% imagesc_max = 0.1;

tplot2 = [4:7] + ceil(pcol/2);

subplot(prow,pcol,tplot2)
text(0, 0.5, 'PBS Group', 'FontSize', 20,...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'Middle',...
    'fontweight', 'bold')
axis off

PBSM1 = FM1 + ceil(pcol/2);
% PBSM1_img1 = FM1_img1 + ceil(pcol/2);
% PBSM1_img2 = FM1_img2 + ceil(pcol/2);
PBSM1_lick = FM1_lick + ceil(pcol/2);

for j = 1:nFilesA
load(Formalin_mat{j})

CA = [mean_adj1];
DRN = [mean_adj2];

conv_x = 60;
tkmarkers = [1:size(mean_adj1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;


    subplot(prow,pcol,FM1(j,:))
    pl_mean1 = plot(tkmarker_mins, CA, 'LineWidth', 1.5);
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(j)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if j == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'Mouse'; num2str(j)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 14;
        ax.XAxis.FontSize = 12;
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([max_plot_x-10 max_plot_x-10], [-0.1+0.1 -0.05+0.1], 'Color', 'k','LineWidth',3)
        text(max_plot_x-8, -0.075+0.1, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end

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
    pl_mean1 = plot(tkmarker_mins, DRN, 'LineWidth', 1.5, 'Color', 'r');
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(j)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if j == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'Mouse'; num2str(j)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 14;
        ax.XAxis.FontSize = 12;
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([max_plot_x-10 max_plot_x-10], [-0.1+0.1 -0.05+0.1], 'Color', 'k','LineWidth',3)
        text(max_plot_x-8, -0.075+0.1, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end

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
load(PBS_mat{k})

CA = [mean_adj1];
DRN = [mean_adj2];

conv_x = 60;
tkmarkers = [1:size(mean_adj1, 1)] - start_mark;
tkmarker_mins = tkmarkers./fps/conv_x;

inj_start_min = (inj_start-start_mark)./fps/conv_x;
inj_end_min = (inj_end-start_mark)./fps/conv_x;

    subplot(prow,pcol,PBSM1(k,:))
    pl_mean1 = plot(tkmarker_mins, CA, 'LineWidth', 1.5);
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(k)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if k == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'Mouse'; num2str(k)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 14;
        ax.XAxis.FontSize = 12;
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([max_plot_x-10 max_plot_x-10], [-0.1+0.1 -0.05+0.1], 'Color', 'k','LineWidth',3)
        text(max_plot_x-8, -0.075+0.1, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end


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
    pl_mean1 = plot(tkmarker_mins, DRN, 'LineWidth', 1.5, 'Color', 'r');
    hold on
    ylim([min_plot_y max_plot_y])
    xlim([min_plot_x max_plot_x])
    yl = ylabel({'Mouse'; num2str(k)});
    patch([inj_start_min inj_end_min inj_end_min inj_start_min],...
        [min_plot_y min_plot_y max_plot_y max_plot_y],'y','LineStyle','none');
    yl.Visible = 'on';
    yl.Rotation = 0;
    yl.FontSize = 14;
    newPost = yl.Position;
    alpha(0.3);
    
    if k == 3
        ax = gca;
        ax.Box = 'off';
        ax.YTick = [];
        ax.YColor = [1 1 1];
        ax.Color = 'none';
        ax.YLabel.String = [{'Mouse'; num2str(k)}];
        ax.YLabel.Color = [0 0 0];
        ax.XLabel.String = ['Minutes'];
        ax.XLabel.FontSize = 14;
        ax.XAxis.FontSize = 12;
        ax.YLabel.Position = newPost + [1 0 0];
        
        plot([max_plot_x-10 max_plot_x-10], [-0.1+0.1 -0.05+0.1], 'Color', 'k','LineWidth',3)
        text(max_plot_x-8, -0.075+0.1, '\DeltaF/F 0.05', 'HorizontalAlignment', 'left')
    else
        axis off
    end

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


%%%%%%%%%%%%%%%%%%%%%%%%
load('BehaviorTally')

% bStart_frame = 14897;
% FM1_bStart = (bStart_frame - start_mark)./fps/conv_x;
% PBS1_bStart = (bStart_frame - start_mark)./fps/conv_x;
FM1_bStart = 2.5;
PBS1_bStart = 2.5;
all_marks = {'o','square','^','diamond'};
marker_size = {7.5,6,3};

subplot(prow,pcol, FM1_lick)
hold off
% for i = 1:3
% stem(BehTime+FM1_bStart, Formalin(:,i), 'LineWidth', 1.5, 'LineStyle', '-', ...
%     'DisplayName', ['Mouse ' num2str(i)],'Marker', all_marks{i},'MarkerSize',marker_size{2})
% hold on
% end
breakplot_stem(BehTime+FM1_bStart,mean(Formalin,2),50,100,'Patch')
stem(BehTime+FM1_bStart, mean(Formalin,2), 'LineWidth', 3, 'Color', 'k');
hold on
xlim([min_plot_x max_plot_x])
ylim([0 max(Beh(:))])
yticks([0 50 100 150])
% legend('Location','best')
ax = gca;
ax.Box = 'off';
ax.Color = 'none';
ax.XLabel.String = ['Minutes'];
ax.XLabel.FontSize = 14;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
yl = ylabel('Ave # of Licks');
yl.FontSize = 14;
%yl.Rotation = 0;

subplot(prow,pcol, PBSM1_lick)
hold off
% for j = 1:3    
% stem(BehTime+PBS1_bStart, PBS(:,1), 'LineWidth', 1.5, 'LineStyle', '-', ...
%     'DisplayName', ['Mouse ' num2str(j)], 'Marker', all_marks{j},'MarkerSize',marker_size{j})
% hold on
% end
stem(BehTime+PBS1_bStart, mean(PBS,2), 'LineWidth', 3, 'Color', 'k');
hold on;
xlim([min_plot_x max_plot_x])
ylim([0 max(Beh(:))])
yticks([0 50 100 150])
% legend('Location','best')
ax = gca;
ax.Box = 'off';
ax.Color = 'none';
ax.XLabel.String = ['Minutes'];
ax.XLabel.FontSize = 14;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
yl = ylabel('Ave # of Licks');
yl.FontSize = 14;
%yl.Rotation = 0;
hold off