function [data_raw, all_image, bg_image, mean_bg_image,...
          f0_id, fps] = f_read_pain(data_folder, x_size, y_size)
% F_READ_DATA Read raw data files from data_fldr
%   data_raw = F_READ_DATA(data_fldr)
% 
% Input
% data_fldr : folder name containing raw image files
% 
% Output
% data_raw  : trimmed samples; m x n x t matrix
%             m trimmed image height, n trimmed image width, t time samples
% 
% all_image : original samples; m' x n' x t matrix
%             m' orig image height, n' orig image width, t time samples
% 
% bg_image  : background image; m' x n' matrix
%             m' orig image height, n' orig image width 
% 
% mean_bg_image : mean of bg_image; float
%                
% f0_id : frame indices of start of recording; array
% 
% fps : frame rate; float
% 

fprintf('#################################\n');
fprintf('          Reading data           \n');
fprintf('#################################\n\n');

%% Set folder paths
proj_path = fileparts(mfilename('fullpath'));
data_path = fullfile(proj_path, 'data');                % set data path relative to location of this code
mat_path = fullfile(proj_path, 'mat');                % set .mat files path relative to location of this code


%% Loop through each raw file
    n_trial = 1;

    for file_i = 1:n_trial
        f0_id = [];
        trial_fldr = data_folder{file_i};                      % current folder containing all sample files for same trial
        fprintf('- Processing %s\n', trial_fldr);
        mat_file = fullfile(mat_path, [trial_fldr, '.mat']); % file_name of .mat file - fullfile generates/goes to the path
        % fprintf(mat_file);
        
        % Default rewrite flag: yes         
        TO_REWRITE = 'y';
        
        % Ask to load existing .mat variables or rewrite
        if exist(mat_file, 'file')
          TO_REWRITE = input('-- MAT file exists. Want to rewrite? (y/n): ', 's');
        end
        
        % Do not rewrite existing .mat
        if lower(TO_REWRITE) ~= 'y'
            fprintf('-- Loading %s\n', mat_file)
            working_mat = load(mat_file);
            fps = working_mat.fps;
            
            data_raw = working_mat.data_raw;
            all_image = working_mat.all_image;
            
            bg_image = working_mat.bg_image;
            mean_bg_image = working_mat.mean_bg_image;
            
            f0_id = working_mat.f0_id;
        
        % Rewrite / read new files
        else
            fprintf('-- Reading new files\n')
            rec_list = dir(fullfile(data_path,'*.raw')); % lists the files that follow .raw format
            
            [~,index] = sortrows({rec_list.name}.');
            rec_list = rec_list(index);
            
            % clear index
            num_rec = size(rec_list, 1); % num_file is the number of raw files
            frame_start = 1;               % counter for all frames in file (start of current file)

            for rec_ind = 1:num_rec                                       % to execute this command from file 1 up to the end
                rec_filename = rec_list(rec_ind).name;                    % raw data recording file
                fprintf('--- %s\n', rec_filename)
                                
                fid = fopen(fullfile(data_path, rec_filename)); % opens each file
                f = dir(fullfile(data_path, rec_filename));     % gets properties of each file
                
                % assigned variables
                ii = 0;
                d = [0 0 1024];

%                 % size of pixel array
%                 x_size = 44;
%                 y_size = 242;
%  Input pixel array size in s1

                %% Read image data
                while(ii==0 || d(3) == 1024)
                    if(ii ~= 0) % for the next file (~= means NOT)
                        clear imageData normalImage pixdata normalImageAVG range_sel % clears the ff variables to make room for the next one
                        fid = fopen(deblank(transpose(next_filename)));              % please replace with your raw data filename
                        f = dir(deblank(transpose(next_filename)));
                    end
                    
                    % Read header & background image data
                    software_version  = fread(fid, 32, '*char');
                    current_filename  = fread(fid, 128, '*char');
                    previous_filename = fread(fid, 128, '*char');
                    next_filename     = fread(fid, 128, '*char');
                    chip_no           = fread(fid, 1, '*int32');
                    clock_multi       = fread(fid, 1, '*int32');
                    settling_clocks   = fread(fid, 1, '*int32');
                    start_frameno     = fread(fid, 1, '*int32');
                    frame_time        = fread(fid, 1, '*float', 27*4);               % skip 27*4 bytes after reading

                    bg_image  = fread(fid, [x_size, y_size], 'ushort');              % background (dark) image for fixed pattern noise (FPN) reduction
                    frames_in_file = (f.bytes-17824)/(x_size*y_size*2+97);           % 17824 is the length of header & bgimage data.

                    for i=1:frames_in_file                                           % readable data size at once depends on your PC
                        frame_no     = fread(fid, 1, '*uint32', 15*4);               %!! in the data saved by old version, frame no is corrupted
                        triggers     = fread(fid, 1, '*uint8',  8*4);
                        image_data(:, :, i)   = fread(fid, [x_size, y_size], 'ushort');
                        normal_image(:, :, i) = bg_image - image_data(:, :, i);         % normal image is the difference between Raw image data and Background image.
                        %range_sel(:, :, i) = normalImage(xsel1:xsel2, ysel1:ysel2, i); % select only the pixel data from the region of interest
                    end

                    ii = ii+1;
                    fclose(fid);

                    d = size(image_data);
                end

                % counter for all frames in a file (end)
                frame_end = frame_start + size(normal_image, 3) - 1;

                % added variables
                frame_time_list(rec_ind) = frame_time;
                ave_frame_time = mean(frame_time_list);
                fps = 1/ave_frame_time;
                mean_bg_image = mean(bg_image, 'all');
                all_image(:, :, frame_start:frame_end) = image_data;
                all_normal_matrix(:, :, frame_start:frame_end) = normal_image;

                % Prelim Figure 5 - imagesc for frames that have "Frame0" names
                if strfind(rec_filename,'Frame0-')
                    f0_id = [f0_id, frame_start];
                end

                % counter for all frames in file (start of next file)
                frame_start = frame_end + 1;
            end
            
            % Sample pixel
            pixel_x = 25; 
            pixel_y = 27;

            fprintf('-- Trimming matrices for %s...\n', trial_fldr)

            data_raw = all_normal_matrix;
            

            % Save variables             
            fprintf('-- Saving variables as mat file...\n')
            mat_file = fullfile(mat_path, [trial_fldr, '.mat']);
            save(mat_file, 'data_raw', 'fps', 'f0_id', 'all_image', ...
                           'mean_bg_image', 'bg_image', ...
                           '-v7.3')
        
            fprintf('-- Total raw recordings: %d\n\n', num_rec)
        end
end
