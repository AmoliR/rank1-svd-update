% BASED ON DATA PROFILE_FINAL.MAT
figure
lbl = dimen(1:7);
plot(lbl,time_s(1:7),'--','LineWidth',1.5,'color','b');
hold on;
plot(lbl,time(1:7),'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl,time_s(1:7),'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl,time(1:7),'wo','MarkerFaceColor', 'r');

legend('FAST','Adaptive FMM','Location','northwest')
xlabel('Number of Samples (n)')
ylabel({'Run-time','(seconds)'})
title('Runtime of FAST vs FMM')

hold on;
e = 5^-10;
%n = linspace(0,35);
n= 5:5:35;
y1 = (n).*((log(n)).^2); %stange
% y1 = ((n).*((log(n)).^2))./(n+10).^2;
y2 = (n).*(log(1/e));%FMM
% y2 = n;
plot(n,y1,'--','LineWidth',1.5,'color','y')
hold on;
plot(n,y2,'LineWidth',1.5,'color','k')
% xlabel('Number of Samples (n)')
% ylabel('Asymptotic Complexity')
% legend('n log^2(n) FAST','n log(1/\epsilon) FMM','Location','northwest')

%plot(dimen(1:7)',time_s(1:7),'o')
hold on;
p3 = polyfit(dimen(1:7)',time_s(1:7),2);
x1 = 5:5:35;
f = polyval(p3,x1);
plot(x1,f,'g--')

%figure
%plot(dimen(1:7)',time(1:7),'o')
hold on;
p4 = polyfit(dimen(1:7)',time(1:7),2);
x2 = 5:5:35;
f1 = polyval(p4,x2);
plot(x2,f1,'m--')
