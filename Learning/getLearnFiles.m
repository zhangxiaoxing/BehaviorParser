function out=getLearnFiles(files)
ids=unique(regexp(files,'(?<=\\)\w?\d{1,4}(?=_)','match','once'));
out=cell(length(ids),length(files)/length(ids));
for i=1:length(ids)
    fid=getMiceFile(ids{i});
    dates=regexp(fid,'(?<=_)201[45]_\d\d_\d\d','match','once');
    [~,I]=sort(dates);
    out(i,:)=fid(I)';
end


    function out=getMiceFile(id)
        out=files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)']))));
    end
end