function out=myfun(nexFile)

qts=meaningfulTS(nexFile.events{2,1}.timestamps,9);
rts=meaningfulTS(nexFile.events{3,1}.timestamps,10);

    function out=meaningfulTS(TS,tag)
        out(:,1)=TS([true;diff(TS)>1]);
        out(:,2)=tag;
    end

out=sortrows([qts;rts]);
end




