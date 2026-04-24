%% s0_pain_setup.m
% Step 0 of the GCaMP-pain pipeline.
%
% Reads raw CMOS image files for a single recording session, removes
% electrical hum noise, and plots mean signals for visual inspection.
%
% Before running:
%   - Set DATA_FOLDER to the name of the folder (inside data/) containing
%     the raw .raw files for this session.
%   - Set x_size and y_size to match the CMOS sensor pixel array dimensions.
%   - Set inj_start, inj_end (injection period frame indices) and
%     start_mark (time-zero frame index).
%
% Workspace outputs:
%   data_raw      - Raw pixel data (x × y × t) for the full sensor
%   data_denoise1 - Hum-corrected data for the CeA sensor region
%   data_denoise2 - Hum-corrected data for the DRN sensor region
%
% Calls: f_read_pain, hum_removal, plot_mean


% Input size of pixel array
x_size = 44;
y_size = 242;

% 1a. Read files and trim matrix
TO_READ = 'y';
if exist('data_raw', 'var')
    TO_READ = input('Do you want to read new data? (y/n): ', 's');
end

% Read new data
if lower(TO_READ) == 'y'
%     DATA_FOLDER = input('What is the folder name? ', 's');
    DATA_FOLDER = 'E - NEW Pain experiment 1'
    data_folder = {DATA_FOLDER}; %% Input for GUI here
    
    [data_raw, all_image, bg_image, ...
        mean_bg_image, f0_id, fps] = f_read_pain(data_folder,x_size,y_size);
end

clear all_image bg_image

% 1b. Graph mean of raw data
data_raw1 = data_raw(4:40,7:119,:);
data_raw2 = data_raw(4:40,129:241,:);

mean_raw1 = squeeze(mean(data_raw1, [1 2],'omitnan'));
sem_raw1 = squeeze(std(data_raw1, 0, [1 2],'omitnan')) ./ sqrt(size(data_raw1, 1) * size(data_raw1,2));

mean_raw2 = squeeze(mean(data_raw2, [1 2],'omitnan'));
sem_raw2 = squeeze(std(data_raw2, 0, [1 2],'omitnan')) ./ sqrt(size(data_raw2, 1) * size(data_raw2,2));

min_y1 = prctile(data_raw1(:), 2.5);
max_y1 = prctile(data_raw1(:), 97.5);

min_y2 = prctile(data_raw2(:), 2.5);
max_y2 = prctile(data_raw2(:), 97.5);

inj_start = 7744; %start of injection period - GUI input here
inj_end = 8199; %end of injection period - GUI input here
start_mark = round((inj_start + inj_end)/2); %Assign frame as timepoint 0 - GUI input here

plot_title1 = 'Pain pre-analysis E - CeA';
plot_data1 = mean_raw1;
plot_sem1 = sem_raw1;

plot_title2 = 'Pain pre-analysis E - DRN';
plot_data2 = mean_raw2;
plot_sem2 = sem_raw2;

plot_mean(plot_data1, plot_sem1, plot_title1, min_y1, max_y1, plot_data2, plot_sem2, plot_title2, min_y2, max_y2, inj_start, inj_end, f0_id, start_mark, data_raw, fps)

% 1c. Remove hum noise

data_denoise1 = hum_removal(data_raw1);
data_denoise2 = hum_removal(data_raw2);

mean_denoise1 = squeeze(mean(data_denoise1, [1 2],'omitnan'));
sem_denoise1 = squeeze(std(data_denoise1, 0, [1 2],'omitnan')) ./ sqrt(size(data_denoise1, 1) * size(data_denoise1,2));

mean_denoise2 = squeeze(mean(data_denoise2, [1 2],'omitnan'));
sem_denoise2 = squeeze(std(data_denoise2, 0, [1 2],'omitnan')) ./ sqrt(size(data_denoise2, 1) * size(data_denoise2,2));

min_y1 = prctile(data_denoise1(:), 2.5);
max_y1 = prctile(data_denoise1(:), 97.5);

min_y2 = prctile(data_denoise2(:), 2.5);
max_y2 = prctile(data_denoise2(:), 97.5);

plot_title1 = 'Pain denoised E - CeA';
plot_data1 = mean_denoise1;
plot_sem1 = sem_denoise1;

plot_title2 = 'Pain denoised E - DRN';
plot_data2 = mean_denoise2;
plot_sem2 = sem_denoise2;

plot_mean(plot_data1, plot_sem1, plot_title1, min_y1, max_y1, plot_data2, plot_sem2, plot_title2, min_y2, max_y2, inj_start, inj_end, f0_id, start_mark, data_raw, fps)







