tasks=fieldnames(dnmsfiles);

for tIdx=1:length(tasks)
    f=tasks{tIdx};
    fl=dnmsfiles.(f);
    ids=cell(0,0);
    for fidxIn=1:length(fl)
        outID=regexp(fl{fidxIn},'(?<=\\)\w?\d{1,4}(?=_)','match');
        if ~ismember(outID{1},ids)
            ids{length(ids)+1}=outID{1};
        end
    end
    for mice=1:length(ids)
        fs=getMiceFile(fl,ids{mice});
        dates=cell(0,0);
        for dIdx=1:size(fs,1)
            date=regexp(fs(dIdx,:),'(?<=_)201\d_\d\d_\d\d(?=_)','match');
            if ~ismember(date,dates)
                dates{length(dates)+1}=date{1};
            else
                disp(f);
                disp(fs(dIdx,:));
            end
        end
        
        
    end
    
end

function out=getMiceFile(files,id)
out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
end