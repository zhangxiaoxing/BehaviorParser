
function out=plot_DPA_dual(infiles,outfile1,outfile2,wtCriteria)
% [~,perfDPA]=stats_New_Cri(ODPAfiles.DPA_delay_laser);
% for distrType=1%:2
%     disp(distrType);
[~,perfDPA]=stats_New_Cri(infiles,[],wtCriteria);
% out{distrType}=perfDPA;
out=perfDPA;
assignin('base','perfDPA_distr',perfDPA);

% close all;
set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,150,180]);
figure('Color','w','Position',[100,100,245,140]);
hold on;
plotOne([2,1],perfDPA(perfDPA(:,3)==0,1:2),'k');
plotOne([4,3]+1,perfDPA(perfDPA(:,3)==1,1:2),'b');
% [~,pn]=ttest(perfDPA(perfDPA(:,3)==0,1),perfDPA(perfDPA(:,3)==0,2));
% [~,p]=ttest(perfDPA(perfDPA(:,3)==1,1),perfDPA(perfDPA(:,3)==1,2));
xlim([0,6]);
ylim([55,100]);
% plot([12,12],ylim(),':k','LineWidth',1);
% set(gca,'YTick',60:20:100,'XTick',[1 2 4 5],'XTickLabel',[]);



perf=perfDPA;
set(gca,'YTick',60:20:100,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
savefig([outfile1,'.fig']);
print(sprintf('%s_distr.eps',outfile1),'-depsc','-r0');



disp('ranksum perf');
disp(ranksum(perfDPA(perfDPA(:,3)==0,2)-perfDPA(perfDPA(:,3)==0,1),perfDPA(perfDPA(:,3)==1,2)-perfDPA(perfDPA(:,3)==1,1)));

[~,p]=adtest(diff(perf(perf(:,3)==1,1:2),1,2));
fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);

[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,1),perf(perf(:,3)==0,2),perf(perf(:,3)==1,1),perf(perf(:,3)==1,2)));
fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% return


% disp('ranksum miss')
% disp(ranksum(diff(perfDPA(perfDPA(:,3)==0,4:5),1,2),diff(perfDPA(perfDPA(:,3)==1,4:5),1,2)));
% disp('ranksum false')
% disp(ranksum(diff(perfDPA(perfDPA(:,3)==0,6:7),1,2),diff(perfDPA(perfDPA(:,3)==1,6:7),1,2)));
% disp('ranksum lickEff')
% disp(ranksum(diff(perfDPA(perfDPA(:,3)==0,9:10),1,2),diff(perfDPA(perfDPA(:,3)==1,9:10),1,2)));
% disp('ranksum d''')
% disp(ranksum(...
% diff(norminv((1-(perfDPA(perfDPA(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==0,6:7)./100*0.98+0.01),1,2),...
% diff(norminv((1-(perfDPA(perfDPA(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==1,6:7)./100*0.98+0.01),1,2)));
% 
   
[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,4),perf(perf(:,3)==0,5),perf(perf(:,3)==1,4),perf(perf(:,3)==1,5)));
fprintf('Dual Miss\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,6),perf(perf(:,3)==0,7),perf(perf(:,3)==1,6),perf(perf(:,3)==1,7)));
fprintf('Dual FA\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,9),perf(perf(:,3)==0,10),perf(perf(:,3)==1,9),perf(perf(:,3)==1,10)));
fprintf('Dual LE\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
[~,~,~,~,p]=mixed_between_within_anova(rearrange(...
norminv((1-(perfDPA(perfDPA(:,3)==0,4)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==0,6)./100*0.98+0.01),...
norminv((1-(perfDPA(perfDPA(:,3)==0,5)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==0,7)./100*0.98+0.01),...
norminv((1-(perfDPA(perfDPA(:,3)==1,4)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==1,6)./100*0.98+0.01),...
norminv((1-(perfDPA(perfDPA(:,3)==1,5)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==1,7)./100*0.98+0.01)...
));
fprintf('Dual DP\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});


if exist('outfile2','var')  && ~isempty(outfile2)
    disp('Miss, FA, LickEff, d''');
    
    figure('Color','w','Position',[100,100,160,180]);
    hold on;
    plotOne([2,1],perfDPA(perfDPA(:,3)==0,4:5),'k');
    plotOne([4,3]+1,perfDPA(perfDPA(:,3)==1,4:5),'b');
    set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
    xlim([0,6]);
    ylim([0,50]);
    ylabel('Miss (%)','FontSize',10);
    print('-depsc','-painters','-r0',sprintf('MissDual_%s.eps',outfile2));
    
    

    figure('Color','w','Position',[300,100,160,180]);
    hold on;    
    plotOne([2,1],perfDPA(perfDPA(:,3)==0,6:7),'k');
    plotOne([4,3]+1,perfDPA(perfDPA(:,3)==1,6:7),'b');
    set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
    xlim([0,6]);
    ylim([0,100]);
    ylabel('False alarm (%)','FontSize',10);
    print('-depsc','-painters','-r0',sprintf('FADual_%s.eps',outfile2));

    figure('Color','w','Position',[500,100,160,180]);
    hold on;    
    plotOne([2,1],perfDPA(perfDPA(:,3)==0,9:10),'k');
    plotOne([4,3]+1,perfDPA(perfDPA(:,3)==1,9:10),'b');
    set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
    xlim([0,6]);
    ylim([50,100]);
    ylabel('Lick efficiency (%)','FontSize',10);
    print('-depsc','-painters','-r0',sprintf('LickEffDual_%s.eps',outfile2));
    
    figure('Color','w','Position',[700,100,160,180]);
    hold on;
    plotOne([2,1],norminv((1-(perfDPA(perfDPA(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==0,6:7)./100*0.98+0.01),'k');
    plotOne([4,3]+1,norminv((1-(perfDPA(perfDPA(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perfDPA(perfDPA(:,3)==1,6:7)./100*0.98+0.01),'b');
    set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
    xlim([0,6]);
    ylim([0,5]);
    ylabel('Sensitivity index (d'')','FontSize',10);
    print('-depsc','-painters','-r0',sprintf('DPrimeDual_%s.eps',outfile2));
%     savefig([outfile2,'.fig']);
%     print([outfile2,'.eps'],'-depsc','-r0');
    
end
% 
% figure('Color','w','Position',[100,100,150,150]);
% hold on;
% plotOne([2,1],perfDPA(perfDPA(:,3)==1,4:5),'b');
% plotOne([4,3]+1,perfDPA(perfDPA(:,3)==1,6:7),'b');




% nDPA1=[perfDPA(:,1),perfDPA(:,3),ones(length(perfDPA),1)];
% nDPA0=[perfDPA(:,2),perfDPA(:,3),ones(length(perfDPA),1)*0];
% 
% toN=[nDPA1;nDPA0];
% fprintf('ttest WT %.3f, ttest ChR2 %.3f\n',pn,p);
% anovan(toN(:,1),{toN(:,2),toN(:,3)},'model','interaction','varnames',{'Gene','Laser'});

% end
end


function [allTrial,perMice]=stats_New_Cri(files,distrType,wtCriteria)

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
            if numel(facSeq)<10
                continue;
            end

%             if numel(facSeq)<50
%                 z.setFullSession(48);
%                 z.processFile(strtrim(f(fidx,:)));
%                 facSeq=z.getFactorSeq();
%                 z.setFullSession(24);
%             end
            facSeq(:,15)=facSeq(:,7);
            facSeq(:,16)=facSeq(:,5);
%             fprintf('%d, %s\n',numel(facSeq),f(fidx,:));
            facSeq=clearBadPerf(facSeq,wtCriteria);
%             facSeq=facSeq(ismember(facSeq(:,6),[3 6]),:);
            if length(facSeq)<50
                continue;
            end
            


            facSeq(facSeq(:,4)==3 | facSeq(:,4)==5,5)=1;%lick
            facSeq(facSeq(:,4)==4 | facSeq(:,4)==6,5)=0;


            facSeq(facSeq(:,4)==3 | facSeq(:,4)==6,4)=1;%correct
            facSeq(facSeq(:,4)==4 | facSeq(:,4)==5,4)=0;
            
                

            facSeq(:,8)=ismember(ids{mice},optoPos);
            if exist('distrType','var') && ~isempty(distrType)
                facSeq=facSeq(ismember(facSeq(:,16),distrType),:);
            end
            
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
                
        
        lickEffOn=sum(oneMice(isPair(oneMice(:,1), oneMice(:,2)) & oneMice(:,3) ,15))*100/sum(oneMice(oneMice(:,3)==1,15));
        lickEffOff=sum(oneMice(isPair(oneMice(:,1), oneMice(:,2)) & oneMice(:,3)==0 ,15))*100/sum(oneMice(oneMice(:,3)==0,15));
        perMice=[perMice;perfOn,perfOff,ismember(ids{mice},optoPos),missOn,missOff,falseOn,falseOff,mice,lickEffOn,lickEffOff];
        
    end
end

    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end

end



function out=clearBadPerf(facSeq,wtCriteria)

    if length(facSeq)>=80
        facSeq(:,5)=0;
        i=80;
        while i<length(facSeq)
            goodOff=sum((facSeq(i-79:i,4)==3 | facSeq(i-79:i,4)==6)& facSeq(i-79:i,3)==0);
            if goodOff>=40*wtCriteria/100  % well trained criteria
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

[~,p]=ttest(y(:,1),y(:,2));
disp(p);

ci=bootci(1000,@(x) mean(x), y(:,2));
plot([x(2)-dd,x(2)-dd],ci,sprintf('-%s',pColor),'LineWidth',1);

ci=bootci(1000,@(x) mean(x), y(:,1));
plot([x(1)+dd,x(1)+dd],ci,sprintf('-%s',pColor),'LineWidth',1);

plot(x(2)-dd,mean(y(:,2)),sprintf('%so',pColor),'MarkerFaceColor','w','MarkerSize',4,'LineWidth',1);
plot(x(1)+dd,mean(y(:,1)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',1);

end

function p=permTest()
dperf=[perf(:,2)-perf(:,1),perf(:,3)];
dCtrl=dperf(dperf(:,2)<0.5,1);
dChR2=dperf(dperf(:,2)>0.5,1);

pool=[dCtrl;dChR2];
currDiff=abs(mean(dChR2)-mean(dCtrl));


rpt=1000;
permDiff=nan(1,rpt);

for i=1:rpt
    pool=pool(randperm(length(pool)));
    permDiff(i)=abs(mean(pool(1:length(dCtrl))-mean(pool(length(dCtrl)+1:end))));
end
p=nnz(permDiff>currDiff)/rpt;

end

function out=rearrange(ctrlOff,ctrlOn,optoOff,optoOn)
out=[ctrlOff,repmat([1,1],length(ctrlOff),1),(1:length(ctrlOff))'];
out=[out;
    ctrlOn,repmat([1,2],length(ctrlOff),1),(1:length(ctrlOff))'];
out=[out;
    optoOff,repmat([2,1],length(optoOff),1),(1:length(optoOff))'+length(ctrlOff)];
out=[out;
    optoOn,repmat([2,2],length(optoOff),1),(1:length(optoOff))'+length(ctrlOff)];
end