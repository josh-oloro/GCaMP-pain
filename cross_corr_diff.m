% close all
%%
fps = 10.68;
%%
st = inj_end;
et = 60*60*fps + inj_end; %times 60 to convert to time
lagInMinute = 1;
lag = lagInMinute*60*fps;

CEA{1} = mean_adj1_ROI1(st:et);%(start_mark:end);
CEA{2} = mean_adj1_ROI2(st:et);%(start_mark:end);
CEA{3} = mean_adj1_ROI3(st:et);%(start_mark:end);
% CEA{1} = detrend(mean_adj1_ROI1(st:et));%(start_mark:end);
% CEA{2} = detrend(mean_adj1_ROI2(st:et));%(start_mark:end);
% CEA{3} = detrend(mean_adj1_ROI3(st:et));%(start_mark:end);

CEAL{1} = 'ROI1 (CeLC)';
CEAL{2} = 'ROI2 (CeLC)';
CEAL{3} = 'ROI3 (CeLC)';

DRN{1} = mean_adj2_ROI1(st:et);%(start_mark:end);
DRN{2} = mean_adj2_ROI2(st:et);%(start_mark:end);
DRN{3} = mean_adj2_ROI3(st:et);%(start_mark:end);
% DRN{1} = detrend(mean_adj2_ROI1(st:et));%(start_mark:end);
% DRN{2} = detrend(mean_adj2_ROI2(st:et));%(start_mark:end);
% DRN{3} = detrend(mean_adj2_ROI3(st:et));%(start_mark:end);

DRNL{1} = 'ROI1 (DRN)';
DRNL{2} = 'ROI2 (DRN)';
DRNL{3} = 'ROI3 (DRN)';

nCEA = 3;
nDRN = 3;

f3 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 1] );
nrow = 13;
ncol = 12;

titleM = 6:8;
titleH = {14:16, 18:20, 22:24};
titleV = {[25, 37, 49], [73,85,97], [121,133,145]};

initPlot = [26:28, 38:40, 50:52];
stemPlot = {initPlot, initPlot+4, initPlot+8;
    initPlot+48, initPlot+48+4, initPlot+48+8;
    initPlot+96, initPlot+96+4, initPlot+96+8};

aabest_lag_tab = (zeros(1,nCEA*nDRN));
aarho_tab = (zeros(1,nCEA*nDRN));

title_name = input('What is the title?: ', 's');
subplot(nrow, ncol, titleM)
 text(0.5, 0.5, title_name, 'FontSize', 20,...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'Bottom',...
     'fontweight', 'bold')
 axis off

for i  = 1:nCEA
    
%     adftest(CEA{i})
%     adftest(DRN{i})
    
    for j = 1:nDRN
        if i == 1
            subplot(nrow, ncol, titleH{j})
            text(0.5, 0.5, DRNL{j}, 'FontSize', 15,...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'Bottom',...
                'fontweight', 'bold')
            axis off
        end
        
        if j == 1
            subplot(nrow, ncol, titleV{i} )
            text(0, 0.5, CEAL{i}, 'FontSize', 15,...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'Middle',...
                'fontweight', 'bold', 'Rotation', 90)
            axis off
        end
        
        x = CEA{i};
        y = DRN{j};
        
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
            ['\rho: ', num2str(c(loc), '%0.4f')]},'FontSize',11)
        ylim ([-0.20,0.30]);
        ax = gca;
        ax.XAxis.FontSize = 10;
        ax.YAxis.FontSize = 10;
        xlabel('Shift in Minutes of DRN data','FontSize',11)
        ylabel('Cross-corr with CeA','FontSize',11)
       
        aabest_lag_tab(1,(i-1)*nDRN + j) = max_lag;
        aarho_tab(1,(i-1)*nDRN + j) = c(loc);
        
    end
end