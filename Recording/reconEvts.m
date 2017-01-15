function out=reconEvts(plexFile,spData)
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

