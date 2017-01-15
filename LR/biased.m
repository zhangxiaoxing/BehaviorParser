function biased(file, showall)
p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end
z=zmat.Zmat;


    for i=1:length(file)
        f=file{i};
        tm=z.ser2mat(f);
        if numel(tm)>5
            tl=sum((tm(:,3)==4 | tm(:,3)==7) & tm(:,4)==2);
            tr=sum((tm(:,3)==4 | tm(:,3)==7) & tm(:,4)==3);
            bias=(tl-tr)/(tl+tr)*100;
            if bias>50 || (exist('showall','var') && showall==1)
                fprintf('%.2f, %s\n',bias,f);
            end
        end
    end
end