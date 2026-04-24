function data_denoise = hum_removal(data)
% HUM_REMOVAL Remove electrical hum noise from imaging data.
%
% data_denoise = HUM_REMOVAL(data) subtracts column-wise spatial variation
% from each frame to suppress periodic electrical noise (hum). The noise
% estimate is the column mean across pixels minus the grand mean, replicated
% across all rows.
%
% Input
%   data        : x × y × t array of pixel values (x rows, y columns, t frames)
%
% Output
%   data_denoise : denoised array of the same size as data

ave1 = mean(data, 1);
ave2 = repmat(mean(ave1), 1, size(data,2),1);
ave3 = repmat(ave1 - ave2, size(data, 1), 1, 1);

data_denoise = data - ave3;

end
