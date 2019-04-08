

perfdata=perf5;
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==0,1),perfdata(perfdata(:,3)==0,2)));
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==1,1),perfdata(perfdata(:,3)==1,2)));






perfdata=perf8;
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==0,1),perfdata(perfdata(:,3)==0,2)));
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==1,1),perfdata(perfdata(:,3)==1,2)));







perfdata=perf12;
disp('perf')
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==0,1),perfdata(perfdata(:,3)==0,2)));
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==1,1),perfdata(perfdata(:,3)==1,2)));
disp('false')
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==0,4),perfdata(perfdata(:,3)==0,5)));
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==1,4),perfdata(perfdata(:,3)==1,5)));
disp('false')
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==0,4),perfdata(perfdata(:,3)==0,5)));
disp(OptoMisc.pairedPermTest(perfdata(perfdata(:,3)==1,4),perfdata(perfdata(:,3)==1,5)));
