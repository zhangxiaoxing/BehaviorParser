function pirTStat(data)
chr2=data.chr2;
% tasks={'delay5s','delay8s','delay12s','firstOdor','secondOdor','bothOdor','baseline','responseDelay'};
% taskDescs={'Laser during 5s delay period','Laser during 8s delay period','Laser during 12s delay period','Laser during first odor delivery','Laser during second odor delivery','Laser during both odor delivery','Laser during baseline period','Laser during response delay period'};
tasks={'baseline'};
taskDescs={'Laser during baseline period'};

% measureTags={'p','f','m','d','l'};
measureDesc={'Performance correct rate','False choice rate','Miss rate','<i>d''</i>','Lick Efficiency'};
measure=[2:4,7,9];

for t=1:length(tasks)
    fprintf('<tr><td class="taskDesc" rowspan=5>%s, ChR2 laser on vs. ChR2 laser off</td>',taskDescs{t});
    pOne(chr2.dnms.(tasks{t}),measure(1),measureDesc{1});
    fprintf('</tr>\n');
    for m=2:length(measure)
        fprintf('<tr>');
        pOne(chr2.dnms.(tasks{t}),measure(m),measureDesc{m});
        fprintf('</tr>\n');
    end
end

    function pOne(data,measure,measureDesc)
        ctrlOff=cell2mat(data(strcmpi(data(:,6),'ctrl') & strcmpi(data(:,5),'lightOff'),measure));
        ctrlOn=cell2mat(data(strcmpi(data(:,6),'ctrl') & strcmpi(data(:,5),'lightOn'),measure));
        [~,ctrlp,~,ctrlStats]=ttest(ctrlOn,ctrlOff);
        ctrlN=sum(strcmpi(data(:,6),'ctrl') & strcmpi(data(:,5),'lightOff'));

        optoOff=cell2mat(data(strcmpi(data(:,6),'ChR2') & strcmpi(data(:,5),'lightOff'),measure));
        optoOn=cell2mat(data(strcmpi(data(:,6),'ChR2') & strcmpi(data(:,5),'lightOn'),measure));
        [~,optop,~,optoStats]=ttest(optoOn,optoOff);
        optoN=sum(strcmpi(data(:,6),'ChR2') & strcmpi(data(:,5),'lightOff'));
        fprintf('<td class="measureDesc">%s</td><td class="statMethod">Paired T-Test</td><td class="stats"><p>T<sub>ctrl</sub> = %.4f</p><p>p<sub>ctrl</sub> = %.4f</p><p>T<sub>ChR2</sub> = %.4f</p><p>p<sub>ChR2</sub> = %.4f</p></td><td class="miceN"><p>Ctrl = %d</p><p>VGAT-ChR2 = %d</p></td>',measureDesc,ctrlStats.tstat,ctrlp,optoStats.tstat,optop,ctrlN,optoN);
    end
end