function [allTrial,perMice]=stats_opto(files)

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
    %     lickEff
    f=getMiceFile(ids{mice});
    if size(f,1)>0
        for fidx=1:size(f,1)
            fn=f(fidx,:);
            z.processFile(strtrim(fn));
            facSeq=z.getFactorSeq(false,false);
            
            if length(facSeq)<40
                continue;
            end
            facSeq(:,15)=facSeq(:,5);
            facSeq=Tools.clearContLick(Tools.clearLicklessTrials(facSeq));
%             if length(facSeq)<40
%                 continue;
%             end
            
            %             facSeq(facSeq(:,4)==3 | facSeq(:,4)==5,5)=1;
            %             facSeq(facSeq(:,4)==4 | facSeq(:,4)==6,5)=0;
            %
            %
            %             facSeq(facSeq(:,4)==3 | facSeq(:,4)==6,4)=1;
            %             facSeq(facSeq(:,4)==4 | facSeq(:,4)==5,4)=0;
            %
            %
            %
            %             facSeq(:,6)=([0;facSeq(1:end-1,4)]);%prev correct
            %             facSeq(:,7)=([0;facSeq(1:end-1,5)]);%prev lick
            %
            %             facSeq(:,8)=ismember(lower(ids{mice}),lower(optoPos));
            
            
            
            %             allTrial=[allTrial;facSeq];

            oneMice=[oneMice;facSeq];
            
        end
    end
    perMice.perf(mice,:)=arrayfun(@(x) mean(ismember(oneMice(oneMice(:,7)==optoCond(x),4),[3 6])),1:10);
    perMice.FA(mice,:)=arrayfun(@(x) nnz(oneMice(oneMice(:,7)==optoCond(x),4)==5)/nnz(ismember(oneMice(oneMice(:,7)==optoCond(x),4),[5 6])),1:10);
    perMice.miss(mice,:)=arrayfun(@(x) nnz(oneMice(oneMice(:,7)==optoCond(x),4)==4)/nnz(ismember(oneMice(oneMice(:,7)==optoCond(x),4),[3 4])),1:10);
%     matchOdor=@(x,y) ismember(x,[2 5 7])==ismember(y,[2 5 7]);
%     %     isPair=@(x,y) ismember(x,[2 5])~=ismember(y,[2 5]);
%     
%     if numel(oneMice)>3
%         perfOn=sum(oneMice(:,3) & oneMice(:,4))*100/sum(oneMice(:,3));
%         perfOff=sum(oneMice(:,3)==0 & oneMice(:,4))*100/sum(oneMice(:,3)==0);
%         missOn=sum(oneMice(:,3) & oneMice(:,4)==0 & ~matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3) & ~matchOdor(oneMice(:,1),oneMice(:,2)));
%         missOff=sum(oneMice(:,3)==0 & oneMice(:,4)==0 & ~matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3)==0 & ~matchOdor(oneMice(:,1),oneMice(:,2)));
%         
%         falseOn=sum(oneMice(:,3) & oneMice(:,4)==0 & matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3) & matchOdor(oneMice(:,1),oneMice(:,2)));
%         falseOff=sum(oneMice(:,3)==0 & oneMice(:,4)==0 & matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3)==0 & matchOdor(oneMice(:,1),oneMice(:,2)));
%         
%         lickEffOn=sum(oneMice(~matchOdor(oneMice(:,1),oneMice(:,2)) & oneMice(:,3) ,15))*100/sum(oneMice(oneMice(:,3)==1,15));
%         lickEffOff=sum(oneMice(~matchOdor(oneMice(:,1),oneMice(:,2)) & oneMice(:,3)==0 ,15))*100/sum(oneMice(oneMice(:,3)==0,15));
%         
%         perMice=[perMice;perfOn,perfOff,ismember(lower(ids{mice}),lower(optoPos)),missOn,missOff,falseOn,falseOff,mice,lickEffOn,lickEffOff];
%         
%     end
end
% close all;
% figure('Color','w');
% for j=1:size(perMice.perf,1)
%     subplot(5,4,j);
%     hold on;
%     bar(1:10,perMice.perf(j,:),'FaceColor','none','EdgeColor','k','LineWidth',1);
% %     plot(perMice.perf.','LineWidth',1);
%     ylim([0.55,1]);
%     set(gca,'XTick',1:10,...
%     'XTickLabel',{'Off','L138','L434','L831','L165','L363','L561','L1A1','BASE6','BASE10'},...
%     'XTickLabelRotation',60);
% end
% 
% 
% figure('Color','w');
% for j=1:size(perMice.perf,1)
%     subplot(5,4,j);
%     hold on;
%     bar(1:10,perMice.FA(j,:),'FaceColor','none','EdgeColor','k','LineWidth',1);
% %     plot(perMice.perf.','LineWidth',1);
%     ylim([0,0.5]);
%     set(gca,'XTick',1:10,...
%     'XTickLabel',{'Off','L138','L434','L831','L165','L363','L561','L1A1','BASE6','BASE10'},...
%     'XTickLabelRotation',60);
% end



    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end

end








