function out=getLearnFiles(files)
ids=unique(regexp(files,'(?<=\\)S\d{1,4}(?=_)','match','once'));
out=cell(length(ids),5);
for i=1:length(ids)
    fid=getMiceFile(ids{i});
    dates=regexp(fid,'(?<=_)201[45]_\d\d_\d\d','match','once');
    [~,I]=sort(dates);
    if length(fid)==5
        out(i,:)=fid(I)';
    else
        fprintf('Mice # %s count = %d \n',ids{i},length(fid));
    end
    
end


    function out=getMiceFile(id)
        out=files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)']))));
    end
end