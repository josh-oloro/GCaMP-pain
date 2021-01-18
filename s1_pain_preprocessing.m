%% compute for relative difference (Reference Frame subtraction)
ref_frame = 3110:6500;
ref_frame1 = mean(data_denoise1(:,:,ref_frame),3);
ref_frame2 = mean(data_denoise2(:,:,ref_frame),3);

data_adj1 = ((data_denoise1 - ref_frame1)./ref_frame1);
minVal1 = prctile(data_adj1(:), 2.5);
maxVal1 = prctile(data_adj1(:), 97.5);

data_adj2 = ((data_denoise2 - ref_frame2)./ref_frame2);
minVal2 = prctile(data_adj2(:), 2.5);
maxVal2 = prctile(data_adj2(:), 97.5);

newnumFile = size(data_raw, 3);    %counts number of files for the FOR loop later when getting sums/means

%Image code
sample_frame = 6942;

figure
subplot(1,2,1)
image1 = data_adj1(:,:,sample_frame);
image1 = rot90(image1);
imagesc(image1, [minVal1,maxVal1]);
set(gca,'XDir','reverse')
title(plot_title1, ['Frame ',num2str(sample_frame)])
colormap (jet);
colorbar

subplot(1,2,2)
image2 = data_adj2(:,:,sample_frame);
image2 = rot90(image2);
imagesc(image2, [minVal2,maxVal2]);
set(gca,'XDir','reverse')
title(plot_title2, ['Frame ',num2str(sample_frame)])
colormap (jet);
colorbar

%%Video code
MAKE_VIDEO = 'y';
MAKE_VIDEO = input('Do you want to make video? (y/n): ', 's');

% Read new data
if lower(MAKE_VIDEO) == 'y'
    VID_START = input('Starting from what frame is the video? ')
    VID_END = input('Ending at what frame is the video? ')
    figure
    vidFName = fullfile('Videos', 'TTTRIAL');
    v = VideoWriter(vidFName);
    open(v);

        for fileInd = VID_START:VID_END %Example of good frames > 6000:7000
            subplot (1,2,1)
            vid_mat1 = data_adj1(:,:,fileInd);
            vid_mat1 = rot90(vid_mat1);
            imagesc(vid_mat1, [minVal1,maxVal1]) %generates heatmap and makes it the 'active figure'
            set(gca,'XDir','reverse')
            title (['Frame No. ', num2str(fileInd)])
            colorbar
            axis off
            
            subplot (1,2,2)
             vid_mat2 = data_adj2(:,:,fileInd);
            vid_mat2 = rot90(vid_mat2);
            imagesc(vid_mat2, [minVal2,maxVal2]) %generates heatmap and makes it the 'active figure'
            set(gca,'XDir','reverse')
            colorbar
            axis off
%             % add time stamp
%             if fileInd == 1 || fileInd == newnumFile || mod(fileInd, hrmarker) == 0
%                 time_stamp = ['Time Elapsed: ', num2str((fileInd / fps )/3600), ' hrs'];
%                 delete(findall(gcf,'type','annotation'));
%                 annotation('textbox', [0.45 0.02 0.2 0.05], 'String',time_stamp, 'FitBoxToText','on');
%             end
            
            F = getframe(gcf); %gcf gets the active figure as a frame for the video
            writeVideo(v,F)

        end
    
%     close(v);

else
end

%% Line plot code

mean_adj1 = squeeze(mean(data_adj1, [1 2],'omitnan'));
sem_adj1 = squeeze(std(data_adj1, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj1, 1) * size(data_adj1,2));

mean_adj2 = squeeze(mean(data_adj2, [1 2],'omitnan'));
sem_adj2 = squeeze(std(data_adj2, 0, [1 2],'omitnan')) ./ sqrt(size(data_adj2, 1) * size(data_adj2,2));

plot_title1 = ['E - Pain \Delta F/F - CeA'];
plot_data1 = mean_adj1;
plot_sem1 = sem_adj1;

plot_title2 = ['E - Pain \Delta F/F - DRN'];
plot_data2 = mean_adj2;
plot_sem2 = sem_adj2;

min_y1 = minVal1;
max_y1 = maxVal1;

min_y2 = minVal2;
max_y2 = maxVal2;

plot_mean(plot_data1, plot_sem1, plot_title1, min_y1, max_y1, plot_data2, plot_sem2, plot_title2, min_y2, max_y2, inj_start, inj_end, f0_id, start_mark, data_raw, fps)

%% Save variables

proj_path = fileparts(mfilename('fullpath'));
data_path = fullfile(proj_path, 'data');                % set data path relative to location of this code
mat_path = fullfile(proj_path, 'mat');                  % set .mat files path relative to location of this code
trial_fldr = data_folder;
mat_name = 'E_Pain_adj';
mat_file1 = fullfile(mat_path, [mat_name, '.mat']);
save(mat_file1, 'data_folder', 'data_adj1', 'data_adj2', 'mean_raw1', 'sem_raw1', 'mean_raw2', 'sem_raw2','mean_adj1','sem_adj1','mean_adj2','sem_adj2', 'plot_title1', 'plot_title2', 'minVal1', 'maxVal1', 'minVal2', 'maxVal2','inj_start', 'inj_end', 'f0_id', 'start_mark', 'fps', 'sample_frame')