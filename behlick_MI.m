clearvars

data = {'L_Pain_adj_ROI.mat', 'M_Pain_adj_ROI.mat',...
    'N_Pain_adj_ROI.mat', 'O_Pain_adj_ROI.mat',...
    'P_Pain_adj_ROI.mat', 'Q_Pain_adj_ROI.mat', 'R_Pain_adj_ROI.mat'};
lick_i = [1:4, 1:3];
f = [];

for data_i = 1:numel(data)
    clearvars -except data lick_i f data_i
    load(data{data_i});
    load('BehaviorTally.mat');
    
    conv_x = 60;
    tkmarkers = [1:size(mean_adj1_ROI1, 1)] - start_mark;
    tkmarker_mins = tkmarkers./fps/conv_x;
    
    all_ROI = [mean_adj1_ROI1, mean_adj1_ROI2, mean_adj1_ROI3...
        mean_adj2_ROI1, mean_adj2_ROI2, mean_adj2_ROI3];
    
    clearvars -except tkmarker_mins BehTime Formalin PBS...
        data lick_i f data_i all_ROI
    
    if data_i <= 4
        lick = Formalin(:,lick_i(data_i));
    else
        lick = PBS(:,lick_i(data_i));
    end
    
    t_roi = tkmarker_mins;
    t_lick = BehTime + 2.5;
    roi_bin = zeros(size(t_lick));
    
    for ri = 1:size(all_ROI, 2)
        roi = all_ROI(:, ri);
        
        for ti = 1:size(t_lick, 1)
            st = t_lick(ti);
            try
                et = t_lick(ti+1);
            catch
                et = t_lick(ti)+2.5;
            end
            roi_bin(ti) = mean(roi( t_roi >= st & t_roi <= et));
        end
        [f(ri, data_i), ~] = discrete_continuous_info_fast(lick, roi_bin);
    end
end
figure
z = f';
% z1 = z(1:4,1:4);
% z2 = z(1:4,5:8);
% z3 = z(5:7,1:4);
% z4 = z(5:7,5:8);
plot(z, 'o');


x_bar = categorical({'Formalin 1','Formalin 2','Formalin 3','Formalin 4','PBS 1','PBS 2','PBS 3'});
x_bar = reordercats(x_bar,{'Formalin 1','Formalin 2','Formalin 3','Formalin 4','PBS 1','PBS 2','PBS 3'});

% x_bar1 = categorical({'Formalin CeLC 1','Formalin CeLC 2','Formalin CeLC 3','Formalin CeLC 4'});
% x_bar1 = reordercats(x_bar1,{'Formalin CeLC 1','Formalin CeLC 2','Formalin CeLC 3','Formalin CeLC 4'});
% 
% x_bar2 = categorical({'Formalin DRN 1','Formalin DRN 2','Formalin CeLC 3','Formalin CeLC 4'});
% x_bar2 = reordercats(x_bar1,{'F1','F2','F3','F4'});
% 
% x_bar3 = categorical({'P1','P2','P3'});
% x_bar3 = reordercats(x_bar2,{'P1','P2','P3'});
% 
% x_bar4 = categorical({'P1','P2','P3'});
% x_bar4 = reordercats(x_bar2,{'P1','P2','P3'});
% 
% b = bar(x,vals);

figure
b = bar(x_bar, z,'grouped','stacked');
set(b, {'DisplayName'}, {'CeLC ROI 1-3';' ';' ';'DRN ROI 1-3';' ';' '})
b(1).FaceColor = [0 0.4470 0.7410];
b(2).FaceColor = [0 0.4470 0.7410];
b(3).FaceColor = [0 0.4470 0.7410];
% b(4).FaceColor = [0 0.4470 0.7410];
b(4).FaceColor = [0.6350 0.0780 0.1840];
b(5).FaceColor = [0.6350 0.0780 0.1840];
b(6).FaceColor = [0.6350 0.0780 0.1840];
% b(8).FaceColor = [0.6350 0.0780 0.1840];
% b = bar(x_bar1, z1,'grouped','stacked');
off = b.XOffset;
% hBar1=bar(x_bar-off,y1,0.25,'stacked'); % draw first stacked as wanted
% hold on
% b = bar(x_bar2, z2,'stacked');
legend (b(1:3:4),'FontSize',14);
ylabel('Mutual Information', 'FontSize',14,'FontWeight','bold');
title('Relationship between brain imaging and behavior', 'FontSize',16,'FontWeight','bold');
ax = gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
% xtips2 = b(2).XEndPoints;
% ytips2 = b(2).YEndPoints;
% labels2 = string(b(2).YData);
% text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
%     'VerticalAlignment','bottom')

imgsc_labelx = {'Formalin 1','Formalin 2','Formalin 3','Formalin 4','PBS 1','PBS 2','PBS 3'};
imgsc_labely = {'{CeLC}\newlineROI1', 'CeLC\newlineROI2', 'CeLC\newlineROI3',...
     '{DRN}\newlineROI1', 'DRN\newlineROI2', 'DRN\newlineROI3'};


figure
imagesc(f)
set(gca, 'xticklabel', imgsc_labelx,'FontSize',14);
set(gca, 'yticklabel', imgsc_labely,'FontSize',14);
colorbar
title('Mutual information between brain imaging and behavior', 'FontSize',16,'FontWeight','bold');

figure

celc_color = [0 0.4470 0.7410];
drn_color = [0.6350 0.0780 0.1840];

z = f';

celc_plot = plot(z(:, 1:3), 'o', 'MarkerSize', 15,...
    'Color', celc_color, 'LineWidth', 3);
hold on
drn_plot = plot(z(:, 4:6), 'x', 'MarkerSize', 15,...
    'Color', drn_color, 'LineWidth', 3);

ylabel('Mutual Information', 'FontSize',14,'FontWeight','bold');
title('Relationship between brain imaging and behavior',...
    'FontSize',16,'FontWeight','bold');
ax = gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
xlim([0.5 7.5])
xticks(1:7)
xticklabels({'Formalin 1','Formalin 2','Formalin 3','Formalin 4',...
    'PBS 1','PBS 2','PBS 3'});

set(get(get(celc_plot(2),'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','off');
set(get(get(celc_plot(3),'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','off');
set(get(get(drn_plot(2),'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','off');
set(get(get(drn_plot(3),'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','off');
legend({'CeLC ROIs', 'DRN ROIs'})