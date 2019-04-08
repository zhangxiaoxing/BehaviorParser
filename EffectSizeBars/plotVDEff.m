classdef plotVDEff <handle
    methods(Static)
        function plot()
            fstr=load('effSize.mat');
%             plotVDEff.plotOne(fstr.VD12S(1,:),fstr.VD12S(2,:),'ES12SPERF','correct rate',[-2.5,0.5]);
%             plotVDEff.plotOne(fstr.VD12S(3,:),fstr.VD12S(4,:),'ES12SFA','false alarm',[-0.5,2.5]);
%             plotVDEff.plotOne(fstr.VD12S(5,:),fstr.VD12S(6,:),'ES12SMISS','miss',[-1.5,1.5]);
%             
%             
%             plotVDEff.plotOne(fstr.VD20S(1,:),fstr.VD20S(2,:),'ES20SPERF','correct rate',[-2.5,0.5]);
%             plotVDEff.plotOne(fstr.VD20S(3,:),fstr.VD20S(4,:),'ES20SFA','false alarm',[-0.5,2.5]);
%             plotVDEff.plotOne(fstr.VD20S(5,:),fstr.VD20S(6,:),'ES20SMISS','miss',[-1.5,1.5]);
            
            plotVDEff.plotOne(fstr.VDVARD(2,:),fstr.VDVARD(1,:),'ESVDSPERF','correct rate',[-2.5,0.5]);
            plotVDEff.plotOne(fstr.VDVARD(4,:),fstr.VDVARD(3,:),'ESVDSFA','false alarm',[-1.5,1.5]);
            plotVDEff.plotOne(fstr.VDVARD(6,:),fstr.VDVARD(5,:),'ESVDSMISS','miss',[-1.5,1.5]);
        end
        
        
        function plotOne(ctrl,opto,fn,lbl,yspan)

            fh=figure('Color','w','Position',[100,100,230,200]);
            hold on;
            xlen=size(ctrl,2);
            bar((1:xlen)-0.225,ctrl,0.45,'k','EdgeColor','none');
            if size(ctrl,2)==7
                bar((1:3)+0.225,opto(1:3),0.45,'EdgeColor','k','FaceColor',[0,51,204]./255);
                bar((4:6)+0.225,opto(4:6),0.45,'EdgeColor','k','FaceColor',[86,180,233]./255);
                bar(7+0.225,opto(7),0.45,'EdgeColor','k','FaceColor',[0,158,115]./255);
            elseif size(ctrl,2)==9
                bar((1:3)+0.225,opto(1:3),0.45,'EdgeColor','k','FaceColor',[0,51,204]./255);
                bar((4:6)+0.225,opto(4:6),0.45,'EdgeColor','k','FaceColor',[86,180,233]./255);
                bar((7:9)+0.225,opto(7:9),0.45,'EdgeColor','k','FaceColor',[0,158,115]./255);
            elseif size(ctrl,2)==4
                bar((1:4)+0.225,opto(1:4),0.45,'EdgeColor','k','FaceColor',[0,51,204]./255);
            end
            
            if size(ctrl,2)==7
                set(gca,'XTick',1:7,...%10,...
                    'XTickLabel',{'3s Early','3s Mid','3s Late','6s Early','6s Mid','6s Late','10s'},...%,'6s BL','10s BL'},...
                    'XTickLabelRotation',60,'FontSize',10);
            elseif size(ctrl,2)==9
                set(gca,'XTick',1:9,...%11,...
                    'XTickLabel',{'3s Early','3s Mid','3s Late','6s Early','6s Mid','6s Late','12s Early','12s Mid','12s Late'},...,'10s BL'},...
                    'XTickLabelRotation',60,'FontSize',10);
            elseif size(ctrl,2)==4
                set(gca,'XTick',1:4,...
                    'XTickLabel',{'5s','8s','12s','20s'},...
                    'XTickLabelRotation',60,'FontSize',10);
            end
            ylabel(sprintf('Effect size, %s',lbl));
            ylim(yspan);
            print(fh,'-depsc','-painters',sprintf('%s.eps',fn));
%             close(fh);
            
        end
    end
end