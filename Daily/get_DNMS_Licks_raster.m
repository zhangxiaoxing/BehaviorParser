function get_DNMS_Licks_raster(fs,z)

for i=1:length(fs)
    z.processFile(cell(fs(i)));
    l=z.getTrialLick(0);
    l(l(:,3)<2,1)=l(l(:,3)<2,1)+max(l(:,1));


    figure('Color','w','Position',[100,100,400,600]);
    hold on;
    plot(l(:,2),l(:,1),'k.');
    yspan=ylim();
    plot(repmat([0,1000,2500,3000,-5000,-6000],2,1),repmat(yspan',1,6),'--k');
    plot(7500,[l(l(:,3)==10,1);-1],'ko','MarkerFaceColor','k','MarkerSize',4);
    plot(7800,[l(l(:,3)==0,1);-1],'go','MarkerFaceColor','g','MarkerSize',4);
    plot(7200,[l(l(:,3)==2,1);-1],'ro','MarkerFaceColor','r','MarkerSize',4);
    plot(7800,[l(l(:,3)==1,1);-1],'mo','MarkerFaceColor','m','MarkerSize',4);
    plot(7800,[l(l(:,3)==3,1);-1],'co','MarkerFaceColor','c','MarkerSize',4);
    ylim(yspan);
    
    xlim([-10000,8000]);
    ylabel(regexpi(fs(i),'(?<=COM.*\\)78.*?(?=\.ser)','match','once'),'Interpreter','none');
    
    
%     scale=1000/binWidth;
%     fill([1,2,2,1]*scale,[0,0,10,10],[1,0.8,0.8]);
%     fill([15,16,16,15]*scale,[0,0,10,10],[0.8,1,0.8]);
%     fill([17,17.5,17.5,17]*scale,[0,0,10,10],[0.8,0.8,1]);
%     if distractor
%         fill([3,4,4,3]*scale,[0,0,10,10],[1,1,0.8]);
%     end
%     ss=std(out);
%     sem=ss/sqrt(length(fs));
%     bar(mean(out),'FaceColor',[0.5,0.5,0.5],'EdgeColor','none');
%     errorbar(mean(out),sem,'k.');
%     set(gca,'XTick',0:10:100,'XTickLabel',strsplit(num2str(0:2:20),' '));
%     xlim([0,21]*scale);
%     ylim([0,10]);
%     xlabel('Time (s)');
%     ylabel('Lick frequency (Hz)');
%     title([ftitle,', n = ',num2str(size(out,1))]);
% pause();
end
end



