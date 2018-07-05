function out=plotOneRespT(data)
t_lick=[];
mid2=0;
for mid=1:length(data)
 
    if ~isempty(data{mid})
        t_lick_perMice=cell(10,1);
        mid2=mid2+1;
        oneMice=data{mid};
        hitLick=oneMice(oneMice(:,3)==0 & oneMice(:,2)>0,1:2);
        trialId=unique(hitLick(:,1));
        for trial=trialId'
            licks=hitLick(hitLick(:,1)==trial,2);
            for i=1:min(length(licks),10)
                t_lick_perMice{i}=[t_lick_perMice{i},licks(i)];
            end
        end
        for i=1:10
            t_lick(mid2,i)=mean(t_lick_perMice{i});
        end
    end
    
    
end
out=t_lick;
end