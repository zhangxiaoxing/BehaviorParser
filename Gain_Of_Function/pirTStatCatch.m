function pirTStatCatch()
fs=load('newCatchTrials.mat');
data=fs.catchTrials;
measures={'perf','false','miss'};
tasks={'noodor','incongruent'};
taskDescs={'1<sup>st</sup>-odor-omission trials','Incongruent-activation trials'};
measureDesc={'Performance correct rate','False choice rate','Miss rate'};

for t=1:2
    fprintf('<tr><td class="taskDesc" rowspan=%d>%s, regular trial vs. catch trial </td>',length(measures),taskDescs{t});
    pOne(data.(tasks{t}).(measures{1}),measureDesc{1});
    fprintf('</tr>\n');
    
    for m=2:3
        fprintf('<tr>');
        pOne(data.(tasks{t}).(measures{m}),measureDesc{m});
        fprintf('</tr>\n');
    end
end

    function pOne(data,measureDesc)
        onCatchC=data(data(:,2)==0,4);
        notOnCatchC=data(data(:,2)==0,3);
        [~,pC,~,statsC]=ttest(onCatchC,notOnCatchC);
        nC=size(onCatchC,1);
        
        
        onCatchO=data(data(:,2)==1,4);
        notOnCatchO=data(data(:,2)==1,3);
        [~,pO,~,statsO]=ttest(onCatchO,notOnCatchO);
        nO=size(onCatchO,1);
        
        fprintf('<td class="measureDesc">%s</td><td class="statMethod">Paired T-Test</td><td class="stats"><p>T<sub>ctrl</sub> = %.4f</p><p>p<sub>ctrl</sub> = %.4f</p><p>T<sub>ChR2</sub> = %.4f</p><p>p<sub>ChR2</sub> = %.4f</p></td><td class="miceN"><p>AAV-CaMKII&alpha;-mCherry = %d</p><p>AAV-CaMKII&alpha;-ChR2-mCherry = %d</p></td>',measureDesc,statsC.tstat,pC,statsO.tstat,pO,nC,nO);
    end


end




