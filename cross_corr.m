close all
st = inj_end;
et = length(mean_adj1_ROI1);
cea{1} = mean_adj1_ROI1(st:et);%(start_mark:end);
cea{2} = mean_adj1_ROI2(st:et);%(start_mark:end);
cea{3} = mean_adj1_ROI3(st:et);%(start_mark:end);

cea_title{1} = 'ROI1 (CeA)';
cea_title{2} = 'ROI2 (CeA)';
cea_title{3} = 'ROI3 (CeA)';

drn{1} = mean_adj2_ROI1(st:et);%(start_mark:end);
drn{2} = mean_adj2_ROI2(st:et);%(start_mark:end);
drn{3} = mean_adj2_ROI3(st:et);%(start_mark:end);

drn_title{1} = 'ROI1 (DRN)';
drn_title{2} = 'ROI2 (DRN)';
drn_title{3} = 'ROI3 (DRN)';

ncea = 3;
ndrn = 3;
for i  = 1:ncea
    for j = 1:ndrn
        x = cea{i};
        y = drn{j};
        
        [c, lags] = xcorr(x, y, 'coeff');
        [~, loc] = max(c);
        max_lag = lags(loc);
        
        subplot(ncea, ndrn, ndrn*(j-1) + i)
        stem(lags,c)
        title({[cea_title{i}, ' vs ', drn_title{j}],...
            ['Best Lag: ', num2str(max_lag)],...
            ['\rho^2: ', num2str(max(c)^2)]} )
        ylabel('Cross-correlation w/ CeA');
        xlabel('Frame Shift of DRN data');
    end
end