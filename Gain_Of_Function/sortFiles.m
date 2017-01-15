function out=sortFiles(files)
ids=regexp(files(:,1),'(?<=\\)\w?\d{1,4}(?=_)','match','once');
[~,I]=sort(ids);
out=files(I,:);
end