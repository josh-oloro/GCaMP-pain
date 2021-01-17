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

clearvars
load('E_Pain_adj')

%Assign ROIs manually from data_adj_all (not detrended)

A_ROI1_xs = 10; A_ROI1_xe = 14; A_ROI1_ys = 73; A_ROI1_ye = 80;
A_ROI2_xs = 19; A_ROI2_xe = 23; A_ROI2_ys = 87; A_ROI2_ye = 92;
A_ROI3_xs = 33; A_ROI3_xe = 35; A_ROI3_ys = 75; A_ROI3_ye = 81;

data_adj1_ROI1 = data_adj1(A_ROI1_xs:A_ROI1_xe,A_ROI1_ys:A_ROI1_ye,:);
data_adj1_ROI2 = data_adj1(A_ROI2_xs:A_ROI2_xe,A_ROI2_ys:A_ROI2_ye,:);
data_adj1_ROI3 = data_adj1(A_ROI3_xs:A_ROI3_xe,A_ROI3_ys:A_ROI3_ye,:);


B_ROI1_xs = 10; B_ROI1_xe = 15; B_ROI1_ys = 74; B_ROI1_ye = 80;
B_ROI2_xs = 19; B_ROI2_xe = 23; B_ROI2_ys = 87; B_ROI2_ye = 92;
B_ROI3_xs = 33; B_ROI3_xe = 35; B_ROI3_ys = 75; B_ROI3_ye = 81;

data_adj2_ROI1 = data_adj2(B_ROI1_xs:B_ROI1_xe,B_ROI1_ys:B_ROI1_ye,:);
data_adj2_ROI2 = data_adj2(B_ROI2_xs:B_ROI2_xe,B_ROI2_ys:B_ROI2_ye,:);
data_adj2_ROI3 = data_adj2(B_ROI3_xs:B_ROI3_xe,B_ROI3_ys:B_ROI3_ye,:);
%Note: x and y of matrix is y and x in imagesc

% Assign background manually by setting ROIs as nan

data_adj1_bg = data_adj1(:,:,:);
data_adj1_bg([A_ROI1_xs-2]:[A_ROI1_xe+2],[A_ROI1_ys-2]:[A_ROI1_ye+2],:) = nan;
data_adj1_bg([A_ROI2_xs-2]:[A_ROI2_xe+2],[A_ROI2_ys-2]:[A_ROI2_ye+2],:)= nan;
data_adj1_bg([A_ROI3_xs-2]:[A_ROI3_xe+2],[A_ROI3_ys-2]:[A_ROI3_ye+2],:) = nan;

data_adj2_bg = data_adj2(:,:,:);
data_adj2_bg([B_ROI1_xs-2]:[B_ROI1_xe+2],[B_ROI1_ys-2]:[B_ROI1_ye+2],:) = nan;
data_adj2_bg([B_ROI2_xs-2]:[B_ROI2_xe+2],[B_ROI2_ys-2]:[B_ROI2_ye+2],:)= nan;
data_adj2_bg([B_ROI3_xs-2]:[B_ROI3_xe+2],[B_ROI3_ys-2]:[B_ROI3_ye+2],:) = nan;

% Get mean and sem of ROIs

mean_adj1_ROI1 = squeeze(mean(data_adj1_ROI1, [1 2],'omitnan'));
sem_adj1_ROI1 = squeeze(std(data_adj1_ROI1, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj1_ROI1, 1) * size(data_adj1_ROI1,2));

mean_adj1_ROI2 = squeeze(mean(data_adj1_ROI2, [1 2],'omitnan'));
sem_adj1_ROI2 = squeeze(std(data_adj1_ROI2, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj1_ROI2, 1) * size(data_adj1_ROI2,2));

mean_adj1_ROI3 = squeeze(mean(data_adj1_ROI3, [1 2],'omitnan'));
sem_adj1_ROI3 = squeeze(std(data_adj1_ROI3, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj1_ROI3, 1) * size(data_adj1_ROI3,2));


mean_adj2_ROI1 = squeeze(mean(data_adj2_ROI1, [1 2],'omitnan'));
sem_adj2_ROI1 = squeeze(std(data_adj2_ROI1, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj2_ROI1, 1) * size(data_adj2_ROI1,2));

mean_adj2_ROI2 = squeeze(mean(data_adj2_ROI2, [1 2],'omitnan'));
sem_adj2_ROI2 = squeeze(std(data_adj2_ROI2, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj2_ROI2, 1) * size(data_adj2_ROI2,2));

mean_adj2_ROI3 = squeeze(mean(data_adj2_ROI3, [1 2],'omitnan'));
sem_adj2_ROI3 = squeeze(std(data_adj2_ROI3, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj2_ROI3, 1) * size(data_adj2_ROI3,2));


mean_adj1_bg = squeeze(mean(data_adj1_bg, [1 2],'omitnan'));
sem_adj1_bg = squeeze(std(data_adj1_bg, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj1_bg, 1) * size(data_adj1_bg,2));

mean_adj2_bg = squeeze(mean(data_adj2_bg, [1 2],'omitnan'));
sem_adj2_bg = squeeze(std(data_adj2_bg, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj2_bg, 1) * size(data_adj2_bg,2));

% return

% %% Plot whole frame offset adjusted
% 
% plot_title = 'Offset adjusted';
% 
% min_y = -300;
% max_y = 400;
% 
% % inj_start = 7744; %start of injection period - GUI input here
% % inj_end = 8199; %end of injection period - GUI input here
% % start_mark = round((inj_start + inj_end)/2); %Assign frame as timepoint 0 - GUI input here
% 
% plot_data = mean_of_adj;
% plot_sem = sem_of_adj;
% 
% plot_mean(plot_data, plot_sem, min_y, max_y, inj_start, inj_end, plot_title, f0_id, start_mark, data_raw, fps);

%% Plot ROI1 offset adjusted

% plot_title = 'Offset adjusted (ROI1)';
% 
% min_y = -300;
% max_y = 400;
% 
% % inj_start = 7744; %start of injection period - GUI input here
% % inj_end = 8199; %end of injection period - GUI input here
% % start_mark = round((inj_start + inj_end)/2); %Assign frame as timepoint 0 - GUI input here
% 
% plot_data = mean_adj_ROI1;
% plot_sem = sem_adj_ROI1;
% 
% plot_mean(plot_data, plot_sem, min_y, max_y, inj_start, inj_end, plot_title, f0_id, start_mark, data_raw, fps);
% 

%% Plot detrended

% plot_title = 'Detrended';
% 
% min_y = -100;
% max_y = 250;
% 
% % inj_start = 7744; %start of injection period - GUI input here
% % inj_end = 8199; %end of injection period - GUI input here
% % start_mark = round((inj_start + inj_end)/2); %Assign frame as timepoint 0 - GUI input here
% 
% plot_data = data_det_all;
% plot_sem = [];
% 
% plot_mean(plot_data, plot_sem, min_y, max_y, inj_start, inj_end, plot_title, f0_id, start_mark, data_raw, fps);

%% Image code with ROI
sample_frame1 = 6942;
sample_frame2 = 6942;

figure
subplot(1,2,1)
image1 = data_adj1(:,:,sample_frame1);
imagesc(flipud(rot90(image1)), [minVal1,maxVal1]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],[A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],[A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],[A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title(plot_title1, ['Frame ',num2str(sample_frame1)])
colormap (jet);
colorbar

subplot(1,2,2)
image2 = data_adj2(:,:,sample_frame2);
imagesc(flipud(rot90(image2)), [minVal2,maxVal2]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],[B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],[B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],[B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title(plot_title2, ['Frame ',num2str(sample_frame2)])
colormap (jet);
colorbar

%% Save variables

proj_path = fileparts(mfilename('fullpath'));
data_path = fullfile(proj_path, 'data');                % set data path relative to location of this code
mat_path = fullfile(proj_path, 'mat');                  % set .mat files path relative to location of this code
trial_fldr = data_folder;
mat_name = 'E_Pain_adj_ROI';
mat_file2 = fullfile(mat_path, [mat_name, '.mat']);
save(mat_file2, 'plot_title1', 'plot_title2', 'minVal1', 'maxVal1', 'minVal2', 'maxVal2','inj_start', 'inj_end', 'f0_id', 'start_mark', 'fps', 'sample_frame1', 'sample_frame2', 'image1', 'image2',...
    'mean_adj1_ROI1', 'sem_adj1_ROI1', 'mean_adj1_ROI2', 'sem_adj1_ROI2', 'mean_adj1_ROI3', 'sem_adj1_ROI3', 'mean_adj2_ROI1', 'sem_adj2_ROI1', 'mean_adj2_ROI2', 'sem_adj2_ROI2', 'mean_adj2_ROI3', 'sem_adj2_ROI3', 'mean_adj1_bg', 'sem_adj1_bg', 'mean_adj2_bg', 'sem_adj2_bg', ...
    'A_ROI1_xe', 'A_ROI1_xs', 'A_ROI1_ye', 'A_ROI1_ys','A_ROI2_xe','A_ROI2_xs','A_ROI2_ye', 'A_ROI2_ys', 'A_ROI3_xe', 'A_ROI3_xs', 'A_ROI3_ye', 'A_ROI3_ys', 'B_ROI1_xe', 'B_ROI1_xs', 'B_ROI1_ye', 'B_ROI1_ys', 'B_ROI2_xe', 'B_ROI2_xs', 'B_ROI2_ye', 'B_ROI2_ys', 'B_ROI3_xe', 'B_ROI3_xs', 'B_ROI3_ye', 'B_ROI3_ys');