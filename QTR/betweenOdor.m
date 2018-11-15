function betweenOdor( data )
% rq=cell2mat(data(~cellfun('isempty',regexp('RQ',data(:,8))),[2:4 7 9]));
% bj=cell2mat(data(~cellfun('isempty',regexp('BJ',data(:,8))),[2:4 7 9]));
% mk=cell2mat(data(~cellfun('isempty',regexp('MK',data(:,8))),[2:4 7 9]));
measureTags={'','Performance','False Choice','Miss','','','d''','','Lick Efficiency'};
for m=[2:4 7 9]
    p=anova1(cell2mat(data(:,m)),data(:,8),'on');
    if p< 0.05
        fprintf('***');
    end
    fprintf('%s, p=%.4f\n',measureTags{m},p);
end
    


end

