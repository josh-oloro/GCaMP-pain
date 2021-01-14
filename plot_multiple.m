%function [mean_adj_ROI, sem_adj_ROI] = 

% mean_adj_ROI1 = squeeze(mean(data_adj_ROI1, [1 2],'omitnan'));
% sem_adj_ROI1 = squeeze(std(data_adj_ROI1, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI1, 1) * size(data_adj_ROI1,2));
% 
% mean_adj_ROI2 = squeeze(mean(data_adj_ROI2, [1 2],'omitnan'));
% sem_adj_ROI2 = squeeze(std(data_adj_ROI2, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI2, 1) * size(data_adj_ROI2,2));

plot_title = 'Offset adjusted ROIs';

min_y = -300;
max_y = 400;

inj_start = 18380; %start of injection period
inj_end = 18930; %end of injection period
start_mark = 18712; %Assign frame as timepoint 0

plot_data = mean_of_adj;
plot_sem = sem_of_adj;

% Create figure
fig_mean = figure( 'Units', 'normalized', 'Position', [0 0.5 1 1] );
figure(fig_mean) % call appropriate figure where line will be plotted

pl_mean_whole = plot(mean_of_adj,'Color', 'r', 'LineWidth', 1.5,'DisplayName','whole frame');
hold on
% %errorbar(mean_of_adj, sem_of_adj, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean1,'top')

pl_mean1 = plot(mean_adj_ROI1, 'Color',[0.0745 0.6235 1.0000],'LineWidth', 1.5,'DisplayName','ROI1');
% %errorbar(mean_adj_ROI1, sem_adj_ROI1, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean2,'top')

pl_mean2 = plot(mean_adj_ROI2, 'Color',[0 0 1],'LineWidth', 1.5,'DisplayName','ROI2');
% %errorbar(mean_adj_ROI1, sem_adj_ROI1, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean3,'top')

pl_mean5 = plot(mean_adj_ROI5, 'Color',[0.4941    0.1843    0.5569], 'LineWidth', 1.5,'DisplayName','ROI5');
% %errorbar(mean_adj_ROI1, sem_adj_ROI1, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean2,'top')

pl_mean6 = plot(mean_adj_ROI6, 'Color',[0.9294 0.6941 0.1255],'LineWidth', 1.5,'DisplayName','ROI6');
% %errorbar(mean_adj_ROI1, sem_adj_ROI1, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean2,'top')

pl_mean7 = plot(mean_adj_ROI7, 'Color',[0.4667 0.6745 0.1882],'LineWidth', 1.5,'DisplayName','ROI7');
% %errorbar(mean_adj_ROI1, sem_adj_ROI1, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean2,'top')

pl_mean8 = plot(mean_adj_ROI8, 'Color',[1    0.5    0.1255], 'LineWidth', 1.5,'DisplayName','ROI8');
% %errorbar(mean_adj_ROI1, sem_adj_ROI1, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean2,'top')

pl_mean12 = plot(mean_adj_ROI12, 'Color',[1    0    1], 'LineWidth', 1.5,'DisplayName','ROI12');
% %errorbar(mean_adj_ROI1, sem_adj_ROI1, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
% uistack(pl_mean2,'top')

pl_mean_bg = plot(mean_adj_bg, 'Color',[   0.5020    0.5020    0.5020],'LineWidth', 1.5,'DisplayName','Random');

% Add marker of injection period
patch([inj_start inj_end inj_end inj_start], [min_y min_y max_y max_y],'b','LineStyle','none');
alpha(0.3);
text(inj_start, (max_y-min_y)/4 + min_y, '\leftarrow injection period','FontSize',14);


% Add marker for Frame0s
for ijk = 1:size(f0_id,2)
    xline(f0_id(ijk),'LineWidth',3); % Label raw Frame0s
end

% Add labels
xlabel('Minutes','FontSize', 14);
ylabel('Pixel Value (D.N.)','FontSize', 20);

ylim([min_y max_y])

title(plot_title);
set(gca, 'FontSize', 24);

legend1 = legend({'Whole frame','ROI1','ROI2','ROI5','ROI6','ROI7','ROI8','ROI12','Background?'});
set(legend1, 'Location', 'best');


% Adjust time markers
conv_x = 60; %how many seconds to one interval?
every_tick = 10; %1 interval of convX is one tick
tkmarkers = [1:size(data_raw,3)]; %gets number of frames into a 1D sequence
tkmarker_mins = tkmarkers./fps/conv_x; %equation for converting frames to desired time interval (convX)
[~,timepos] = min(abs(tkmarker_mins-1)); %gets the frame closest to one interval/ gets the number of frames for one interval
tMarkers = [1:timepos*every_tick:size(data_raw,3)]; %multiplies to number of intervals for each tick
tMarker_ticks = tMarkers./fps/conv_x; %equation for converting frames to ticks
tMarker_ticks = tMarker_ticks - tkmarker_mins(start_mark);


xticks(tMarkers);
tklabels = num2cell(tMarker_ticks);
fun = @(x) sprintf('%0.0f', x);
tklabels = cellfun(fun, tklabels, 'UniformOutput',0);
xticklabels(tklabels);
