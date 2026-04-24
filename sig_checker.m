%% sig_checker.m
% Video-based significance checking: ROI vs background histogram per frame.
%
% Iterates over a range of frames, compares the mean ROI pixel value against
% the 2.5–97.5 percentile range of non-ROI background pixels, and exports a
% side-by-side video of the ΔF/F heatmap and a background histogram with
% the ROI mean marked.
%
% Requires in the workspace (from s1_pain_preprocessing.m or equivalent):
%   aveMat2_adj   - ΔF/F array for the brain region of interest
%   all_normal_matrix - Raw data (used for total frame count)
%   minVal4, maxVal4  - Color scale limits
%   fps, newnumFile   - Frame rate and total frame count
%
% Configure:
%   roi_x_s/e, roi_y_s/e - ROI pixel coordinate ranges
%   fileInd range (6000:7000) - Frames to process
%   vidFName - Output video file path


convX = 1; %how many seconds to one interval?
everyTick = 10; %10 intervals of convX is one tick
tkmarkers = [1:size(all_normal_matrix,3)]; %gets number of frames into a 1D sequence
tkmarker_mins = tkmarkers./fps/convX; %equation for converting frames to desired time interval (convX)
[~,timepos] = min(abs(tkmarker_mins-1));

sig_frame = zeros(1, 7000);

vidFName = fullfile('Videos', 'Histogram_s3.avi');
v = VideoWriter(vidFName);
open(v);

edges = linspace(minVal4, maxVal4, 21); %fixes x-axis, 21-1 bars

for fileInd = 6000:7000
    vidMat1 = aveMat2_adj(:,:,fileInd);
    
    roi_x_s = 10;
    roi_x_e = 15;
    roi_y_s = 74;
    roi_y_e = 80;
    
    
    ROI = vidMat1(roi_x_s:roi_x_e, roi_y_s:roi_y_e);
    null_area = vidMat1;
    null_area(roi_x_s:roi_x_e, roi_y_s:roi_y_e) = nan;
    null_area_v = rmmissing(null_area(:));
    
    roi_mean = mean(ROI(:));
    min_null = prctile(null_area_v, 2.5);
    max_null = prctile(null_area_v, 97.5);
    
    if roi_mean < min_null || roi_mean > max_null
        sig_frame(fileInd) = 1;
    end
    
    subplot(1,2,1)
    annotation(figure1,'line',[0.3500 0.3500], [0.7212 0.6156], 'LineWidth',5, 'color', 'r');
    annotation(figure1,'line',[0.3200 0.3200], [0.7212 0.6156], 'LineWidth',5, 'color', 'r');
    annotation(figure1,'line',[0.3200 0.3500], [0.7212 0.7212], 'LineWidth',5, 'color', 'r');
    annotation(figure1,'line',[0.3200 0.3500], [0.6156 0.6156], 'LineWidth',5, 'color', 'r');
    imagesc((vidMat1),[minVal4, maxVal4]); %generates heatmap and makes it the 'active figure'
    colormap (jet);
    colorbar
    
    subplot(1,2,2)
    histogram(null_area_v, 'BinEdges', edges, 'normalization', 'pdf') %generates heatmap and makes it the 'active figure'
    xline(roi_mean, 'LineWidth', 3, 'LineStyle', '-', 'color', 'r');
    xline(min_null, 'LineWidth', 3, 'LineStyle', '--', 'color', 'k');
    xline(max_null, 'LineWidth', 3, 'LineStyle', '--', 'color', 'k');
    ylim([0, 100])
    %set(gca, 'ytick', [])
    xlabel('Normalized Pixel Value (D.N.)')
    
    sgtitle(['Frame No. ', num2str(fileInd)])
    
    % add time stamp
    if fileInd == 1 || fileInd == newnumFile || mod(fileInd, timepos) == 0
        time_stamp = ['Time Elapsed: ', num2str(round((fileInd / fps ) / convX)), ' seconds'];
        delete(findall(gcf,'type','annotation'));
        annotation('textbox', [0.45 0.02 0.2 0.05], 'String',time_stamp, 'FitBoxToText','on');
    end
    
    F = getframe(gcf); %gcf gets the active figure as a frame for the video
    writeVideo(v,F)
    
end

close(v)
