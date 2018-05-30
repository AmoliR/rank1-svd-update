%% FOR 5 TO 50

% clear;
% clc;
% 
%dimen = 5:5:55; % 5,10,15..,500. (100 matrices)
% itr = length(dimen); %(100 matrices)
% data_full = cell(itr,3);
% time_s = zeros(itr,1);
% time = zeros(itr,1);
% err_s = zeros(itr,1);
% err = zeros(itr,1);
% 
% for i = 1:itr
%     data_full{i,1} = rand(dimen(i),dimen(i)); % A = n x m original matrix
%     data_full{i,2} = rand(dimen(i),1); % a in R^m 
%     data_full{i,3} = rand(dimen(i),1); % b i R^n
%     
%     [err_s(i),time_s(i)] = s_SVDUrank1(data_full{i,1},data_full{i,2},data_full{i,3}); % stange
%     [err(i),time(i)] = SVDUrank1(data_full{i,1},data_full{i,2},data_full{i,3}); % our
% %     [time_s(i),U_s,S_s,V_s] = s_SVDUrank1(a,b,A); % stange
% %     [time(i),U_,S_,V_] = SVDUrank1(a,b,A); % our
%     
% end
% save('profile_data_full_svd.mat','data_full','time_s','time','err','err_s')
% 
% lbl = dimen;
% plot(lbl,time_s,'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl,time,'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl,time_s,'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl,time,'wo','MarkerFaceColor', 'r');
% 
% legend('Stange','FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel({'Run-time','(seconds)'})
% title('Runtime of Stange vs FMM-SVDU')
% 
% 
% figure
% lbl2 = dimen;
% plot(lbl2,err_s,'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl2,err,'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl2,err_s,'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl2,err,'wo','MarkerFaceColor', 'r');
% 
% legend('Stange','FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel('Error')
% title('Error of Stange vs FMM-SVDU')
% %% FOR 55 TO 100
% 
% dimen_h = 55:5:100; % 5,10,15..,500. (100 matrices)
% itr_h = length(dimen_h); %(100 matrices)
% data_full_h = cell(itr_h,3);
% %time_s = zeros(itr,1);
% time_h = zeros(itr_h,1);
% %err_s = zeros(itr,1);
% err_h = zeros(itr_h,1);
% 
% for i = 1:itr_h
%     data_full_h{i,1} = rand(dimen_h(i),dimen_h(i)); % A = n x m original matrix
%     data_full_h{i,2} = rand(dimen_h(i),1); % a in R^m 
%     data_full_h{i,3} = rand(dimen_h(i),1); % b i R^n
%     
%     %[err_s(i),time_s(i)] = s_SVDUrank1(data_full{i,1},data_full{i,2},data_full{i,3}); % stange
%     [err_h(i),time_h(i)] = SVDUrank1(data_full_h{i,1},data_full_h{i,2},data_full_h{i,3}); % our
% %     [time_s(i),U_s,S_s,V_s] = s_SVDUrank1(a,b,A); % stange
% %     [time(i),U_,S_,V_] = SVDUrank1(a,b,A); % our
%     
% end
% save('profile_data_full_svd_100.mat','data_full','time_s','time','err','err_s')
% 
% lbl_h = dimen_h;
% plot(lbl_h,time_s,'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl_h,time_h,'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl_h,time_s,'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl_h,time_h,'wo','MarkerFaceColor', 'r');
% 
% legend('Stange','FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel({'Run-time','(seconds)'})
% title('Runtime of Stange vs FMM-SVDU')
% 
% 
% figure
% lbl2_h = dimen_h;
% plot(lbl2_h,err_s,'--','LineWidth',1.5,'color','b');
% hold on;
% plot(lbl2_h,err_h,'LineWidth',1.5,'color','r');
% hold on;
% plot(lbl2_h,err_s,'wo','MarkerFaceColor', 'b');
% hold on;
% plot(lbl2_h,err_h,'wo','MarkerFaceColor', 'r');
% 
% legend('Stange','FMM-SVDU','Location','northwest')
% xlabel('Number of Samples (n)')
% ylabel('Error')
% title('Error of Stange vs FMM-SVDU')

%% Error for varying p (2,4,...,20) and fix dimension 25 x 25
load('profile_data_full_svd.mat');
p = 2:2:20;
A = data_full{5,1};
a = data_full{5,2};
b = data_full{5,3};
time_p = zeros(length(p),1);
err_p = zeros(length(p),1);

for i = 1:length(p)
    [err_p(i),time_p(i)] = SVDUrank1(A,a,b,p(i)); % 25 x 25
    
end
save('profile_data_full_p.mat','A','a','b','time_p','err_p')

lbl_h = p;
plot(lbl_h,time_p,'--','LineWidth',1.5,'color','r');
hold on;
plot(lbl_h,time_p,'wo','MarkerFaceColor', 'r');

legend('FMM-SVDU','Location','northwest')
xlabel('polynomial order(p)')
ylabel({'Run-time','(seconds)'})
title('Runtime of FMM-SVDU for varying p')


figure
lbl2_h = p;
plot(lbl2_h,err_p,'--','LineWidth',1.5,'color','r');
hold on;
plot(lbl2_h,err_p,'wo','MarkerFaceColor', 'r');

legend('FMM-SVDU','Location','northwest')
xlabel('polynomial order(p)')
ylabel('Error')
title('Error of FMM-SVDU for varying p')

