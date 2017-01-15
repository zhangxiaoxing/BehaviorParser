% function outList=mat2list(mat)
% idx=1;
% cols=size(mat,2)-2;
% rows=size(mat,1)-1;
% outList=zeros(cols*rows,4);
% for row=2:rows+1
%     for col=3:cols+2
%         outList(idx,1)=mat{row,col};
%         outList(idx,2)=strcmp(mat{row,2},'G')+1;
%         outList(idx,3)=col-2;
%         outList(idx,4)=row;
%         idx=idx+1;
%     end
% end



function outList=mat2list(mat)
idx=1;
cols=size(mat,2)-2;
rows=size(mat,1)-1;
outList=zeros(cols*rows,4);
for row=2:rows+1
    for col=3:cols+2
        outList(idx,1)=mat{row,col};
        outList(idx,2)=strcmp(mat{row,2},'G')+1;
        outList(idx,3)=col-2;
        outList(idx,4)=row-1;
        idx=idx+1;
    end
end