function out=rearrange(data)
col=size(data,2);
row=size(data,1);
out=nan((col-2)*row,4);
idx=1;
for m=1:row
    for d=3:col
        out(idx,:)=[data(m,d), data(m,2)+1, d-2, m];
        idx=idx+1;
    end
end
