% close all
clearvars

load('crosscor')
nROI = 6;
% ROI_list = {'CeLC\newlineROI1', 'CeLC\newlineROI2', 'CeLC\newlineROI3',...
%     'DRN\newlineROI1', 'DRN\newlineROI2', 'DRN\newlineROI3'};
ROI_list_y = {'{\bf{CeLC}} ROI1', 'ROI2', 'ROI3',...
    '{\bf{DRN}} ROI1', 'ROI2', 'ROI3'};
ROI_list_x = {'ROI1', 'ROI2\newline\bf{CeLC}', 'ROI3',...
    'ROI1', 'ROI2\newline\bf{DRN}', 'ROI3'};
mouse_list = {'Formalin Mouse 1', 'Formalin Mouse 2',...
    'Formalin Mouse 3', 'Formalin Mouse 4', ...
    'PBS Mouse 1', 'PBS Mouse 2', 'PBS Mouse 3'};

f1 = figure( 'Units', 'normalized', 'Position', [0.1 0.25 1 0.6] );

for i = 1:7
    subplot(2,4,i)
    curlag = lagmat(:,:,i);
    currho = rhomat(:,:,i);
    imagesc(abs(currho), [0 1])
    
    set(gca, 'xtick', 1:nROI);
    set(gca, 'xticklabel', ROI_list_x);
    set(gca, 'ytick', 1:nROI);
    set(gca, 'yticklabel', ROI_list_y);
    title(mouse_list{i})
    set(gca, 'FontSize', 12)
    
    [x, y] = meshgrid(1:nROI, 1:nROI);
    textStrings = {};
    for ti = 1:numel(curlag)
        curstr = num2str(curlag(ti));
        if curstr == '0'
            curstr = '';
        end
        textStrings{ti} = curstr;
    end
    
    hStrings = text(x(:), y(:), textStrings(:),...
        'HorizontalAlignment', 'center', 'FontSize', 14);
    
end

subplot(2,4,8)
cb = colorbar;
cb.Position = [0.8251    0.1093    0.0139    0.3426];
axis off
set(gca, 'FontSize', 12)
title('| \rho |')