function [allTrial,perMice]=stats_GLM(files)

p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end

z=zmat.Zmat;
z.setFullSession(20);

ids=unique(cellfun(@(x) x{1},regexp(files,'\\(\w{0,1}\d{1,4})_','tokens','once'),'UniformOutput',false));

% ids=cell(0);
% for i=1:length(files)
%     outID=regexp(char(files(i)),'(?<=\\)\w?\d{1,4}(?=_)','match');
%     if ~ismember(outID{1},ids)
%         ids{length(ids)+1}=outID{1};
%     end
% end





optoPos={'33', '38', '41', '701','703','704','101', '102', '106', '107',...
    '66', '67', '76', '78', '80', '81', '83','V14','V15','V7','V9','V1',...
    'V49','V50','V58','V59','V62','S1','S5','S6','S12','S16','S24','S32',...
    'S31','S33','S34',...
    'D10','D9','D8','D4','D11','D12','D3','D220','D214','D216', 'D219', 'D221', 'D215'};
% bj={'32', '33', '700', '701', '702', '703', '704', '707', '101', '102', '103', '105', '106', '107', '108', '109'};
% mk={'37', '38', '40', '41', '64', '65', '66', '67'};
% rq={'76', '77', '78', '79', '80', '81', '82', '83','V14','V15','V7','V9','V1','V2','V3','V4','V11','V12','V13','V46','V48','V49','V50','V51','V55','V58','V59','V61','V62','V63'};
% idx=0;
minLick=0;
z.setMinLick(minLick);
allTrial=[];
perMice=[];
for mice=1:length(ids)
    oneMice=[];
    f=getMiceFile(ids{mice});
    if size(f,1)>0
        for fidx=1:size(f,1)
            z.processFile(f(fidx,:));
            facSeq=z.getFactorSeq(false);
            facSeq(:,6)=1:size(facSeq,1);
            facSeq(:,7)=mice;
            facSeq=clearBadPerf(facSeq);
            if length(facSeq)<50
                continue;
            end
%             
%             if ismember(ids{mice},bj)
%                 facSeq(:,1:2)=facSeq(:,1:2)+2;
%             elseif ismember(ids{mice},mk)
%                 facSeq(:,1:2)=facSeq(:,1:2)+4;
%             end

                % Sample, Test, Laser, Correct, 
                %                       Lick, trial#, mice#, Geno


            facSeq(facSeq(:,4)==3 | facSeq(:,4)==5,5)=1;
            facSeq(facSeq(:,4)==4 | facSeq(:,4)==6,5)=0;


            facSeq(facSeq(:,4)==3 | facSeq(:,4)==6,4)=1;
            facSeq(facSeq(:,4)==4 | facSeq(:,4)==5,4)=0;
            
                

%              facSeq(:,6)=([0;facSeq(1:end-1,4)]);
%             facSeq(:,7)=([0;facSeq(1:end-1,5)]);

            facSeq(:,8)=ismember(ids{mice},optoPos);
            
            allTrial=[allTrial;facSeq];
            oneMice=[oneMice;facSeq];
        end
    end
    
    matchOdor=@(x,y) ismember(x,[2 5 7])==ismember(y,[2 5 7]);
    
    if numel(oneMice)>3
        perfOn=sum(oneMice(:,3) & oneMice(:,4))*100/sum(oneMice(:,3));
        perfOff=sum(oneMice(:,3)==0 & oneMice(:,4))*100/sum(oneMice(:,3)==0);
        missOn=sum(oneMice(:,3) & oneMice(:,4)==0 & ~matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3) & ~matchOdor(oneMice(:,1),oneMice(:,2)));
        missOff=sum(oneMice(:,3)==0 & oneMice(:,4)==0 & ~matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3)==0 & ~matchOdor(oneMice(:,1),oneMice(:,2)));
        
        falseOn=sum(oneMice(:,3) & oneMice(:,4)==0 & matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3) & matchOdor(oneMice(:,1),oneMice(:,2)));
        falseOff=sum(oneMice(:,3)==0 & oneMice(:,4)==0 & matchOdor(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3)==0 & matchOdor(oneMice(:,1),oneMice(:,2)));
        
        perMice=[perMice;perfOn,perfOff,ismember(ids{mice},optoPos),missOn,missOff,falseOn,falseOff,mice];
    end
end

    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end

end








% clear java;
% 
% javaaddpath('I:\java\zmat\build\classes\');
% z=zmat.Zmat;
% z.setFullSession(0);
% load dnmsfiles.mat;
% 
% toFit=[];
% for i=1:length(dnmsfiles.delay5s)
%     z.processFile(dnmsfiles.delay5s{i});
%     toFit=[toFit;z.getFactorSeq()];
% end
% 
% toFit(toFit(:,4)==3 | toFit(:,4)==5,4)=1;
% toFit(toFit(:,4)==4 | toFit(:,4)==6,4)=0;
% toFit(:,5)=(toFit(:,1)==toFit(:,2));
% y=double(toFit(:,4));
% X=double(toFit(:,[1:3,5]));
% mdl=fitglm(X,y,'linear','Categorical',[1:4],'Distribution','binomial')
% 


function out=clearBadPerf(facSeq)

 
    
    if length(facSeq)>=80
        facSeq(:,5)=0;
        i=80;
        while i<length(facSeq)
            goodOff=nnz((facSeq(i-79:i,4)==3 | facSeq(i-79:i,4)==6)& facSeq(i-79:i,3)==0);
            if goodOff>=nnz(facSeq(i-79:i,3)==0)*80/100
%             if goodOff>=32
                if facSeq(i-79,3)==0
                    facSeq(i-79:i-1,5)=1;
                else
                    facSeq(i-78:i,5)=1;
                end
%             facSeq(i-79:i,5)=1;
            end
            i=i+1;
        end
        out=facSeq(facSeq(:,5)==1,:);
    else
        out=[];
    end
end
    
    


function load
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
[allTrialsSample,perfSample]=stats_GLM(dnmsfiles.firstOdor);
[allTrialsTest,perfTest]=stats_GLM(dnmsfiles.secondOdor);
[allTrialsBoth,perfBoth]=stats_GLM(dnmsfiles.bothOdor);

[allTrialsGNG,perfGNG]=stats_GLM(dnmsfiles.gonogo);
[allTrialsGNG,perfNodelay]=stats_GLM(dnmsfiles.noDelayBaselineResp);

% [allTrialsDPATrial,perfDPATrial]=stats_GLM(fsdpatrialonoff);
[allTrialsDPABlock,perfDPABlock]=stats_GLM(ODPAfiles.DPA_delay_laser);

end