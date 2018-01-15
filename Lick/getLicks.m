function out=getLicks(type)
% javaaddpath('I:\java\zmat\build\classes\');
javaaddpath('I:\java\zmat\build\classes\')
z=zmat.Zmat;
load('lickFiles.mat');
z.setMinLick(0);
n=size(fs,1);
optoPos=[33 38 41 101 102 106 107 66 67 76 78 80 81 83 1 7 9 14 15];
bj=[32 33 700 701 702 703 704 707 101 102 103 105 106 107 108 109];
mk=[37 38 40 41 64 65 66 67];
rq=[76 77 78 79 80 81 82 83 1:15];
miceCount=0;
switch type
    case 0
        out=NaN(1,4);
        for i=1:n
            f=char(fs(i));
            [p1,p2]=regexp(f,'\\\d+_');
            mice=str2num(f(p1(size(p1,2))+1:p2(size(p2,2))-1));
            
            if ~ismember(mice,optoPos)
                continue;
            end
            
            z.processLickFile(f);
            licks=z.getLick(100);
            
            if ismember(mice,bj)
                odor=[1 2];
            elseif ismember(mice,mk)
                odor=[3 4];
            elseif ismember(mice,rq)
                odor=[5 6];
            else
                odor=[NaN NaN];
            end
            
            
            
            idx=miceCount*4;
            
            out(idx+1,:)=[mean(licks(licks(:,2)==1 & licks(:,3)==0,1)),odor(1),0,mice];
            out(idx+2,:)=[mean(licks(licks(:,2)==1 & licks(:,3)==1,1)),odor(1),1,mice];
            out(idx+3,:)=[mean(licks(licks(:,2)==0 & licks(:,3)==0,1)),odor(2),0,mice];
            out(idx+4,:)=[mean(licks(licks(:,2)==0 & licks(:,3)==1,1)),odor(2),1,mice];
            
            miceCount=miceCount+1;
        end
        
    otherwise
        miceCount=1;
        out=NaN(1,4);
        for i=1:n
            f=char(fs(i));
            [p1,p2]=regexp(f,'\\\d+_');
            mice=str2num(f(p1(size(p1,2))+1:p2(size(p2,2))-1));
            
            if ~ismember(mice,optoPos)
                continue;
            end
            
            if type==1 && ~ismember(mice,bj)
                continue;
            end
            if type==2 && ~ismember(mice,mk)
                continue;
            end
            
            if type==3 && ~ismember(mice,rq)
                continue;
            end
            
            z.processLickFile(f);
            licks=z.getLick(100);
            
            
            
            
            
            out(miceCount,:)=[mean(licks(licks(:,2)==1 & licks(:,3)==0,1)),...
                mean(licks(licks(:,2)==1 & licks(:,3)==1,1)),...
                mean(licks(licks(:,2)==0 & licks(:,3)==0,1)),...
                mean(licks(licks(:,2)==0 & licks(:,3)==1,1))];
            
            miceCount=miceCount+1;
        end
end
end