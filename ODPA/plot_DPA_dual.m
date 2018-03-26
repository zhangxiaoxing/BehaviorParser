
function perfDPA=plot_DPA_dual(infiles,outfile)
% [~,perfDPA]=stats_New_Cri(ODPAfiles.DPA_delay_laser);
[~,perfDPA]=stats_New_Cri(infiles);

close all;
set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,150,180]);
figure('Color','w','Position',[100,100,150,150]);
hold on;
plotOne([2,1],perfDPA(perfDPA(:,3)==0,1:2),'k');
plotOne([4,3]+1,perfDPA(perfDPA(:,3)==1,1:2),'b');


xlim([0,6]);
% ylim([55,100]);
ylim([65,100]);

% plot([12,12],ylim(),':k','LineWidth',1);

% set(gca,'YTick',60:20:100,'XTick',[1 2 4 5],'XTickLabel',[]);
set(gca,'YTick',70:10:100,'XTick',[1 2 4 5],'XTickLabel',[]);
savefig([outfile,'.fig']);
print([outfile,'.eps'],'-depsc','-r0');

[~,pn]=ttest(perfDPA(perfDPA(:,3)==0,1),perfDPA(perfDPA(:,3)==0,2));
[~,p]=ttest(perfDPA(perfDPA(:,3)==1,1),perfDPA(perfDPA(:,3)==1,2));

nDPA1=[perfDPA(:,1),perfDPA(:,3),ones(length(perfDPA),1)];
nDPA0=[perfDPA(:,2),perfDPA(:,3),ones(length(perfDPA),1)*0];

toN=[nDPA1;nDPA0];
fprintf('ttest WT %.3f, ttest ChR2 %.3f\n',pn,p);
anovan(toN(:,1),{toN(:,2),toN(:,3)},'model','interaction','varnames',{'Gene','Laser'});

end


function [allTrial,perMice]=stats_New_Cri(files)

p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end


ids=cell(0);
for i=1:length(files)
    outID=regexp(char(files(i)),'(?<=\\)\w?\d{1,4}(?=_)','match','once');
    if ~ismember(outID,ids)
        ids{length(ids)+1}=outID;
    end
end


optoPos={'D10','D9','D8','D4','D11','D12','D3','D220','D214','D216', 'D219', 'D221', 'D215'};



z=zmat.ZmatDual();
allTrial=[];
perMice=[];
for mice=1:length(ids)
    oneMice=[];
    f=getMiceFile(ids{mice});
    if size(f,1)>0
        for fidx=1:size(f,1)
            z.setFullSession(24);
            z.processFile(strtrim(f(fidx,:)));
            facSeq=z.getFactorSeq();
            if numel(facSeq)<50
                z.setFullSession(48);
                z.processFile(strtrim(f(fidx,:)));
                facSeq=z.getFactorSeq();
                z.setFullSession(24);
            end


%             fprintf('%d, %s\n',numel(facSeq),f(fidx,:));
            facSeq=clearBadPerf(facSeq);
            if length(facSeq)<50
                continue;
            end


            facSeq(facSeq(:,4)==3 | facSeq(:,4)==5,5)=1;%lick
            facSeq(facSeq(:,4)==4 | facSeq(:,4)==6,5)=0;


            facSeq(facSeq(:,4)==3 | facSeq(:,4)==6,4)=1;%correct
            facSeq(facSeq(:,4)==4 | facSeq(:,4)==5,4)=0;
            
                

            facSeq(:,8)=ismember(ids{mice},optoPos);
            
            allTrial=[allTrial;facSeq];
            oneMice=[oneMice;facSeq];
        end
    end
    
    isPair=@(x,y) ismember(x,[2 5])~=ismember(y,[2 5]);
    if numel(oneMice)>3
        perfOn=sum(oneMice(:,3) & oneMice(:,4))*100/sum(oneMice(:,3));
        perfOff=sum(oneMice(:,3)==0 & oneMice(:,4))*100/sum(oneMice(:,3)==0);
        missOn=sum(oneMice(:,3) & oneMice(:,4)==0 & isPair(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3) & isPair(oneMice(:,1),oneMice(:,2)));
        missOff=sum(oneMice(:,3)==0 & oneMice(:,4)==0 & isPair(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3)==0 & isPair(oneMice(:,1),oneMice(:,2)));
        
        falseOn=sum(oneMice(:,3) & oneMice(:,4)==0 & ~isPair(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3) & ~isPair(oneMice(:,1),oneMice(:,2)));
        falseOff=sum(oneMice(:,3)==0 & oneMice(:,4)==0 & ~isPair(oneMice(:,1),oneMice(:,2)))*100/sum(oneMice(:,3)==0 & ~isPair(oneMice(:,1),oneMice(:,2)));
        perMice=[perMice;perfOn,perfOff,ismember(ids{mice},optoPos),missOn,missOff,falseOn,falseOff];
    end
end

    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end

end



function out=clearBadPerf(facSeq)

    if length(facSeq)>=80
        facSeq(:,5)=0;
        i=80;
        while i<length(facSeq)
            goodOff=sum((facSeq(i-79:i,4)==3 | facSeq(i-79:i,4)==6)& facSeq(i-79:i,3)==0);
            if goodOff>=40*80/100
                facSeq(i-79:i,5)=1;
            end
            i=i+1;
        end
        out=facSeq(facSeq(:,5)==1,:);
%         fprintf('in, %d, out, %d\n',size(facSeq,1),size(out,1));
    else
        out=[];
    end
end
    
    

function plotOne(x,y,pColor)
dd=0.5;
randd=@(x) rand(size(x,1),1)*0.5-0.25;
plot((x+randd(y))',y',sprintf('-%s.',pColor));

ci=bootci(100,@(x) mean(x), y(:,2));
plot([x(2)-dd,x(2)-dd],ci,sprintf('-%s',pColor),'LineWidth',1);
disp(ci)
ci=bootci(100,@(x) mean(x), y(:,1));
plot([x(1)+dd,x(1)+dd],ci,sprintf('-%s',pColor),'LineWidth',1);

plot(x(2)-dd,mean(y(:,2)),sprintf('%so',pColor),'MarkerFaceColor','w','MarkerSize',4,'LineWidth',1);
plot(x(1)+dd,mean(y(:,1)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',1);

end

