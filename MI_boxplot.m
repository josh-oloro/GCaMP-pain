close all
clearvars

fm = [0.128134569000000;0.0998009440000000;0.100726870000000;0.165736132000000;0.109549913000000;0.136143536000000;0.0928564990000000;0.146986132000000];
pm = [1.11022000000000e-16;1.11022000000000e-16;1.11022000000000e-16;1.11022000000000e-16;1.11022000000000e-16;1.11022000000000e-16];

g = [1,1,1,1,2,2,2,2,3,3,3,4,4,4];

h =  boxplot([fm; pm], g);
xticks([1.5, 3.5])
xticklabels({'Formalin', 'PBS'})

for ih=1:7
    set(h(ih,:),'LineWidth',3)
end
set(gca, 'FontSize', 16);

ylabel('MI')
ylim([-0.01 0.18]);
title('Mutual Information');
text(1,0.175,'a','FontSize',12,'FontWeight','bold','HorizontalAlignment','center');
text(2,0.16,'a','FontSize',12,'FontWeight','bold','HorizontalAlignment','center');
text(3,0.01,'b','FontSize',12,'FontWeight','bold','HorizontalAlignment','center');
text(4,0.01,'b','FontSize',12,'FontWeight','bold','HorizontalAlignment','center');

set(h(5,1:2),'Color',[0.7 0.3 0.9])
set(h(5,3:4),'Color',[0.9 0.4 0.1])

set(h(6,[1,3]),'Color',[0 0.4470 0.7410]) % set color of mean
set(h(6,[2,4]),'Color',[0.6350 0.0780 0.1840])

set(h(1:4,1:4),'Color',[0.5 0.5 0.5])

box_vars=findobj(gca,'Tag','Box');
box_vars(1).Color = [0 0.4470 0.7410];
box_vars(2).Color = [0.6350 0.0780 0.1840];
hLegend = legend(box_vars, {'CeLC','DRN'});