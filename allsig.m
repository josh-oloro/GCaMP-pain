sig_frame = zeros(1, size(aveMat2_adj, 3));
for fileInd = 1:size(aveMat2_adj, 3)
    vidMat1 = aveMat2_adj(:,:,fileInd);
    
    roi_x_s = 10;
    roi_x_e = 15;
    roi_y_s = 74;
    roi_y_e = 80;
    
    
    ROI = vidMat1(roi_x_s:roi_x_e, roi_y_s:roi_y_e);
    null_area = vidMat1;
    null_area(roi_x_s:roi_x_e, roi_y_s:roi_y_e) = nan;
    null_area_v = rmmissing(null_area(:));
    
    null_area_mean = mean(null_area_v(:));
    nullMat(fileInd) = null_area_mean;
    
    roi_mean = mean(ROI(:));
    roiMat(fileInd) = roi_mean;
    min_null = prctile(null_area_v, 2.5);
    max_null = prctile(null_area_v, 97.5);
    
    if roi_mean < min_null || roi_mean > max_null
        sig_frame(fileInd) = 1;
    end
    
end

minVal6 = prctile(roiMat(:), 2.5);
maxVal6 = prctile(roiMat(:), 97.5);

%get time markers
aveFrameTime = mean(frame_time);
fps = 1/aveFrameTime ;

convX = 60; %how many seconds to one interval?
everyTick = 10; %10 intervals of convX is one tick
tkmarkers = [1:size(all_normal_matrix,3)]; %gets number of frames into a 1D sequence
tkmarker_mins = tkmarkers./fps/convX; %equation for converting frames to desired time interval (convX)
[~,timepos] = min(abs(tkmarker_mins-1)); %gets the frame closest to one interval/ gets the number of frames for one interval
tMarkers = [1:timepos*everyTick:size(all_normal_matrix,3)]; %multiplies to number of intervals for each tick
tMarker_mins = tMarkers./fps/convX; %equation for converting frames to ticks

%%LINE PLOT
aveMat1_adj(aveMat1_adj <= minVal4) = minVal4;      %Any value <=minVal1 will be = minval1
aveMat1_adj(aveMat1_adj >= maxVal4) = maxVal4;

aveMat2_adj(aveMat2_adj <= minVal5) = minVal5;
aveMat2_adj(aveMat2_adj >= maxVal5) = maxVal5;

roiMat(roiMat <= minVal6) = minVal6;
roiMat(roiMat >= maxVal6) = maxVal6;

for fileInd = 1:newnumFile 
    %get matrix to plot
    curMat1 = aveMat1_adj(:,:, fileInd); %curMat gets the x,y of each frame
    mean_of_mat1(fileInd) = mean(curMat1(:)); %mean of mat gets the mean of x and y per curMat
    
    curMat2 = aveMat2_adj(:,:, fileInd); 
    mean_of_mat2(fileInd) = mean(curMat2(:)); 
end

figure 
% subplot (2,1,1)
plot(roiMat (1:end), '-')
title('Right device - single neuron')
ylabel('Ave. Pixel Value (D.N.)')
ylim([-0.1, 0.1])
 %X-axis frames to MINUTES
    xticks(tMarkers);
    tklabels = num2cell(tMarker_mins);
    fun = @(x) sprintf('%0.0f', x);
    tklabels = cellfun(fun, tklabels, 'UniformOutput',0);
    xticklabels(tklabels);
    xtickangle(90);
xlabel('Minutes')
hold on
plot(mean_of_mat2 (1:end), '-')
lgd = legend('single neuron (ROI)', 'whole frame');
lgd.Location = 'best';
%plot(norm_mat (1:end), '-')

%Code to active figure
for ijk = 8500:size(sig_frame,2)
    if sig_frame(ijk) == 1
        xline(ijk);
    end
end
