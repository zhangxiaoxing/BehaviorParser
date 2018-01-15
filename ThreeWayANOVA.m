function ThreeWayANOVA
pirSt=load('.\DNMS\pir.mat');
pir=pirSt.pir;
fn=    {'delay5s',     'delay8s',     'delay12s'};%,     'secondOdor',     'baseline',     'firstOdor',     'bothOdor',     'responseDelay',          'gonogo'};
nlist=cell(0,4);
for i=1:length(fn)
    subList=pir.chr2.dnms.(fn{i});
    for j=1:size(subList,1)
        nlist=[nlist;{subList{j,2},subList{j,5},subList{6},fn{i}}];
    end
end

nlist=cell(0,4);
for i=1:length(fn)
    subList=pir.chr2.dnms.(fn{i});
    for j=1:size(subList,1)
        nlist=[nlist;{subList{j,2},subList{j,5},subList{j,6},fn{i}}];
    end
end

[p,tbl,stats]=anovan(cell2mat(nlist(:,1)),{nlist(:,2),nlist(:,3),nlist(:,4)},'model','full','varnames',{'Laser','Opsin','Delay_Len'});
assignin('base','tbl1',tbl);

% qtr=pir.chr2.dnms.eachQuarter;
% [p,tbl,stats]=anovan(cell2mat(qtr(:,2)),{qtr(:,5),qtr(:,6)},'model','full','varnames',{'Laser','Opsin'});
% [p,tbl,stats]=anovan(cell2mat(qtr(:,3)),{qtr(:,5),qtr(:,6)},'model','full','varnames',{'Laser','Opsin'});

addpath('.\Learning');
[ssq,df,msq,fs,ps]=mixed_between_within_anova(transformQtr(pir.chr2.dnms.eachQuarter,2));

    function out=transformQtr(data,measure)
%         mice=size(data,1)./5;
        out=nan(size(data,1),4);
        
        
        
        for dIdx=1:size(data,1)
            if strcmpi('ChR2',data{dIdx,6})
                opsin=1;
            else
                opsin=2;
            end
            out(dIdx,:)=[data{dIdx,measure},opsin,mod(dIdx,5)+1,ceil(dIdx/5)];
        end

            
    end
end