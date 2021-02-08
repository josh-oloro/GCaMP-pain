clearvars

data = {'L_Pain_adj_ROI.mat', 'M_Pain_adj_ROI.mat',...
    'N_Pain_adj_ROI.mat', 'O_Pain_adj_ROI.mat',...
    'P_Pain_adj_ROI.mat', 'Q_Pain_adj_ROI.mat', 'R_Pain_adj_ROI.mat'};
lick_i = [1:4, 1:3];
f = zeros(1, numel(data));

for data_i = 1:numel(data)
    clearvars -except data lick_i f data_i
    load(data{data_i});
    load('BehaviorTally.mat');
    
    conv_x = 60;
    tkmarkers = [1:size(mean_adj1_ROI1, 1)] - start_mark;
    tkmarker_mins = tkmarkers./fps/conv_x;
    inj_start_min = (inj_start-start_mark)./fps/conv_x;
    inj_end_min = (inj_end-start_mark)./fps/conv_x;
    pl_mean1 = plot(tkmarker_mins, mean_adj1_ROI1, 'LineWidth', 3);
    clc
    clearvars -except tkmarker_mins mean_adj1_ROI1 BehTime Formalin PBS...
        data lick_i f data_i
    close all
    
    t_roi = tkmarker_mins;
    roi = mean_adj1_ROI1;
    
    if data_i <= 4
        lick = Formalin(:,lick_i(data_i));
    else
        lick = PBS(:,lick_i(data_i));
    end
    
    t_lick = BehTime + 2.5;
    
    roi_bin = zeros(size(t_lick));
    for ti = 1:size(t_lick, 1)
        st = t_lick(ti);
        try
            et = t_lick(ti+1);
        catch
            et = t_lick(ti)+2.5;
        end
        roi_bin(ti) = mean(roi( t_roi >= st & t_roi <= et));
    end
    [f(data_i), ~] = discrete_continuous_info_fast(lick, roi_bin);
end