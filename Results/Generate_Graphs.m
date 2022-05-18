% This script generates graphs to compare the QoS among clouds and
% Portuguese operator. It generates graphs of bandwidth, jitter, delay and
% losses. It is possible to compare performance among OS as well once in
% the dataset there is the OS name.

path = 'results.csv';

dataset = readtable(path);

total = dataset(dataset.isp == "AS42863 MEO - SERVICOS DE COMUNICACOES E MULTIMEDIA S.A.",2:8)

% Check if there are missing data in the table. If there are, display it.
TF = ismissing(dataset,{'' '.' 'NA' NaN -99});
rowsWithMissing = dataset(any(TF,2),:);
disp(rowsWithMissing)
% If there are missing data, or complete it manually, or delete the rows
% with missing data!!!!

cloud_names = table2array(unique(dataset(:,"target")));
isp_names = table2array(unique(dataset(:,"isp")));
os_names = table2array(unique(dataset(:,"os")));


% Dataframe by clouds
dt_alibaba = dataset(dataset.target == "alibaba", 2:8);
dt_amazon = dataset(dataset.target == "amazon", 2:8);
dt_azure = dataset(dataset.target == "azure", 2:8);
dt_google = dataset(dataset.target == "google", 2:8);

% Let's reshape the dataframes to same dimensions!
n = size(dt_google);
z = size(dt_alibaba);

dt_alibaba(z(1):-1:n(1)+1,:) = [];
dt_amazon(z(1):-1:n(1)+1,:) = [];
dt_azure(z(1):-1:n(1)+1,:) = [];
%dt_google([z(1):-1:n(1)+1],:) = [];


[r,rn] = findgroups(dataset(:,1));
[c,cn] = findgroups(dataset(:,2));

% Max Upload
out = accumarray([r,c],dataset.upload,[],@max);
Max_Upload = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Mean Upload
out = accumarray([r,c],dataset.upload,[],@mean);
Mean_Upload = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Min Upload
out = accumarray([r,c],dataset.upload,[],@min);
Min_Upload = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Max Download
out = accumarray([r,c],dataset.download,[],@max);
Max_Download = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Mean Download
out = accumarray([r,c],dataset.download,[],@mean);
Mean_Download = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Min Download
out = accumarray([r,c],dataset.download,[],@min);
Min_Download = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Max Loss
out = accumarray([r,c],dataset.packet_loss,[],@max);
Max_Loss = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Mean Loss
out = accumarray([r,c],dataset.packet_loss,[],@mean);
Mean_Loss = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp)

% Min Loss
out = accumarray([r,c],dataset.packet_loss,[],@min);
Min_Loss = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Max Latency
out = accumarray([r,c],dataset.latency,[],@max);
Max_Latency = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Mean Latency
out = accumarray([r,c],dataset.latency,[],@mean);
Mean_Latency = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Min Latency
out = accumarray([r,c],dataset.latency,[],@min);
Min_Latency = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Max Jitter
out = accumarray([r,c],dataset.jitter,[],@max);
Max_Jitter = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Mean Jitter
out = accumarray([r,c],dataset.jitter,[],@mean);
Mean_Jitter = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);

% Min Jitter
out = accumarray([r,c],dataset.jitter,[],@min);
Min_Jitter = array2table(out,'RowNames',rn.target,'VariableNames',cn.isp);



% Plot graphs by clouds
figure(1)
boxplot([(dt_alibaba.latency),(dt_amazon.latency),(dt_azure.latency), (dt_google.latency)],'Notch','on','Labels',{'Alibaba','Amazon', 'Azure', 'Google'})
ax = gca;
ax.YAxis.Scale ="log";
ylabel('Latency ln(latency)')
title('LATENCY AMONG CLOUD PROVIDERS')
saveas(gcf,'Latency_cloud.png')

figure(2)
boxplot([(dt_alibaba.jitter),(dt_amazon.jitter),(dt_azure.jitter),(dt_google.jitter)],'Notch','on','Labels',{'Alibaba','Amazon', 'Azure', 'Google'})
ax = gca;
ax.YAxis.Scale ="log";
ylabel('Jitter ln(jitter)')
title('JITTER AMONG CLOUD PROVIDERS')
saveas(gcf,'Jitter_cloud.png')

figure(3)
boxplot([(dt_alibaba.packet_loss),(dt_amazon.packet_loss),(dt_azure.packet_loss), (dt_google.packet_loss)],'Notch','on','Labels',{'Alibaba','Amazon', 'Azure', 'Google'})
ylabel('Packet loss %')
title('PACKET LOSS AMONG CLOUD PROVIDERS')
saveas(gcf,'Loss_cloud.png')

% With outliers
figure(4)
boxplot([(dt_alibaba.download),(dt_amazon.download),(dt_azure.download), (dt_google.download)],'Notch','on','Labels',{'Alibaba','Amazon', 'Azure', 'Google'})
ylabel('Download (mbps)')
title('DOWNLOAD AMONG CLOUD PROVIDERS')
saveas(gcf,'Download_cloud.png')

% Without outliers
figure(5)
boxplot([(dt_alibaba.download),(dt_amazon.download),(dt_azure.download), (dt_google.download)],'symbol', '','Notch','on','Labels',{'Alibaba','Amazon', 'Azure', 'Google'})
ylabel('Download (mbps)')
title('DOWNLOAD AMONG CLOUD PROVIDERS - WITHOUT OUTLIERS')
saveas(gcf,'Download_cloud_without_outliers.png')

% With outliers
figure(6)
boxplot([(dt_alibaba.upload),(dt_amazon.upload),(dt_azure.upload), (dt_google.upload)],'Notch','on','Labels',{'Alibaba','Amazon', 'Azure', 'Google'})
ylabel('Upload (mbps)')
title('UPLOAD AMONG CLOUD PROVIDERS')
saveas(gcf,'Upload_cloud.png')

% Without outliers
figure(7)
boxplot([(dt_alibaba.upload),(dt_amazon.upload),(dt_azure.upload), (dt_google.upload)],'symbol', '','Notch','on','Labels',{'Alibaba','Amazon', 'Azure', 'Google'})
ylabel('Upload (mbps)')
title('UPLOAD AMONG CLOUD PROVIDERS - WITHOUT OUTLIERS')
saveas(gcf,'Upload_cloud_without_outliers.png')




% Dataframe by ISP
dt_AS12353 = table2array(dataset(dataset.isp == "AS12353 Vodafone Portugal - Communicacoes Pessoais S.A.", 4:8)); % Vodafone
dt_AS2860 = table2array(dataset(dataset.isp == "AS2860 NOS COMUNICACOES, S.A.", 4:8)); % NOS
dt_AS15525 = table2array(dataset(dataset.isp == "AS15525 MEO - SERVICOS DE COMUNICACOES E MULTIMEDIA S.A.", 4:8)); % MEO
dt_AS3243 = table2array(dataset(dataset.isp == "AS3243 MEO - SERVICOS DE COMUNICACOES E MULTIMEDIA S.A.", 4:8)); % MEO

grp = [zeros(1,length(dt_AS12353)), 1*ones(1,length(dt_AS2860)), 2*ones(1,length(dt_AS15525)), 3*ones(1,length(dt_AS3243))];
latency = [dt_AS12353(:,1)' dt_AS2860(:,1)' dt_AS15525(:,1)' dt_AS3243(:,1)'];
jitter = [dt_AS12353(:,2)' dt_AS2860(:,2)' dt_AS15525(:,2)' dt_AS3243(:,2)'];
loss = [dt_AS12353(:,3)' dt_AS2860(:,3)' dt_AS15525(:,3)' dt_AS3243(:,3)'];
download = [dt_AS12353(:,4)' dt_AS2860(:,4)' dt_AS15525(:,4)' dt_AS3243(:,4)'];
upload = [dt_AS12353(:,5)' dt_AS2860(:,5)' dt_AS15525(:,5)' dt_AS3243(:,5)'];

figure(8)
boxplot(latency,grp,'Notch','on','Labels',{'Vodafone (AS12353)', 'NOS (AS2860)', 'MEO (AS15525)', 'MEO (AS3243)'})
ax = gca;
ax.YAxis.Scale ="log";
ylabel('Latency ln(latency)')
title('LATENCY AMONG ISPs')
saveas(gcf,'Latency_isp.png')

figure(9)
boxplot(jitter,grp,'Notch','on','Labels',{'Vodafone (AS12353)', 'NOS (AS2860)', 'MEO (AS15525)', 'MEO (AS3243)'})
ax = gca;
ax.YAxis.Scale ="log";
ylabel('Jitter ln(jitter)')
title('JITTER AMONG ISPs')
saveas(gcf,'Jitter_isp.png')

figure(10)
boxplot(loss,grp,'Notch','on','Labels',{'Vodafone (AS12353)', 'NOS (AS2860)', 'MEO (AS15525)', 'MEO (AS3243)'})
ylabel('Packet loss %')
title('PACKET LOSS AMONG ISPs')
saveas(gcf,'Loss_isp.png')

figure(11)
boxplot(download,grp,'Notch','on','Labels',{'Vodafone (AS12353)', 'NOS (AS2860)', 'MEO (AS15525)', 'MEO (AS3243)'})
ylabel('Download (mbps)')
title('DOWNLOAD AMONG ISPs')
saveas(gcf,'Download_isp.png')

figure(12)
boxplot(upload,grp,'Notch','on','Labels',{'Vodafone (AS12353)', 'NOS (AS2860)', 'MEO (AS15525)', 'MEO (AS3243)'})
ylabel('UPLOAD mbps')
title('UPLOAD AMONG ISPs')
saveas(gcf,'Upload_isp.png')










