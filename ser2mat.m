function mat=ser2mat(file,column)
% SER2MAT  Convert java recorded serial messages to Matlab matrix.
%   mat = SER2MAT('file') convert a file.
%   @ZX, 2014.10
if ~exist('column','var')
    column=3;
end


fis=javaObject('java.io.FileInputStream',file);
ois=javaObject('java.io.ObjectInputStream',fis);
evts=cell2mat(cell(ois.readObject().toArray()));
if isa(evts,'java.util.LinkedList[]')
    mat=cell2mat(arrayfun(@(x) cell2mat(cell(evts(x).toArray)),1:size(evts,1),'UniformOutput',false));
else
    mat=reshape(evts,column,[])';
end




