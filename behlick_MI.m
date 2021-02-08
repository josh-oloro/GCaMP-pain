clearvars

data = {'L_Pain_adj_ROI.mat', 'M_Pain_adj_ROI.mat',...
    'N_Pain_adj_ROI.mat', 'O_Pain_adj_ROI.mat',...
    'P_Pain_adj_ROI.mat', 'Q_Pain_adj_ROI.mat', 'R_Pain_adj_ROI.mat'};
lick_i = [1:4, 1:3];
f = [];

for data_i = 1:numel(data)
    clearvars -except data lick_i f data_i
    load(data{data_i});
    load('BehaviorTally.mat');
    
    conv_x = 60;
    tkmarkers = [1:size(mean_adj1_ROI1, 1)] - start_mark;
    tkmarker_mins = tkmarkers./fps/conv_x;
    
    all_ROI = [mean_adj1, mean_adj2];
    
    clearvars -except tkmarker_mins BehTime Formalin PBS...
        data lick_i f data_i all_ROI
    
    if data_i <= 4
        lick = Formalin(:,lick_i(data_i));
    else
        lick = PBS(:,lick_i(data_i));
    end
    
    t_roi = tkmarker_mins;
    t_lick = BehTime + 2.5;
    roi_bin = zeros(size(t_lick));
    
    for ri = 1:size(all_ROI, 1);
        roi = all_ROI(ri,:);
        
        for ti = 1:size(t_lick, 1)
            st = t_lick(ti);
            try
                et = t_lick(ti+1);
            catch
                et = t_lick(ti)+2.5;
            end
            roi_bin(ti) = mean(roi( t_roi >= st & t_roi <= et));
        end
        [f(ri, data_i), ~] = discrete_continuous_info_fast(lick, roi_bin);
    end
end

plot(f, 'o')