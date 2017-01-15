% javaaddpath('I:\java\zmat\dist\zmat.jar');
% z=zmat.Zmat;
for m=[93:95 98 99 102 103 106]
    z.listFiles('I:\Behavior\2014\',{num2str(m),'LR_DNMS_4s_Delay'});
    z.setMinLick(4);
    if(size(char(ans),1)>0)
        z.processLickFile(ans);
        l=z.getLicks(true(1));
        figure(m);
        hold on;

        for i=1:size(l,1);
            tll=double(l(i,l(i,:,2)==2,1));
            tlr=double(l(i,l(i,:,2)==3,1));
            if(size(tl./1000,1)>0)
                if(size(tll,1)>0)
                    plot(tll,i,'r.');
                end
                if(size(tlr,1)>0)
                    plot(tlr,i,'b.');
                end
            end
        end
    end
end