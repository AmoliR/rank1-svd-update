%load('profile_data_full_svd.mat');
%% PLOT runtime of svdu-fmm(full update) for dim till 55 x 55(ev computed directly)
% dimen = 5:5:55;
% lbl = dimen;
% plot(lbl,time,'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl,time,'wo','MarkerFaceColor', 'r');
% 
% legend('FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel({'Run-time','(seconds)'})
% title('Runtime of FMM-SVDU')

%% PLOT error of svdu-fmm(full update) for dim till 55 x 55(ev computed directly)
% figure
% lbl2 = dimen;
% plot(lbl2,err,'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl2,err,'wo','MarkerFaceColor', 'r');
% legend('FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel('Error')
% title('Error of FMM-SVDU')

%% PLOT runtime of svdu-fmm vs stange(full update) for dim till 50 x 50(ev computed directly)
%figure
% lbl = 5:5:50;
% plot(lbl,time_s(1:10),'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl,time(1:10),'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl,time_s(1:10),'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl,time(1:10),'wo','MarkerFaceColor', 'r');
% 
% legend('Stange','FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel({'Run-time','(seconds)'})
% title('Runtime of Stange vs FMM-SVDU')

%% PLOT error of svdu-fmm vs stange (full update) for dim till 25 x 25(ev computed directly)
%figure;
% lbl = 5:5:25;
% plot(lbl,err_s(1:5),'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl,err(1:5),'LineWidth',0.8,'color','r');
% hold on;
% plot(lbl,err_s(1:5),'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl,err(1:5),'wo','MarkerFaceColor', 'r');
% 
% legend('Stange','FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel('Error')
% title('Error of Stange vs FMM-SVDU')


%% Compute Error for varying p (2,4,...,20) and fix dimension 25 x 25
% load('profile_data_full_svd.mat');
% p = 2:2:20;
% A = data_full{5,1};
% a = data_full{5,2};
% b = data_full{5,3};
% time_p = zeros(length(p),1);
% err_p = zeros(length(p),1);
% 
% for i = 1:length(p)
%     [err_p(i),time_p(i)] = SVDUrank1(A,a,b,p(i)); % 25 x 25
%     
% end
% save('profile_data_full_p.mat','A','a','b','time_p','err_p')

%% plot run-time vs p for FMM-svdu for varying p (2,4,..20)
load('profile_data_full_p.mat')
figure
lbl_h = p;
plot(lbl_h,time_p,'--','LineWidth',1.5,'color','r');
hold on;
plot(lbl_h,time_p,'wo','MarkerFaceColor', 'r');

legend('FMM-SVDU','Location','northwest')
xlabel('polynomial order(p)')
ylabel({'Run-time','(seconds)'})
title('Runtime of FMM-SVDU for varying p')

%% plot error vs p for FMM-svdu for varying p (2,4,..20)

figure
lbl2_h = p;
plot(lbl2_h,err_p,'--','LineWidth',1.5,'color','r');
hold on;
plot(lbl2_h,err_p,'wo','MarkerFaceColor', 'r');

legend('FMM-SVDU','Location','northwest')
xlabel('polynomial order(p)')
ylabel('Error')
title('Error of FMM-SVDU for varying p')
