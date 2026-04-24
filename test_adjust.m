function [data_adj, data_det] = test_adjust(data, start_adj, end_adj, nan_idx, seg)
% TEST_ADJUST Subtract segment mean and detrend a data segment.
%
% [data_adj, data_det] = TEST_ADJUST(data, start_adj, end_adj, nan_idx, seg)
% extracts the slice data(:,:,start_adj:end_adj), sets frames in nan_idx to
% NaN, subtracts the spatial mean (per pixel, averaged over non-NaN frames),
% and computes a polynomial detrend of the resulting spatially-averaged signal.
%
% Input
%   data      : x × y × t pixel array
%   start_adj : first frame index of the segment to process
%   end_adj   : last frame index of the segment to process
%   nan_idx   : global frame indices to set as NaN within the segment
%   seg       : segment label string (used only in commented-out plot titles)
%
% Output
%   data_adj  : mean-subtracted segment (x × y × (end_adj-start_adj+1))
%   data_det  : detrended spatially-averaged signal for the segment (1D vector)

    data_seg = data(:,:,start_adj:end_adj);
    data_mean = squeeze(mean(data_seg,3,'omitnan'));
  
  
    nan_idx = nan_idx - start_adj+1;
    data_adj = data_seg;   
    for i = 1:size(data_seg,3)
        %     size(data(:,:,i))
        %     size(data_mean)
        if ismember(i,nan_idx)
            %continue
            data_adj(:,:,i) = NaN;
        else
            data_adj(:,:,i) = data_seg(:,:,i) - data_mean; %for element-wise subtraction
        end
    end
    
%     size(data_adj)

   %Detrend values
    
    data_mean2 = squeeze(mean(data_seg,[1 2],'omitnan'));
%     size(data_mean2)
    
    data_mean_adj = squeeze(mean(data_adj,[1 2]));
    
    data_det = detrend(data_mean_adj,4,'omitnan');
    
 %Plot original and adjusted segment
%     figure;
%     plot(data_det,'g');
%     hold on
%     plot(data_mean2,'r');
%     plot(data_mean_adj,'b');
%     title(strcat('Segment ', num2str(seg)));
%     hold off

   
       
end