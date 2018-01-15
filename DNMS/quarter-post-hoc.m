load('pir.mat')
d=pir.chr2.dnms.eachQuarter;
cidx=strcmp(d(:,6),'ChR2');
dd=d(cidx,:);
pq0=cell2mat(dd(1:5:end,2));
pq1=cell2mat(dd(2:5:end,2));
pq2=cell2mat(dd(3:5:end,2));
pq3=cell2mat(dd(4:5:end,2));
pq4=cell2mat(dd(5:5:end,2));
% doc ttest2
% doc ttest
[~,p,~,stats]=ttest(pq0,pq1);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);
[~,p,~,stats]=ttest(pq0,pq2);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);
[~,p,~,stats]=ttest(pq0,pq3);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);
[~,p,~,stats]=ttest(pq0,pq4);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);

fq0=cell2mat(dd(1:5:end,3));
fq1=cell2mat(dd(2:5:end,3));
fq2=cell2mat(dd(3:5:end,3));
fq3=cell2mat(dd(4:5:end,3));
fq4=cell2mat(dd(5:5:end,3));

[~,p,~,stats]=ttest(fq0,fq1);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);
[~,p,~,stats]=ttest(fq0,fq2);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);
[~,p,~,stats]=ttest(fq0,fq3);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);
[~,p,~,stats]=ttest(fq0,fq4);
fprintf('p = %.3e\tt(15) = %.3f\n',p,stats.tstat);
% 
% [~,p]=corrcoef(repmat(1:4,16,1),[pq1,pq2,pq3,pq4])
% [~,p]=corrcoef(repmat(1:3,16,1),[pq1,pq2,pq3])
% [~,p]=corrcoef(repmat(1:4,16,1),[fq1,fq2,fq3,fq4])
% [~,p]=corrcoef(repmat(1:3,16,1),[fq1,fq2,fq3])