classdef plotEff <handle
    methods(Static)
        function plot()
            fstr=load('effSize.mat');
            plotEff.plotOne(fstr.optos(1,1:2:5),fstr.optos(1,2:2:6),'ESOptosPERF','correct rate',[-2.75,0]);
            plotEff.plotOne(fstr.optos(2,1:2:5),fstr.optos(2,2:2:6),'ESOptosMiss','miss rate',[-2.75,0]);
            plotEff.plotOne(fstr.optos(3,1:2:5),fstr.optos(3,2:2:6),'ESOptosFA','false alarm',[0,2.75]);
            plotEff.plotOne(fstr.optos(4,1:2:5),fstr.optos(4,2:2:6),'ESOptosLickEff','lick efficiency',[-2.75,0]);
            plotEff.plotOne(fstr.optos(5,1:2:5),fstr.optos(5,2:2:6),'ESOptosDp','Sensitivity index (d'')',[-2.75,0]);
        end
        
        function plotDPA()
            fstr=load('effSize.mat');
            plotEff.plotOne(fstr.dpas(2:2:6,1),fstr.dpas(1:2:5,1),'ESDPAPERF','correct rate',[-1.5,1.5]);
            plotEff.plotOne(fstr.dpas(2:2:6,2),fstr.dpas(1:2:5,2),'ESDPAsMiss','miss rate',[-1.5,1.5]);
            plotEff.plotOne(fstr.dpas(2:2:6,3),fstr.dpas(1:2:5,3),'ESDPAFA','false alarm',[-1.5,1.5]);
            plotEff.plotOne(fstr.dpas(2:2:6,4),fstr.dpas(1:2:5,4),'ESDPALickEff','lick efficiency',[-1.5,1.5]);
            plotEff.plotOne(fstr.dpas(2:2:6,5),fstr.dpas(1:2:5,5),'ESDPADp','Sensitivity index (d'')',[-1.5,1.5]);
        end
        
        
        function plotOne(ctrl,opto,fn,lbl,yspan)
            fh=figure('Color','w','Position',[100,100,230,250]);
            hold on;
            xlen=numel(ctrl);
            bar((1:xlen)-0.225,ctrl,0.45,'k','EdgeColor','none');
            bar((1:xlen)+0.225,opto,0.45,'EdgeColor','k','FaceColor',[0,51,204]./255);

            %                 'XTickLabel',{'5s','8s','12s'},...
            
            set(gca,'XTick',1:3,...
                'XTickLabel',{'Simple DPA','Dual-task DPA','Dual-task baseline'},...
                'XTickLabelRotation',60,'FontSize',10);
            ylabel(sprintf('Effect size, %s',lbl));
            ylim(yspan);
            print(fh,'-depsc','-painters',sprintf('%s.eps',fn));
            close(fh);
            
        end
        
        
        function plotCtrlEff(ctrls)
            fh=figure('Color','w','Position',[100,100,230,200]);
            hold on;
            xlen=size(ctrls,2);
            bar((1:xlen)-0.225,ctrls(2,:),0.45,'k','EdgeColor','none');
            bar((1:xlen)+0.225,ctrls(1,:),0.45,'EdgeColor','none','FaceColor',[0,51,204]./255);

            set(gca,'XTick',1:5,...
                'XTickLabel',{'3s baseline','6s baseline','10s baseline','GNG','NMSWOD'},...
                'XTickLabelRotation',60,'FontSize',10);
            ylabel('Effect size, correct rate');
            ylim([-1.5,1.5]);
            print(fh,'-depsc','-painters','EffCtrls.eps');
            close(fh);
        end
    end
end