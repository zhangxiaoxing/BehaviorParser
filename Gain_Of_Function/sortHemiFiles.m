measures={'perf','false','miss','dpc','lickEff'};

for i=1:length(measures)
out5.(measures{i})=[out5.(measures{i});nan(1,10)];
end

out=struct();

for i=1:length(measures)
out.(measures{i})=nan(18,10);
out.(measures{i})(:,1:2)=out8.(measures{i})(:,1:2);
out.(measures{i})(:,8)=out5.(measures{i})(:,3);
out.(measures{i})(:,9)=out8.(measures{i})(:,3);
out.(measures{i})(:,10)=out12.(measures{i})(:,3);
end


