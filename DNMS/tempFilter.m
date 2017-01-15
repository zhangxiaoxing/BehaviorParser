function out=tempFilter

optoPos={'33', '38', '41', '101', '102', '106', '107', '66', '67', '76', '78', '80', '81', '83','V14','V15','V7','V9','V1','V49','V50','V58','V59','V62','S1','S5','S6','S12','S16','S24','S32','S31','S33','S34'};

out=cell(1,6);
cidx=1;
javaaddpath('I:\java\hel2arial\build\classes\');javaaddpath('I:\java\zmat\build\classes\');
z=zmat.ZmatGNG;
z.updateFilesList('D:\Behavior\');
close all
f=cell(z.listFiles({'PreOdor','-Nphr','-10mW','-4s','-0mW'}));
f2=cell(z.listFiles({'gonogo','-lr'}));
f=sort([f;f2]);

for i=2:size(f,1)
    if length(f{i-1})>50 && strcmpi(f{i}(1:50),f{i-1}(1:50))
        f{i}='';
    end
end
f2(1)=f(1);

for i=2:size(f,1)
    if length(f{i})>10
        f2=[f2;f(i)];
    end
end
f=f2;

toUse=ones(size(f,1),1);
for i=1:size(f,1)
    z.processFile(f{i});
    o1=z.getPerf(true,50);
    o2=z.getPerf(false,50);
    o=[o1;o2];
    if sum(o(:,5))<100 || sum(sum(o(:,[1 4])))<80
        toUse(i)=0;
    end
end

for i=1:size(toUse,1)
    if toUse(i)>0
       outID=regexp(char(f(i)),'(?<=\\)\w?\d{1,4}(?=_)','match');
       if ismember(outID(end),optoPos) && ~(strcmpi(strtrim(f{i}(end-2:end)),'txt'))
           z.processFile(f{i});
           o1=z.getPerf(true,0);
           o2=z.getPerf(false,0);
           
           for j=1:min(size(o1,1)-4,10)
               if subSum(j:j+4,o1)-subSum(j:j+4,o2)>0 && subSum(1:5,o1)-subSum(1:5,o2)<0
                out(cidx,:)={i,j,subSum(j:j+4,o1)-subSum(j:j+4,o2), subSum(1:5,o1)-subSum(1:5,o2),subSum(j:j+4,o1)-subSum(j:j+4,o2)-(subSum(1:5,o1)-subSum(1:5,o2)),f{i}};
                cidx=cidx+1;
               end
           end
           
       end
    end
end

    function out=subSum(j,o)
        out=double(sum(o(j,6)))/sum(sum(o(j,[6,7]),2));  
    end

end