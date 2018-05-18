% fs=[dnmsfiles.delay5s;dnmsfiles.delay8s;dnmsfiles.delay12s;dnmsfiles.baseline];
% ids=unique(string(regexpi(fs,'\\201\d\\.{2,5}(\\.{2,6}_)20','tokens','once')));
% fl=cell(0,0);
% for ididx=1:length(ids)
% %     fl=[fl;cell(z.listFiles({char(ids(ididx)),'-mw','-shap','-chr2','-nphr','-lr','-teach','-water','-odor','-8s','-12s','-temp','-nodelay','-4s','-last'}))];
%     flt=cell(z.listFiles({char(ids(ididx)),'-mw','-shap','-chr2','-nphr','-lr','-teach','-water','-odor','-8s','-12s','-temp','-nodelay','-4s','-last'}));
%     
%     perfs=nan(1,length(flt));
%     for fidx=1:length(flt)
%         z.processFile(flt(fidx));
%         tperf=z.getPerf(0,0,false);
%         if numel(tperf)>5
%             perfs(fidx)=sum(sum(tperf(:,[1 4])))/sum(tperf(:,5));
%         end
%     end
%     perfs(isnan(perfs))=-1;
%     [m,i]=max(perfs);
%     if m>0.8
%         fl=[fl;flt(i)];
%     end
% %     fl=[fl;cell(z.listFiles({char(ids(ididx)),'baselineNDelay'}))];
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Best performing 12s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs=dnmsfiles.delay5s;
ids=unique(string(regexpi(fs,'\\201\d\\.{2,5}(\\.{2,6}_)20','tokens','once')));
fl=cell(0,0);
for ididx=1:length(ids)
%     fl=[fl;cell(z.listFiles({char(ids(ididx)),'-mw','-shap','-chr2','-nphr','-lr','-teach','-water','-odor','-8s','-12s','-temp','-nodelay','-4s','-last'}))];
    flt=cell(z.listFiles({char(ids(ididx)),'_3s_','-Qtr','-Shap','-Base','-Odor','-Resp','-NoLaser'}));
    
    perfs=nan(1,length(flt));
    for fidx=1:length(flt)
        z.processFile(flt(fidx));
        tperf=z.getPerf(0,0,false);
        if numel(tperf)>5
            perfs(fidx)=sum(sum(tperf(:,[1 4])))/sum(tperf(:,5));
        end
    end
    perfs(isnan(perfs))=-1;
    [m,i]=max(perfs);
    if m>0.8
        fl=[fl;flt(i)];
    end
%     fl=[fl;cell(z.listFiles({char(ids(ididx)),'baselineNDelay'}))];
end
