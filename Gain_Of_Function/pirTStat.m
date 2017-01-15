function pirTStat()

fs=load('newGain.mat');
data=fs.gain;
measures={'perf','false','miss'};

taskDescs={'Particular hemispheric laser during 5s delay period','Particular hemispheric laser during 8s delay period','Particular hemispheric laser during 12s delay period'};
measureDesc={'Performance correct rate','False choice rate','Miss rate'};

for t=8:10
    fprintf('<tr><td class="taskDesc" rowspan=%d>%s, AAV-CaMKII&alpha;-ChR2-mCherry vs. AAV-CaMKII&alpha;-mCherry </td>',length(measures),taskDescs{t-7});
    pOne(data.(measures{1}),t,measureDesc{1});
    fprintf('</tr>\n');
    for m=2:3
        fprintf('<tr>');
        pOne(data.(measures{m}),t,measureDesc{m});
        fprintf('</tr>\n');
    end
end

    function pOne(data,column,measureDesc)
        ctrl=data(data(:,2)==0,column);
        opto=data(data(:,2)==1,column);
        [~,p,~,stats]=ttest2(ctrl,opto);
        nc=size(ctrl,1);
        no=size(opto,1);
        fprintf('<td class="measureDesc">%s</td><td class="statMethod">Unpaired T-Test</td><td class="stats"><p>T = %.4f</p><p>p = %.4f</p></td><td class="miceN"><p>AAV-CaMKII&alpha;-mCherry = %d</p><p>AAV-CaMKII&alpha;-ChR2-mCherry = %d </p></td>',measureDesc,stats.tstat,p,nc,no);
    end
end




