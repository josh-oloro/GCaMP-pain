% close all
%%
fps = 10.68;
%%
st = inj_end;
et = 60*60*fps + inj_end; %times 60 to convert to time

lagInMinute = 1;
lag = lagInMinute*60*fps;


bregion = input('Enter brain region (CEA/DRN): ', 's');

switch bregion
    
    case 'CEA'
        
        CEA{1} = mean_adj1_ROI1(st:et);%(start_mark:end);
        CEA{2} = mean_adj1_ROI2(st:et);%(start_mark:end);
        CEA{3} = mean_adj1_ROI3(st:et);%(start_mark:end);
        % CEA{1} = detrend(mean_adj1_ROI1(st:et));%(start_mark:end);
        % CEA{2} = detrend(mean_adj1_ROI2(st:et));%(start_mark:end);
        % CEA{3} = detrend(mean_adj1_ROI3(st:et));%(start_mark:end);

        CEAL{1} = 'ROI1 (CeA)';
        CEAL{2} = 'ROI2 (CeA)';
        CEAL{3} = 'ROI3 (CeA)';

        CEA2{1} = mean_adj1_ROI1(st:et);%(start_mark:end); 
        CEA2{2} = mean_adj1_ROI2(st:et);%(start_mark:end);
        CEA2{3} = mean_adj1_ROI3(st:et);%(start_mark:end);
        % CEA2{1} = detrend(mean_adj1_ROI1(st:et));%(start_mark:end);
        % CEA2{2} = detrend(mean_adj1_ROI2(st:et));%(start_mark:end);
        % CEA2{3} = detrend(mean_adj1_ROI3(st:et));%(start_mark:end);

        CEA2L{1} = 'ROI1 (CeA)';
        CEA2L{2} = 'ROI2 (CeA)';
        CEA2L{3} = 'ROI3 (CeA)';
        
    case 'DRN'
        
        CEA{1} = mean_adj2_ROI1(st:et);%(start_mark:end);
        CEA{2} = mean_adj2_ROI2(st:et);%(start_mark:end);
        CEA{3} = mean_adj2_ROI3(st:et);%(start_mark:end);
        % CEA{1} = detrend(mean_adj2_ROI1(st:et));%(start_mark:end);
        % CEA{2} = detrend(mean_adj2_ROI2(st:et));%(start_mark:end);
        % CEA{3} = detrend(mean_adj2_ROI3(st:et));%(start_mark:end);

        CEAL{1} = 'ROI1 (DRN)';
        CEAL{2} = 'ROI2 (DRN)';
        CEAL{3} = 'ROI3 (DRN)';

        CEA2{1} = mean_adj2_ROI1(st:et);%(start_mark:end); 
        CEA2{2} = mean_adj2_ROI2(st:et);%(start_mark:end);
        CEA2{3} = mean_adj2_ROI3(st:et);%(start_mark:end);
        % CEA2{1} = detrend(mean_adj2_ROI1(st:et));%(start_mark:end);
        % CEA2{2} = detrend(mean_adj2_ROI2(st:et));%(start_mark:end);
        % CEA2{3} = detrend(mean_adj2_ROI3(st:et));%(start_mark:end);

        CEA2L{1} = 'ROI1 (DRN)';
        CEA2L{2} = 'ROI2 (DRN)';
        CEA2L{3} = 'ROI3 (DRN)';
end

n1 = 3;
n2 = 3;

f3 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 1] );
nrow = 12;
ncol = 12;

titleH = {2:4, 6:8, 10:12};
titleV = {[13, 25, 37], [61,73,85], [109,121,133]};

initPlot = [14:16, 26:28, 38:40];
stemPlot = {initPlot, initPlot+4, initPlot+8;
    initPlot+48, initPlot+48+4, initPlot+48+8;
    initPlot+96, initPlot+96+4, initPlot+96+8};

aabest_lag_tab = (zeros(1,n1*n2));
aarho_tab = (zeros(1,n1*n2));

for i  = 1:n1
    for j = 1:n2
        if i == 1
            subplot(nrow, ncol, titleH{j})
            text(0.5, 0.5, CEA2L{j}, 'FontSize', 20,...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'Bottom',...
                'fontweight', 'bold')
            axis off
        end
        
        if j == 1
            subplot(nrow, ncol, titleV{i} )
            text(0, 0.5, CEAL{i}, 'FontSize', 20,...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'Middle',...
                'fontweight', 'bold', 'Rotation', 90)
            axis off
        end
        
        x = CEA{i};
        y = CEA2{j};
        
%           [c, lags] = xcorr(x, y, round(lag), 'coeff');
        [c, lags] = xcorr(diff(x), diff(y), round(lag), 'coeff');
%         [c, lags] = parcorr(y);
        [~, loc] = max(abs(c));
        max_lag = lags(loc);
        max_lag_sec = max_lag / fps;
        lags = lags./fps/60;
        subplot(nrow, ncol, stemPlot{i, j} )
        line(lags,c)
        title({['Best Lag: ', num2str(max_lag), ' frames (',...
            num2str(max_lag_sec, '%0.3f'), ' sec)'],...
            ['\rho: ', num2str(c(loc), '%0.4f')]} )
        xlabel('Shift in Minutes of DRN data')
        ylabel('Cross-corr with CeA')
        
        aabest_lag_tab(1,(i-1)*n1 + j) = max_lag;
        aarho_tab(1,(i-1)*n1 + j) = c(loc);
        
    end
end