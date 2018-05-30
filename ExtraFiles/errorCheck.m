%load('workspace_i_equal_21_matlab.mat')
%   t_s = s_SVDUrank1(data_{21,1},data_{21,2},data_{21,3}); % stange
%   t = SVDUrank1(data_{i,1},data_{i,2},data_{i,3}); % our

%% printing result of saved 21 data 

lbl = 1:(20);
plot(lbl,time_s_(1:20),'--','LineWidth',1.5,'color','b');
hold on;
plot(lbl,time_(1:20),'LineWidth',1.5,'color','r');
xlabel('Number of Samples (n)')
ylabel({'Excecution time','(seconds)'})
legend('Stange','Adaptive FMM','Location','northwest')

%% with stange improved
% itr_ = 20;
% time_s_ = zeros(itr_,1);
% time_ = zeros(itr_,1);
% 
% for i = 2:itr_
%     time_s_(i) = s_SVDUrank1(data{i,1},data{i,2},data{i,3}); % stange
%     time_(i) = SVDUrank1(data{i,1},data{i,2},data{i,3}); % our
% %     [time_s(i),U_s,S_s,V_s] = s_SVDUrank1(a,b,A); % stange
% %     [time(i),U_,S_,V_] = SVDUrank1(a,b,A); % our
%     
% end