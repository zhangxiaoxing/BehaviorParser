function pirTStat(data)
chr2=data.chr2;
% tasks={'delay5s','delay8s','delay12s','firstOdor','secondOdor','bothOdor','baseline','responseDelay'};
% taskDescs={'Laser during 5s delay period','Laser during 8s delay period','Laser during 12s delay period','Laser during first odor delivery','Laser during second odor delivery','Laser during both odor delivery','Laser during baseline period','Laser during response delay period'};
% tasks={'delay12s','delay8s','delay5s','gonogo','baseline','bothOdor','firstOdor','secondOdor'};
tasks={'responseDelay'};
taskDescs={'Laser during baseline period'};

% measureTags={'p','f','m','d','l'};
measureDesc={'Performance correct rate','False choice rate','Miss rate','d''','Lick Efficiency'};
measure=[2:4,7,9];

for t=1:length(tasks)
%     fprintf('<tr><td class="taskDesc" rowspan=5>%s, ChR2 laser on vs. ChR2 laser off</td>',taskDescs{t});
%     pOne(chr2.dnms.(tasks{t}),measure(1),measureDesc{1});
%     fprintf('</tr>\n');
    for m=1:length(measure)
        pOne(chr2.dnms.(tasks{t}),measure(m),measureDesc{m},tasks{t});
    end
end

    function pOne(data,measure,measureDesc,taskDesc)
        ctrlOff=cell2mat(data(strcmpi(data(:,6),'ctrl') & strcmpi(data(:,5),'lightOff'),measure));
        ctrlOn=cell2mat(data(strcmpi(data(:,6),'ctrl') & strcmpi(data(:,5),'lightOn'),measure));
        [~,ctrlp,~,ctrlStats]=ttest(ctrlOn,ctrlOff);
        ctrlN=sum(strcmpi(data(:,6),'ctrl') & strcmpi(data(:,5),'lightOff'));

        optoOff=cell2mat(data(strcmpi(data(:,6),'ChR2') & strcmpi(data(:,5),'lightOff'),measure));
        optoOn=cell2mat(data(strcmpi(data(:,6),'ChR2') & strcmpi(data(:,5),'lightOn'),measure));
        [~,optop,~,optoStats]=ttest(optoOn,optoOff);
        optoN=sum(strcmpi(data(:,6),'ChR2') & strcmpi(data(:,5),'lightOff'));
        fprintf('%s\tCtrl %s\tpaired t-test\t\t%d\tnumber of mice\t\terrorbars are mean +/- SEM\t\t p = %.2e\t\tt(%d) = %.3f\t\t\n',taskDesc,measureDesc,ctrlN,ctrlp,ctrlN-1,ctrlStats.tstat);
        fprintf('%s\tTransgenenic %s\tpaired t-test\t\t%d\tnumber of mice\t\terrorbars are mean +/- SEM\t\t p = %.2e\t\tt(%d) = %.3f\t\t\n',taskDesc,measureDesc,optoN,optop,optoN-1,optoStats.tstat);
    end
end