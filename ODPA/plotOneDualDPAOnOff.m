function plotOneDual(data,measure,tag)
path(path,'I:\behavior\reports\z');

%chr2,distr,laser
%---,--+,-+-,-++,+--,+-+,++-,+++

chr2=strcmpi('ChR2',data(:,6));
distr=strcmpi('dpa',data(:,10));
laser=strcmpi('lightOn',data(:,5));
barData=cell(0,0);
anovaData=nan(0,0);
barIdx=1;
for iterChR2=[false,true]
    for iterDistr=[false,true]
        for iterLaser=[false,true]
            barData{barIdx}=data(chr2==iterChR2 & distr==iterDistr & laser==iterLaser, measure);
            rpt=length(barData{barIdx});
            anovaData=vertcat(anovaData,[cell2mat(barData{barIdx}),ones(rpt,1)+iterLaser*1,ones(rpt,1)+iterDistr*1,ones(rpt,1)+iterChR2*1,]);
            barIdx=barIdx+1;
        end
    end
end

fmean=nan(1,length(barData));
fsem=nan(1,length(barData));
for i=1:length(barData)
    fmean(i)=mean(cell2mat(barData{i}));
    fstd=std(cell2mat(barData{i}));
    fsem(i)=fstd/sqrt(length(barData{i}));
end


figure('Color','w','Position',[100 100 400 300]);
subplot('Position',[0.2,0.27,0.75,0.63]);
hold on;
bar(fmean,'FaceColor','k');
errorbar(1:length(fsem),fmean,fsem,'k.');
xlim([0,length(fmean)+1]);
if min(fmean)>50
    ylim([50,100]);
end
set(gca,'XTick',[]);
ylabel(tag);
yspan=ylim();
dy=diff(yspan)/50;
ypos=[yspan(1)-18*dy,yspan(1)-13*dy,yspan(1)-8*dy];
xpos=[-1,1:length(fmean)];

chr2Tag={'VGATChR2','-','-','-','-','+','+','+','+'};
distrTag={'ODPA','-','-','+','+','-','-','+','+'};
laserTag={'Laser','-','+','-','+','-','+','-','+'};

tags={chr2Tag,distrTag,laserTag};
tagRow=1;



for yy=ypos
    currentRow=tags{tagRow};
    tagColumn=1;
    for xx=xpos
        text(xx,yy,currentRow{tagColumn},'HorizontalAlignment','center');
        tagColumn=tagColumn+1;
    end
    tagRow=tagRow+1;
end


anovan(anovaData(:,1),{anovaData(:,2),anovaData(:,3),anovaData(:,4)},'varnames',{'Laser','ODPA','ChR2'},'model','full');
end