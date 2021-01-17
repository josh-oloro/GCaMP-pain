%% Image code with ROI
sample_frame = 6942;

figure
subplot(1,2,1)
image1 = data_adj1(:,:,sample_frame);
image1 = rot90(image1);
imagesc(flipud(image1), [minVal1,maxVal1]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([A_ROI1_xe A_ROI1_xs A_ROI1_xs A_ROI1_xe A_ROI1_xe],[A_ROI1_ye A_ROI1_ye A_ROI1_ys A_ROI1_ys A_ROI1_ye],'r')
text((A_ROI1_xe+A_ROI1_xs)/2, A_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([A_ROI2_xe A_ROI2_xs A_ROI2_xs A_ROI2_xe A_ROI2_xe],[A_ROI2_ye A_ROI2_ye A_ROI2_ys A_ROI2_ys A_ROI2_ye],'r')
text((A_ROI2_xe+A_ROI2_xs)/2, A_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([A_ROI3_xe A_ROI3_xs A_ROI3_xs A_ROI3_xe A_ROI3_xe],[A_ROI3_ye A_ROI3_ye A_ROI3_ys A_ROI3_ys A_ROI3_ye],'r')
text((A_ROI3_xe+A_ROI3_xs)/2, A_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title(plot_title1, ['Frame ',num2str(sample_frame)])
colormap (jet);
colorbar

subplot(1,2,2)
image2 = data_adj2(:,:,sample_frame);
image2 = rot90(image2);
imagesc(flipud(image2), [minVal2,maxVal2]);
set(gca,'XDir','reverse','YDir','normal')
hold on
plot([B_ROI1_xe B_ROI1_xs B_ROI1_xs B_ROI1_xe B_ROI1_xe],[B_ROI1_ye B_ROI1_ye B_ROI1_ys B_ROI1_ys B_ROI1_ye],'r')
text((B_ROI1_xe+B_ROI1_xs)/2, B_ROI1_ye+1, '1','FontSize',8, 'Color', 'r');
plot([B_ROI2_xe B_ROI2_xs B_ROI2_xs B_ROI2_xe B_ROI2_xe],[B_ROI2_ye B_ROI2_ye B_ROI2_ys B_ROI2_ys B_ROI2_ye],'r')
text((B_ROI2_xe+B_ROI2_xs)/2, B_ROI2_ye+1, '2','FontSize',8, 'Color', 'r');
plot([B_ROI3_xe B_ROI3_xs B_ROI3_xs B_ROI3_xe B_ROI3_xe],[B_ROI3_ye B_ROI3_ye B_ROI3_ys B_ROI3_ys B_ROI3_ye],'r')
text((B_ROI3_xe+B_ROI3_xs)/2, B_ROI3_ye+1, '3','FontSize',8, 'Color', 'r');
title(plot_title2, ['Frame ',num2str(sample_frame)])
colormap (jet);
colorbar
