function [data_adj, data_det] = test_adjust(data,start_adj,end_adj,nan_idx,seg)

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