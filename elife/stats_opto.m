function [allTrial,perMice]=stats_opto(files,thresh,delay)

p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end
z=zmat.Zmat;
z.setFullSession(0);
z.setMinLick(0);
ids=unique(cellfun(@(x) x{1},regexp(files,'\\(\w{0,1}\d{1,4})_','tokens','once'),'UniformOutput',false));



optoPos={'9773','9785','362','368','370','371','372','511','516','536'};
optoNeg={'366','367','513','534','7044','7045','7068','3074','6878','6881','6872'};%3074 is actually 7074
optoCond=[0,40:45,48:50];
if exist('delay','var') && delay==20
    optoCond=[0,40:45,51:53,49];
end

allTrial=[];
perMice=struct();
perMice.perf=[];
perMice.FA=[];
perMice.miss=[];
perMice.gene=[];
perMice.ids=cell(1,1);
for mice=1:length(ids)
    perMice.ids{mice}=ids{mice};
    oneMice=[];
    %     lickEff
    f=getMiceFile(ids{mice});
    if size(f,1)>0
        for fidx=1:size(f,1)
            fn=f(fidx,:);
            z.processFile(strtrim(fn));

            facSeq=z.getFactorSeqSess(false,false);
            
            if numel(facSeq)<360
                continue;
            end
            if exist('delay','var') && delay==20
                facSeq=OptoMisc.clearBadPerf20(facSeq,thresh);
            else
                facSeq=OptoMisc.clearBadPerf(facSeq,thresh);
            end
            if numel(facSeq)<360
                continue;
            end
            
            if ismember(ids{mice},optoPos)
                perMice.gene(mice)=1;
                facSeq(:,8)=1;
            elseif ismember(ids{mice},optoNeg)
                perMice.gene(mice)=0;
                facSeq(:,8)=0;
            else
                perMice.gene(mice)=-1;
            end
            

            
            
            
            
            allTrial=[allTrial;facSeq];
            oneMice=[oneMice;facSeq];
        end
    end
    perMice.perf(mice,:)=arrayfun(@(x) mean(ismember(oneMice(oneMice(:,7)==optoCond(x),4),[3 6])),1:length(optoCond)).*100;
    perMice.FA(mice,:)=arrayfun(@(x) nnz(oneMice(oneMice(:,7)==optoCond(x),4)==5)/nnz(ismember(oneMice(oneMice(:,7)==optoCond(x),4),[5 6])),1:length(optoCond)).*100;
    perMice.miss(mice,:)=arrayfun(@(x) nnz(oneMice(oneMice(:,7)==optoCond(x),4)==4)/nnz(ismember(oneMice(oneMice(:,7)==optoCond(x),4),[3 4])),1:length(optoCond)).*100;
end



    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end

end








