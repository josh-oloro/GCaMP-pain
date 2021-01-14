function plot_mean(plot_data1, plot_sem1, plot_title1, min_y1, max_y1, plot_data2, plot_sem2, plot_title2, min_y2, max_y2, inj_start, inj_end, f0_id, start_mark, data_raw, fps)


% Adjust time markers
conv_x = 60; %how many seconds to one interval?
every_tick = 10; %1 interval of convX is one tick
tkmarkers = [1:size(data_raw,3)]; %gets number of frames into a 1D sequence
tkmarker_mins = tkmarkers./fps/conv_x; %equation for converting frames to desired time interval (convX)
[~,timepos] = min(abs(tkmarker_mins-1)); %gets the frame closest to one interval/ gets the number of frames for one interval
tMarkers = [1:timepos*every_tick:size(data_raw,3)]; %multiplies to number of intervals for each tick
tMarker_ticks = tMarkers./fps/conv_x; %equation for converting frames to ticks
tMarker_ticks = tMarker_ticks - tkmarker_mins(start_mark);

% Create figure
fig_mean = figure( 'Units', 'normalized', 'Position', [0 0.5 1 1] );
figure(fig_mean) % call appropriate figure where line will be plotted

subplot (2,1,1)
pl_mean1 = plot(plot_data1,'Color', 'b', 'LineWidth', 3);
hold on

% Add marker of injection period
patch([inj_start inj_end inj_end inj_start], [min_y1 min_y1 max_y1 max_y1],'y','LineStyle','none');
alpha(0.3);
text(inj_start, (max_y1-min_y1)/4 + min_y1, '\leftarrow injection period','FontSize',14);
errorbar(plot_data1, plot_sem1, 'Color', [0.75, 0.75, 0.95], 'HandleVisibility','off');
uistack(pl_mean1,'top')

% Add marker for Frame0s
for ijk = 1:size(f0_id,2)
    xline(f0_id(ijk),'LineWidth',3); % Label raw Frame0s
end

% Add labels
xlabel('Minutes','FontSize', 14);
ylabel('Pixel Value (D.N.)','FontSize', 20);

ylim([min_y1 max_y1])

title(plot_title1);
set(gca, 'FontSize', 24);

% legend1 = legend({'with filter', 'without filter'});
% set(legend1, 'Location', 'best');

xticks(tMarkers);
tklabels = num2cell(tMarker_ticks);
fun = @(x) sprintf('%0.0f', x);
tklabels = cellfun(fun, tklabels, 'UniformOutput',0);
xticklabels(tklabels);

subplot (2,1,2)
pl_mean2 = plot(plot_data2,'Color', 'r', 'LineWidth', 3);
hold on

% Add marker of injection period
patch([inj_start inj_end inj_end inj_start], [min_y2 min_y2 max_y2 max_y2],'y','LineStyle','none');
alpha(0.3);
text(inj_start, (max_y2-min_y2)/4 + min_y2, '\leftarrow injection period','FontSize',14);
errorbar(plot_data2, plot_sem2, 'Color', [0.95, 0.75, 0.75], 'HandleVisibility','off');
uistack(pl_mean2,'top')

% Add marker for Frame0s
for ijk = 1:size(f0_id,2)
    xline(f0_id(ijk),'LineWidth',3); % Label raw Frame0s
end

% Add labels
xlabel('Minutes','FontSize', 14);
ylabel('Pixel Value (D.N.)','FontSize', 20);

ylim([min_y2 max_y2])

title(plot_title2);
set(gca, 'FontSize', 24);

% legend1 = legend({'with filter', 'without filter'});
% set(legend1, 'Location', 'best');

xticks(tMarkers);
tklabels = num2cell(tMarker_ticks);
fun = @(x) sprintf('%0.0f', x);
tklabels = cellfun(fun, tklabels, 'UniformOutput',0);
xticklabels(tklabels);

end
