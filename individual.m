f=z.listFiles({'83','Base','-NDelay'})
for i=1:size(f,1)
z.processFile(char(f(i)));
r=[z.getHitFalseMiss(false,50)',z.getHitFalseMiss(true,50)'];
disp(r)
end