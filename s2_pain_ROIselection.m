%% TODO: remove offset in signals (spikes)
% Get mean through time per pixel
% Substract mean (offset)

%%%%%%%%%%%%%%%%%%
% % FOR SETTING SOME FRAMES AS NAN - nan_idx: index (time) of samples to set as NaN

% nan_idx1 = [1:343, 14320:14700];
% nan_idx2 = [16521:16605, 18377:18956, 26904:26931];
% nan_idx3 = [39779:40091];
% nan_idx = [nan_idx1, nan_idx2, nan_idx3];

% % Set offset frames as NaN values
% fprintf('-- Setting some frames to NaN...\n')
% data_raw(:, :, nan_idx)= NaN;
% 
% % Adjust offset by subtracting the mean of each segment
% [data_adj1, data_det1] = test_adjust(data_raw,1,16520,nan_idx1, '1');
% [data_adj2, data_det2] = test_adjust(data_raw,16521,39778,nan_idx2, '2');
% [data_adj3, data_det3]= test_adjust(data_raw,39779,86955,nan_idx3, '3');
% data_adj_all = cat(3,data_adj1,data_adj2,data_adj3);
% 
% mean_of_adj = squeeze(mean(data_adj_all, [1 2],'omitnan'));
% sem_of_adj = squeeze(std(data_adj_all, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_all, 1) * size(data_adj_all,2));
% 
% data_det_all = cat(1,data_det1, data_det2, data_det3);
%%%%%%%%%%%%%%%%%%%%%%

%Assign ROIs manually from data_adj_all (not detrended)

data_adj_ROI1 = data_adj_all(3:10,78:85,:);
data_adj_ROI2 = data_adj_all(6:9,72:79,:);

data_adj_ROI5 = data_adj_all(9:16,62:69,:);
data_adj_ROI6 = data_adj_all(33:40,62:69,:);
data_adj_ROI7 = data_adj_all(19:26,39:46,:);
data_adj_ROI8 = data_adj_all(35:42,48:55,:);

data_adj_ROI12 = data_adj_all(36:43,4:11,:);

% Assign background manually by setting ROIs as nan

data_adj_bg = data_adj_all(:,:,:);
data_adj_bg(2:11,77:86,:) = nan;
data_adj_bg(5:10,71:80,:)= nan;
data_adj_bg(8:17,61:70,:) = nan;
data_adj_bg(32:41,61:70,:) = nan;
data_adj_bg(18:27,38:47,:) = nan;
data_adj_bg(34:43,47:56,:) = nan;
data_adj_bg(34:43,3:12,:) = nan;

% Get mean and sem of ROIs

mean_adj_ROI1 = squeeze(mean(data_adj_ROI1, [1 2],'omitnan'));
%sem_adj_ROI1 = squeeze(std(data_adj_ROI1, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI1, 1) * size(data_adj_ROI1,2));
sem_adj_ROI1 = squeeze(std(data_adj_ROI1, 0, [1 2],'omitnan')) ./ sqrt( numel(data_adj_ROI1) ); %<- same as above, less cluttered lang / more readable haha

mean_adj_ROI2 = squeeze(mean(data_adj_ROI2, [1 2],'omitnan'));
sem_adj_ROI2 = squeeze(std(data_adj_ROI2, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI2, 1) * size(data_adj_ROI2,2));

mean_adj_ROI5 = squeeze(mean(data_adj_ROI5, [1 2],'omitnan'));
sem_adj_ROI5 = squeeze(std(data_adj_ROI5, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI5, 1) * size(data_adj_ROI5,2));

mean_adj_ROI6 = squeeze(mean(data_adj_ROI6, [1 2],'omitnan'));
sem_adj_ROI6 = squeeze(std(data_adj_ROI6, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI6, 1) * size(data_adj_ROI6,2));

mean_adj_ROI7 = squeeze(mean(data_adj_ROI7, [1 2],'omitnan'));
sem_adj_ROI7 = squeeze(std(data_adj_ROI7, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI7, 1) * size(data_adj_ROI7,2));

mean_adj_ROI8 = squeeze(mean(data_adj_ROI8, [1 2],'omitnan'));
sem_adj_ROI8 = squeeze(std(data_adj_ROI8, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI8, 1) * size(data_adj_ROI8,2));

mean_adj_ROI12 = squeeze(mean(data_adj_ROI12, [1 2],'omitnan'));
sem_adj_ROI12 = squeeze(std(data_adj_ROI12, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_ROI12, 1) * size(data_adj_ROI12,2));

mean_adj_bg = squeeze(mean(data_adj_bg, [1 2],'omitnan'));
sem_adj_bg = squeeze(std(data_adj_bg, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj_bg, 1) * size(data_adj_bg,2));

% return

%% Plot whole frame offset adjusted

plot_title = 'Offset adjusted';

min_y = -300;
max_y = 400;

inj_start = 18380; %start of injection period
inj_end = 18930; %end of injection period
start_mark = 18712; %Assign frame as timepoint 0

plot_data = mean_of_adj;
plot_sem = sem_of_adj;

plot_mean(plot_data, plot_sem, min_y, max_y, inj_start, inj_end, plot_title, f0_id, start_mark, data_raw, fps);

%% Plot ROI1 offset adjusted

plot_title = 'Offset adjusted (ROI1)';

min_y = -300;
max_y = 400;

inj_start = 18380; %start of injection period
inj_end = 18930; %end of injection period
start_mark = 18712; %Assign frame as timepoint 0

plot_data = mean_adj_ROI1;
plot_sem = sem_adj_ROI1;

plot_mean(plot_data, plot_sem, min_y, max_y, inj_start, inj_end, plot_title, f0_id, start_mark, data_raw, fps);


%%
plot_title = 'Detrended';

min_y = -100;
max_y = 250;

inj_start = 18380; %start of injection period
inj_end = 18930; %end of injection period
start_mark = 18712; %Assign frame as timepoint 0

plot_data = data_det_all;
plot_sem = [];

plot_mean(plot_data, plot_sem, min_y, max_y, inj_start, inj_end, plot_title, f0_id, start_mark, data_raw, fps);

