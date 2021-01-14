

diff_aveMat1 = all_normal_matrix(4:40,7:119,:);
diff_aveMat2 = all_normal_matrix(4:40,129:241,:);

%% compute for relative difference (Reference Frame subtraction)
ref_frame = 3110:6500;
ref_frame1 = mean(diff_aveMat1(:,:,ref_frame),3);
ref_frame2 = mean(diff_aveMat2(:,:,ref_frame),3);

aveMat1_adj = ((diff_aveMat1 - ref_frame1)./ref_frame1);
minVal4 = prctile(aveMat1_adj(:), 2.5);
maxVal4 = prctile(aveMat1_adj(:), 97.5);

aveMat2_adj = ((diff_aveMat2 - ref_frame2)./ref_frame2);
minVal5 = prctile(aveMat2_adj(:), 2.5);
maxVal5 = prctile(aveMat2_adj(:), 97.5);

newnumFile = size(all_normal_matrix, 3);    %counts number of files for the FOR loop later when getting sums/means

%%Image code
figure 
subplot(1,2,1)
imagesc(aveMat1_adj(:,:,6948), [minVal4,maxVal4]);
colormap (jet);
subplot(1,2,2)
imagesc(aveMat2_adj(:,:,6948), [minVal5,maxVal5]);
colormap (jet);

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

%%VIDEO CODE
 figure
    vidFName = fullfile('Videos', 'Trial4.avi');
%     v = VideoWriter(vidFName);
%     open(v);

        for fileInd = 6000:7000
            vidMat1 = aveMat1_adj(:,:,fileInd); 
            imagesc(vidMat1, [minVal4, maxVal4]) %generates heatmap and makes it the 'active figure'
            title (['Frame No. ', num2str(fileInd)])
            colorbar
            axis off
            
%             % add time stamp
%             if fileInd == 1 || fileInd == newnumFile || mod(fileInd, hrmarker) == 0
%                 time_stamp = ['Time Elapsed: ', num2str((fileInd / fps )/3600), ' hrs'];
%                 delete(findall(gcf,'type','annotation'));
%                 annotation('textbox', [0.45 0.02 0.2 0.05], 'String',time_stamp, 'FitBoxToText','on');
%             end
            
%             F = getframe(gcf); %gcf gets the active figure as a frame for the video
%             writeVideo(v,F)

        end
    
%     close(v);
    
%%LINE PLOT
aveMat1_adj(aveMat1_adj <= minVal4) = minVal4;      %Any value <=minVal1 will be = minval1
aveMat1_adj(aveMat1_adj >= maxVal4) = maxVal4;

aveMat2_adj(aveMat2_adj <= minVal5) = minVal5;
aveMat2_adj(aveMat2_adj >= maxVal5) = maxVal5;

for fileInd = 1:newnumFile 
    %get matrix to plot
    curMat1 = aveMat1_adj(:,:, fileInd); %curMat gets the x,y of each frame
    mean_of_mat1(fileInd) = mean(curMat1(:)); %mean of mat gets the mean of x and y per curMat
    
    curMat2 = aveMat2_adj(:,:, fileInd); 
    mean_of_mat2(fileInd) = mean(curMat2(:)); 
end

figure 
subplot (2,1,1)
plot(mean_of_mat1 (1:end), '-')
title('Double implantation Device 1')
 %X-axis frames to MINUTES
    xticks(tMarkers);
    tklabels = num2cell(tMarker_mins);
    fun = @(x) sprintf('%0.0f', x);
    tklabels = cellfun(fun, tklabels, 'UniformOutput',0);
    xticklabels(tklabels);
    xtickangle(90); 
xlabel('Minutes')
ylabel('Ave. Pixel Value (D.N.)')

subplot (2,1,2)
plot (mean_of_mat2 (1:end), 'r-')
title('Double implantation Device 2')
xlabel('Frame No.')
ylabel('Ave. Pixel Value (D.N.)')
 %X-axis frames to MINUTES
    xticks(tMarkers);
    tklabels = num2cell(tMarker_mins);
    fun = @(x) sprintf('%0.0f', x);
    tklabels = cellfun(fun, tklabels, 'UniformOutput',0);
    xticklabels(tklabels);
    xtickangle(90);
xlabel('Minutes')
ylabel('Ave. Pixel Value (D.N.)')    

%%For plotting all pixels in one device
figure
for ri = 1:size(curMat1, 1)
    for ci = 1:size(curMat1, 2)
      plot(squeeze(aveMat1_adj(ri,ci,:)))  
      hold on
    end
end
title('All Pixels - Device 1')
saveas(gcf,'All_Pixels_Device_1.png')


%%SINGLE NEURON?

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

%%LINE PLOT
aveMat1_adj(aveMat1_adj <= minVal4) = minVal4;      %Any value <=minVal1 will be = minval1
aveMat1_adj(aveMat1_adj >= maxVal4) = maxVal4;

% aveMat2 = diff_aveMat2;
% aveMat2(aveMat2 <= minVal2) = minVal2;
% aveMat2(aveMat2 >= maxVal2) = maxVal2;

for fileInd = 1:newnumFile 
    %get matrix to plot
    curMat2 = aveMat2_adj(:,:, fileInd); %curMat gets the x,y of each frame
    mean_of_mat2(fileInd) = mean(curMat2(:)); %mean of mat gets the mean of x and y per curMat
    
%     curMat2 = aveMat2(:,:, fileInd); 
%     mean_of_mat2(fileInd) = mean(curMat2(:)); 
end

figure 
% subplot (2,1,1)
plot(mean_of_mat2 (1:end), '-b')
title('Right device - single neuron')
xlabel('Frame No.')
ylabel('Ave. Pixel Value (D.N.)')
hold on
plot(mean_of_mat1 (1:end), '-r')

norm_mat = mean_of_mat2 - mean_of_mat1; %Single neuron minus whole frame
figure
plot(norm_mat (1:end), '-g')
title('Right device - single neuron')
xlabel('Frame No.')
ylabel('Ave. Pixel Value (D.N.)')

figure 
% subplot (2,1,1)
plot(mean_of_mat2 (1:end), '-')
title('Right device - single neuron')
xlabel('Frame No.')
ylabel('Ave. Pixel Value (D.N.)')
hold on
plot(mean_of_mat1 (1:end), '-')
plot(norm_mat (1:end), '-')