function listMeans(z,MouseID, Desc)
for i=1:size(Desc,2)
    files=z.listFiles('I:\Behavior\2014\July\',{MouseID,Desc{1,i}});
    z.processFile(files);
    disp(mean(z.cr));
end