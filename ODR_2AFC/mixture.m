

HitL=ismember(mat(:,1),[6 16 17]) & mat(:,3)==3;
FAL=ismember(mat(:,1),[18 19 7]) & mat(:,3)==5;
HitR=ismember(mat(:,1),[18 19 7]) & mat(:,3)==3;
FAR=ismember(mat(:,1),[6 16 17]) & mat(:,3)==5;

mix=[6 16 17 18 19 7];
ratio=nan(1,6);
for i=1:6
    mixL=sum(mat(:,1)==mix(i) & (HitL | FAL));
    mixR=sum(mat(:,1)==mix(i) & (HitR | FAR));
    ratio(i)=mixR/(mixL+mixR);
end

correct=nan(1,6);
for i=1:6
    correct(i)=sum(mat(:,1)==mix(i) & mat(:,3)==3)./sum(mat(:,1)==mix(i) & ismember(mat(:,3),[3 5]));
end
