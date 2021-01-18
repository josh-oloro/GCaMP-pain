function data_denoise = hum_removal(data)

ave1 = mean(data, 1);
ave2 = repmat(mean(ave1), 1, size(data,2),1);
ave3 = repmat(ave1 - ave2, size(data, 1), 1, 1);

data_denoise = data - ave3;

end
