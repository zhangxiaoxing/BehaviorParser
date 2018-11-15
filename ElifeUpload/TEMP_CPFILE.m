fs=dnmsfilesN.noLaser;
for idx=1:length(fs)
    fn=lower(fs{idx});
    mkdir(['.\behavior\',regexp(fn,'(?<=d:\\behavior\\).*\','match','once')]);
    status=copyfile(fn,replace(fn,'d:\behavior\','.\behavior\'));
    if ~status
        disp(fn);
        pause();
    end
end

dnmsfiles=struct();
dnmsfiles.delay5s=cellfun(@(x) replace(lower(x),'d:\behavior\','.\behavior\'),dnmsfilesN.delay5s,'UniformOutput',false);
dnmsfiles.delay8s=cellfun(@(x) replace(lower(x),'d:\behavior\','.\behavior\'),dnmsfilesN.delay8s,'UniformOutput',false);
dnmsfiles.delay12s=cellfun(@(x) replace(lower(x),'d:\behavior\','.\behavior\'),dnmsfilesN.delay12s,'UniformOutput',false);
dnmsfiles.baseline=cellfun(@(x) replace(lower(x),'d:\behavior\','.\behavior\'),dnmsfilesN.baseline,'UniformOutput',false);
dnmsfiles.gonogo=cellfun(@(x) replace(lower(x),'d:\behavior\','.\behavior\'),dnmsfilesN.gonogo,'UniformOutput',false);
dnmsfiles.noDelayBaselineResp=cellfun(@(x) replace(lower(x),'d:\behavior\','.\behavior\'),dnmsfilesN.noDelayBaselineResp,'UniformOutput',false);
dnmsfiles.noLaser=cellfun(@(x) replace(lower(x),'d:\behavior\','.\behavior\'),dnmsfilesN.noLaser,'UniformOutput',false);



gainfilesT=struct();
gainfilesT.hemiSilence5s=cellfun(@(x) replace(lower(x),'d:\behaviornew\','d:\behavior2016\2015\'),gainfilesN.hemiSilence5s,'UniformOutput',false);
gainfilesT.hemiSilence8s=cellfun(@(x) replace(lower(x),'d:\behaviornew\','d:\behavior2016\2015\'),gainfilesN.hemiSilence8s,'UniformOutput',false);
gainfilesT.hemiSilence12s=cellfun(@(x) replace(lower(x),'d:\behaviornew\','d:\behavior2016\2015\'),gainfilesN.hemiSilence12s,'UniformOutput',false);
gainfilesT.hemiSilence16s=cellfun(@(x) replace(lower(x),'d:\behaviornew\','d:\behavior2016\2015\'),gainfilesN.hemiSilence16s,'UniformOutput',false);
gainfilesT.hemiSilence20s=cellfun(@(x) replace(lower(x),'d:\behaviornew\','d:\behavior2016\2015\'),gainfilesN.hemiSilence20s,'UniformOutput',false);
gainfilesT.hemiSilence30s=cellfun(@(x) replace(lower(x),'d:\behaviornew\','d:\behavior2016\2015\'),gainfilesN.hemiSilence30s,'UniformOutput',false);
gainfilesT.hemiSilence40s=cellfun(@(x) replace(lower(x),'d:\behaviornew\','d:\behavior2016\2015\'),gainfilesN.hemiSilence40s,'UniformOutput',false);

fs=gainfilesT.hemiSilence40s;
for idx=1:length(fs)
    fn=fs{idx};
    mkdir(['.\behavior\',regexp(fn,'(?<=d:\\behavior2016\\).*\','match','once')]);
    status=copyfile(fn,replace(fn,'d:\behavior2016\','.\behavior\'));
    if ~status
        disp(fn);
        pause();
    end
end


gainfiles=struct();
gainfiles.hemiSilence5s=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),gainfilesT.hemiSilence5s,'UniformOutput',false);
gainfiles.hemiSilence8s=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),gainfilesT.hemiSilence8s,'UniformOutput',false);
gainfiles.hemiSilence12s=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),gainfilesT.hemiSilence12s,'UniformOutput',false);
gainfiles.hemiSilence16s=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),gainfilesT.hemiSilence16s,'UniformOutput',false);
gainfiles.hemiSilence20s=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),gainfilesT.hemiSilence20s,'UniformOutput',false);
gainfiles.hemiSilence30s=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),gainfilesT.hemiSilence30s,'UniformOutput',false);
gainfiles.hemiSilence40s=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),gainfilesT.hemiSilence40s,'UniformOutput',false);



fs=odpafilesn.baseline
for idx=1:length(fs)
    fn=lower(fs{idx});
    mkdir(['d:\behavior\reports\elifeupload\\behavior\',regexp(fn,'(?<=d:\\behavior2016\\).*\','match','once')]);
    status=copyfile(fn,replace(fn,'d:\behavior2016\','d:\behavior\reports\elifeupload\behavior\'));
    if ~status
        disp(fn);
        pause();
    end
end

odpafiles=struct();
odpafiles.DPA_delay_laser=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),odpafilesn.DPA_delay_laser,'UniformOutput',false);
odpafiles.baseline=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),odpafilesn.baseline,'UniformOutput',false);
odpafiles.dualLateBlock=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),odpafilesn.dualLateBlock,'UniformOutput',false);


fs=DPA_Dualtask_Learning.DualLearning
for idx=1:length(fs)
    fn=lower(fs{idx});
    mkdir(['d:\behavior\reports\elifeupload\\behavior\',regexp(fn,'(?<=d:\\behavior2016\\).*\','match','once')]);
    status=copyfile(fn,replace(fn,'d:\behavior2016\','d:\behavior\reports\elifeupload\behavior\'));
    if ~status
        disp(fn);
        pause();
    end
end


duallearning=struct();
duallearning.DualLearning=cellfun(@(x) replace(lower(x),'d:\behavior2016\','.\behavior\'),DPA_Dualtask_Learning.DualLearning,'UniformOutput',false);
duallearning.DPALearning=cellfun(@(x) replace(lower(x),'d:\behaviornew\','.\behavior\'),DPA_Dualtask_Learning.DPALearning,'UniformOutput',false);