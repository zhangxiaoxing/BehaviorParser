if ~exist('perf','var')
    z=zmat.Zmat;
    z.updateFilesList({'D:\Behavior2019\Feb\'});
    fs=cell(z.listFiles({'OPTO'}));
    z.setMinLick(0);
    z.setFullSession(0);
    optoCond=[0,40:45,48:50];
    perf=[];
    FA=[];
    for i=1:size(fs,1)
        z.processFile(fs{i});
        mat=tools.clearLicklessTrials(z.getFactorSeq(false,false));
        perf(i,:)=arrayfun(@(x) mean(ismember(mat(mat(:,7)==optoCond(x),4),[3 6])),1:10);
        FA(i,:)=arrayfun(@(x) nnz(mat(mat(:,7)==optoCond(x),4)==5)/nnz(ismember(mat(mat(:,7)==optoCond(x),4),[5 6])),1:10);
    end
end
plotOne(perf);
plotOne(FA);

function plotOne(stats)
figure();
hold on;
bar(nanmean(stats));
plot(stats.');
% if max(ylim())<50
%     ylim([0,0.5]);
% elseif min(ylim())>50
%     ylim([0.5,1]);
% end
end