

%%Make boxplot

F1 = 0;	PBS1 = 10;
F2 = 0;	PBS2 = 4;
F3 = 0;	PBS3 = 8;
F4 = 2;	


lag1 = [F1, F2, F3, F4, PBS1, PBS2, PBS3];
g = [1, 1, 1, 1, 2, 2, 2];
h = boxplot(lag1, g);
for ih=1:7
    set(h(ih,:),'LineWidth',3)
end
set(gca, 'FontSize', 16);
xticklabels({'Formalin', 'PBS'})
ylabel('Count')
title('Number of frame lags above one');

set(h(5,1),'Color',[0.7 0.3 0.9])
set(h(5,2),'Color',[0.9 0.4 0.1])
set(h(6,1),'Color',[0 0 0]) % set color of mean
set(h(6,2),'Color',[0 0 0])
for w = 1:4 % set color of whiskers
set(h(w,1),'Color',[0.5 0.5 0.5])
set(h(w,2),'Color',[0.5 0.5 0.5])
end

yt = get(gca, 'YTick');
xt = get(gca, 'XTick');
hold on
plot(xt([1 2]), [0.95 0.95]*max(yt), '-k', 'LineWidth', 2)
plot(xt([1 1]), [0.92 0.95]*max(yt), '-k', 'LineWidth', 2)
plot(xt([2 2]), [0.92 0.95]*max(yt), '-k', 'LineWidth', 2)
plot(mean(xt([1 2]))-0.05, max(yt), '*k', 'MarkerSize', 9, 'LineWidth', 2)
plot(mean(xt([1 2]))+0.05, max(yt), '*k', 'MarkerSize', 9, 'LineWidth', 2)
hold off