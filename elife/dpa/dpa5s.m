%SamplePort,TestPort,Laser,3/4/5/6->Hit/Miss/False/CR,ResponseLick#,CueOnsetTS,delayLen
classdef dpa5s < handle
    methods (Static)
        function perMice=run()
            perMice=struct();
            javaaddpath('I:\java\zmat\build\classes\');
            z=zmat.Zmat;
            z.setFullSession(20);
            z.setMinLick(0);
            z.updateFilesList({'D:\Behavior2017\'});
%             fs=cell(z.listFiles({'dpa','6sample','-learning','-shaping','-distr','-eml','-both','-dr','-nphr','-2afc','-nolaser','-elife','-block'}));
            fs=cell(z.listFiles({'dpa','8sdelay','-6sample'}));
            
            ids=unique(regexpi(fs,'(?<=\\)[0123456789P]{3,6}(?=_)','match','once'));
            ids=unique(replace(ids,'P',''));
            NPHR={'7816';'7826';'783';'784';'7846';'781';'782';'7814'};
            
            for mice=1:length(ids)
                fmice=fs(contains(fs,['\',ids{mice},'_']) | contains(fs,['\',replace(ids{mice},'78','78P'),'_']));
                
                z.processFile(fmice);
                faq=dpa5s.wellTrained(z.getFactorSeqSess(false,false),80);
                perMice.perf(mice,1:2)=[mean(ismember(faq(faq(:,3)==0,4),[3 6])),mean(ismember(faq(faq(:,3)==1,4),[3 6]))];
                perMice.opto(mice)=ismember(upper(ids{mice}),NPHR);
            end
            figure();
            hold on;
            plot([1 2],perMice.perf(perMice.opto==0,[1 2]),'-ko');
            plot([3 4],perMice.perf(perMice.opto==1,[1 2]),'-bo');
            
        end
        
        function out=wellTrained(in,thresh)
                sel=false(1,size(in,1));
            for i=1:size(in,1)
                t=squeeze(in(i,:,:));
                sel(i)=(mean(ismember(t(t(:,3)==0,4),[3 6])).*100)>=thresh;
            end
            out=squeeze(reshape(in(sel,:,:),1,[],10));
        end
        function others
            close all
        end
    end
end
