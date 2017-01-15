function anovaMix(data,byDay)
if byDay
    thres=3;
else
    thres=11;
end

%all Day
mixed_between_within_anova(data);

%first 2 day

data2=data(data(:,3)<thres,:);
mixed_between_within_anova(data2);


%last 3 day

data3=data(data(:,3)>=thres,:);
data3(:,3)=data3(:,3)-thres+1;
mixed_between_within_anova(data3);