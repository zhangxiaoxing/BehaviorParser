classdef zxRec < handle
    methods
        function out=reconEvts(obj,plexFile,spData)
            rawPlexQ=plexFile.events{2,1}.timestamps;
            PlexQ=int32(rawPlexQ([true;diff(rawPlexQ)>1])*1000);
            spQ=spData(spData(:,3)==9 &spData(:,4)==1,1);
            
            dSpQ=spQ(1);
            spQ=spQ-spQ(1)+1;
            
            plts=zeros(PlexQ(end),1);
            plts(PlexQ)=1;
            
            spts=zeros(spQ(end),1);
            spts(spQ)=1;
            
            [acor,lag]=xcorr(plts,spts);
            [~,I]=max(abs(acor));
            lagdiff=lag(I);
            out=[(spData(:,1)-dSpQ+lagdiff+1)/1000,spData(:,2:5)];
        end
        
        function out=tagSpk(obj,spk)
            spkid=spk(:,1)*256+spk(:,2);
            [~,~,ic]=unique(spkid(:,1));
            out=zeros(length(spk),5);
            out(:,1)=spk(:,3);
            out(:,2)=hex2dec('55');
            out(:,3)=hex2dec('EE');
            out(:,4)=ic;
            out(:,5)=hex2dec('AA');
        end
        
        function out=combineMat(obj,spData,spk)
            nspData=[spData;spk];
            out=sortrows(nspData,1);
        end
    end
    
    
end
