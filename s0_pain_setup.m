%% This script prepares the data for preprocessing and analysis
%

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
    DATA_FOLDER = 'H - NEW Pain experiment PBS 1'
    data_folder = {DATA_FOLDER}; %% Input for GUI here
    
    [data_raw, all_image, bg_image, ...
        mean_bg_image, f0_id, fps] = f_read_pain(data_folder,x_size,y_size);
end


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

inj_start = 14365; %start of injection period - GUI input here
inj_end = 15145; %end of injection period - GUI input here
start_mark = round((inj_start + inj_end)/2); %Assign frame as timepoint 0 - GUI input here

plot_title1 = 'Pain pre-analysis H - CeA';
plot_data1 = mean_raw1;
plot_sem1 = sem_raw1;

plot_title2 = 'Pain pre-analysis H - DRN';
plot_data2 = mean_raw2;
plot_sem2 = sem_raw2;

plot_mean(plot_data1, plot_sem1, plot_title1, min_y1, max_y1, plot_data2, plot_sem2, plot_title2, min_y2, max_y2, inj_start, inj_end, f0_id, start_mark, data_raw, fps)