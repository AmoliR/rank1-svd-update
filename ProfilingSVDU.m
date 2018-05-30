%% GENERATING RANDOM DATA AND PLOTTING COMPARATIVE RESULTS OF FAST Vs FMM s
% clear;
% clc;

% Randomly generate 35 x 35 matrixs
dimen = 5:5:35; % 5,10,15..,500. (100 matrices)
itr = length(dimen); %(100 matrices)
data = cell(itr,3);
time_s = zeros(itr,1);
time = zeros(itr,1);


for i = 1:itr
    data{i,1} = randi([1 9],dimen(i),dimen(i)); % A = n x m original matrix
    data{i,2} = randi([1 9],dimen(i),1); % a in R^m 
    data{i,3} = randi([1 9],dimen(i),1); % b i R^n
    [time_s(i),U_s,S_s,V_s] = s_SVDUrank1(data{i,1},data{i,2},data{i,3});%SVDU
    [time(i),U_,S_,V_] = SVDUrank1(data{i,1},data{i,2},data{i,3}); %FMM-SVDU
    % ---options
    % time_s(i) = s_SVDUrank1(data{i,1},data{i,2},data{i,3}); % SVDU
    % time(i) = SVDUrank1(data{i,1},data{i,2},data{i,3}); % FMM-SVDU
end
% save('profile_data_direct.mat','data','time_s','time')

% lbl = dimen;
% plot(lbl,time_s,'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl,time,'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl,time_s,'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl,time,'wo','MarkerFaceColor', 'r');
% 
% legend('FAST','Adaptive FMM','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel({'Run-time','(seconds)'})
% title('Runtime of FAST vs FMM')

% hold off;
% e = 5^-10;
% n = linspace(0,10000);
% y1 = (n).*((log(n)).^2);
% y2 = (n).*(log(1/e));
% figure
% plot(n,y1,'--','LineWidth',1.5,'color','g')
% hold on;
% plot(n,y2,'LineWidth',1.5,'color','r')
% xlabel('Number of Samples (n)')
% ylabel('Asymptotic Complexity')
% legend('n log^2(n) FAST','n log(1/\epsilon) FMM','Location','northwest')

% lbl = 2:(itr+1);
% plot(lbl,time_s,'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl,time,'LineWidth',1.5,'color','r');
% xlabel('Number of Samples (n)')
% ylabel({'Excecution time','(seconds)'})
% legend('Stange','Adaptive FMM-SVDU','Location','northwest')
% title('Runtime of Stange vs FMM-SVDU')


% BASED ON DATA PROFILE_FINAL.MAT
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
n= 5:5:1000;
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
p1 = polyfit(dimen(1:7)',time_s(1:7),2);
x1 = 5:5:1000;
f = polyval(p1,x1);
plot(x1,f,'g--')

%figure
%plot(dimen(1:7)',time(1:7),'o')
hold on;
p2 = polyfit(dimen(1:7)',time(1:7),2);
x2 = 5:5:1000;
f1 = polyval(p2,x2);
plot(x2,f1,'m--')
