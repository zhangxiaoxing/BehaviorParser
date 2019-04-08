function [allTrial,perMice]=stats_opto_vardelay(files,thresh)

p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end
z=zmat.Zmat;
z.setFullSession(32);
z.setMinLick(0);
ids=unique(cellfun(@(x) x{1},regexp(files,'\\(\w{0,1}\d{1,4})_','tokens','once'),'UniformOutput',false));



optoPos={'9773','9785','362','368','370','371','372','511','516','536'};
optoNeg={'366','367','513','534','7044','7045','7068','3074','6878','6881','6872'};%3074 is actually 7074

allTrial=[];
perMice=struct();
perMice.perf=[];
perMice.FA=[];
perMice.miss=[];
perMice.gene=[];
perMice.ids=cell(1,1);
for mice=1:length(ids)
    perMice.ids{mice}=ids{mice};
    if ismember(ids{mice},optoPos)
        perMice.gene(mice)=1;
    elseif ismember(ids{mice},optoNeg)
        perMice.gene(mice)=0;
    else
        perMice.gene(mice)=-1;
    end
    
    oneMice=[];

    f=files(contains(files,['\',ids{mice},'_']));
    if size(f,1)>0
            z.processFile(f);
            facSeq=z.getFactorSeqSess(false,false);
           
            if numel(facSeq)<320
                disp('lack trials');
                continue;
            end
            oneMice=OptoMisc.clearBadPerf20(facSeq,thresh);
            if numel(facSeq)<320
                disp('lack good trials');
                continue;
            end
    end
    oneMice(:,10)=round(oneMice(:,10)./1000);
    sel=[oneMice(:,3)==0 & oneMice(:,10)==5,...
        oneMice(:,3)==1 & oneMice(:,10)==5,...
        oneMice(:,3)==0 & oneMice(:,10)==8,...
        oneMice(:,3)==1 & oneMice(:,10)==8,...
        oneMice(:,3)==0 & oneMice(:,10)==12,...
        oneMice(:,3)==1 & oneMice(:,10)==12,...
        oneMice(:,3)==0 & oneMice(:,10)==20,...
        oneMice(:,3)==1 & oneMice(:,10)==20];
        
    perMice.perf(mice,:)=arrayfun(@(x) mean(ismember(oneMice(sel(:,x),4),[3 6])),1:size(sel,2)).*100;
    perMice.FA(mice,:)=arrayfun(@(x) nnz(oneMice(sel(:,x),4)==5)/nnz(ismember(oneMice(sel(:,x),4),[5 6])),1:size(sel,2)).*100;
    perMice.miss(mice,:)=arrayfun(@(x) nnz(oneMice(sel(:,x),4)==4)/nnz(ismember(oneMice(sel(:,x),4),[3 4])),1:size(sel,2)).*100;
end

end








