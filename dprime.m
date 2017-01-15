function out=dprime(data)
FA=cell2mat(data(:,3));
MS=cell2mat(data(:,4));

FA(FA<0.1)=0.1;
MS(MS<0.1)=0.1;

FA(FA>99.9)=99.9;
MS(MS>99.9)=99.9;

Dp=norminv((100-MS*2)./100)-norminv(FA./50);
dpc=mat2cell(Dp,ones(size(Dp,1),1));
out=[data(:,1:6), dpc];