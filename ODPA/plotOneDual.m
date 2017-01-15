function plotOneDual(data,measure,tag, forppt)
path(path,'D:\behavior\reports\z');

%chr2,distr,laser
%---,--+,-+-,-++,+--,+-+,++-,+++

chr2=strcmpi('ChR2',data(:,6));
distr=strcmpi('distr',data(:,10));
laser=strcmpi('lightOn',data(:,5));
barData=cell(0,0);
anovaData=nan(0,0);
barIdx=1;
for iterChR2=[false,true]
    for iterDistr=[false,true]
        for iterLaser=[false,true]
            barData{barIdx}=data(chr2==iterChR2 & distr==iterDistr & laser==iterLaser, measure);
            rpt=length(barData{barIdx});
%             anovaData=vertcat(anovaData,[cell2mat(barData{barIdx}),ones(rpt,1)+iterLaser*1,ones(rpt,1)+iterDistr*1,ones(rpt,1)+iterChR2*1,]);
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

if(~forppt)
    figure('Color','w','Position',[100 100 400 300]);
    subplot('Position',[0.2,0.27,0.75,0.63]);
end
hold on;
ec={'b','k'};
fc=[0.4,0.4,0.4;1,1,1];
for i=1:8
    bar(i,fmean(i),'FaceColor','w','EdgeColor',ec{mod(i,2)+1},'LineWidth',1,'FaceColor',fc(idivide(i-1,int32(4))+1,:));
end
errorbar(1:length(fsem),fmean,fsem,'k.','LineWidth',1);
xlim([0,length(fmean)+1]);
yspan=ylim;
if min(fmean)>50
    ylim([50,100]);
else
    ylim([0,yspan(2)]);
end
set(gca,'XTick',[]);
ylabel(tag);
yspan=ylim();
dy=diff(yspan)/50;
ypos=[yspan(1)-18*dy,yspan(1)-13*dy,yspan(1)-8*dy];
xpos=[-1,1:length(fmean)];

chr2Tag={'VGATChR2','-','-','-','-','+','+','+','+'};
distrTag={'Distractor','-','-','+','+','-','-','+','+'};
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


% [~,tbl]=anovan(anovaData(:,1),{anovaData(:,2),anovaData(:,3),anovaData(:,4)},'varnames',{'Laser','Distr','ChR2'},'model','full','display','off');

for i=2:8
    text(0,yspan(1)-(5*(i+2)+8)*dy,[tbl{i,1},' p = ', num2str(tbl{i,7},'%.4f')],'HorizontalAlignment','Left');
end


end