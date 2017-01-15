function pirTStatQtr()
dpath=javaclasspath('-dynamic');
if max(cell2mat(strfind(dpath,'arial')))==0
    javaaddpath('I:\java\hel2arial\build\classes\');
end
path(path,'I:\Behavior\reports\Z');
groups={'Ctrl','ChR2'};
conditions={'NoLaser','1Q','2Q','3Q','4Q'};

dataFile=load('quarter.mat','data');
types={'perf','false','miss'};
measureDesc={'Performance correct rate','False choice rate','Miss rate'};



fprintf('<tr><td class="taskDesc" rowspan=3>Optical elevation of APC activity in four quarters of delay period </td>');
pOne(1,groups,conditions);
fprintf('</tr>\n');
for t=2:length(types)
    fprintf('<tr>');
    pOne(t,groups,conditions);
    fprintf('</tr>\n');
end

    function pOne(t,groups,conditions)
        data=dataFile.data.(types{t});
        nGrp=size(groups,2);
        nCondition=size(conditions,2);
        resultCell=cell(nGrp,nCondition);
        for group=1:nGrp
            for condition=1:nCondition
                resultCell{group,condition}=data(data(:,2)==group-1,condition+2);
            end
        end
        
        grp=cell(nGrp,1);
        for group=1:nGrp
            anovaMat=cell2mat(resultCell(group,:));
            if min(size(anovaMat))>1
                [p,table,stats]=anova1(anovaMat,{'NoLaser','Q1','Q2','Q3','Q4'},'off');
                nGrp=struct('p',p,'F',table{2,5},'N',stats.n(1));
                grp{group}=nGrp;
            end
        end

        fprintf('<td class="measureDesc">%s</td><td class="statMethod">One-way ANOVA</td><td class="stats"><p>F<sub>ctrl</sub> = %.4f</p><p>p<sub>ctrl</sub> = %.4f</p><p>F<sub>ChR2</sub> = %.4f</p><p>p<sub>ChR2</sub> = %.4f</p></td><td class="miceN"><p>AAV-CaMKII&alpha;-mCherry = %d</p><p>AAV-CaMKII&alpha;-ChR2-mCherry = %d </p></td>',measureDesc{t},grp{1}.F,grp{1}.p,grp{2}.F,grp{2}.p, grp{1}.N, grp{2}.N);
    end
end