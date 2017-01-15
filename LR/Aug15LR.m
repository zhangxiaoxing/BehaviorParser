mice=[31 35 38 40 43 45 1096 1146];
perf=nan(8,10);
hitRate=nan(8,10);
bias=nan(8,10);

for m=1:length(mice)
    fl=z.listFiles({['V' num2str(mice(m))],'-NoTeach','DNMS'});
    for f=1:length(fl)
        z.processFile(char(fl(f)));
        tmpP=sum(z.getPerf(2,0));
        perf(m,f)=tmpP(1)/tmpP(5);
        hitRate(m,f)=tmpP(1)/(tmpP(1)+tmpP(3));
        m1=z.ser2mat(char(fl(f)));
        L=sum((m1(:,3)==4 | m1(:,3)==7) & m1(:,4)==2);
        R=sum((m1(:,3)==4 | m1(:,3)==7) & m1(:,4)==3);
        bias(m,f)=(L-R)*100/(L+R);
    end
end

figure('Position',[100 100 400 300],'Color','w');
hold on;
plot(perf',':');
plot(mean(perf),'k-','LineWidth',1);
xlabel('Day');
ylabel('Perf');

figure('Position',[100 100 400 300],'Color','w');
hold on;
plot(hitRate',':');
plot(mean(hitRate),'k-','LineWidth',1);
xlabel('Day');
ylabel('Hit Rate');

figure('Position',[100 100 400 300],'Color','w');
hold on;
% plot(bias',':');
plot(bias');
% plot(mean(bias),'k-','LineWidth',1);
xlabel('Day');
ylabel('Bias (L-R)/(L+R)');

