fs=z.listFiles({'2','-mW','-Hz','-Odor','-Shap','-8s','-LR'});
for i=length(fs):-1:1
    cf=char(fs(i));
    z.processLickFile(cf);
    p=z.getPerf(2,50);
    if size(p,1)<3
        continue;
    end
    if sum([p(:,1);p(:,4)])<40 || sum([p(:,1);p(:,4)])>48
        continue;
    end
    currLick=z.getTrialLick(50);
    strTitle=regexp(cf,'(?<=\\.*_\d{4}_.*?\\).*?(?=\.ser$)','match');
    plotExample(currLick,strTitle);
%     title(cf);
%     pause;
    close(gcf);
end