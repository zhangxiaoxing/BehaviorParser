classdef refine < handle
    properties
        sess;
        m;
        z;
        defpath='D:\behaviorNew\';
        f;
    end
    
    methods
        function obj=refine()
            javaaddpath('I:\java\zmat\build\classes\');
            obj.z=zmat.Zmat;
        end
        
        function update(obj,path)
            obj.z.updateFilesList(path);
        end
        
        function open(obj,keywords)
            fl=cell(obj.z.listFiles(keywords));
            if length(fl)~=1
                fprintf('Bad Keywords, return file number = %d',length(fl));
            else
                m=obj.z.ser2mat(fl{1});
                obj.f=fl{1};
                obj.m=m;
                obj.sess=obj.updateSess(m);
            end
        end
        
        function sessOut=updateSess(obj,m)
            sessOut=[];
            sess=[find(m(:,3)==61),m(m(:,3)==61,4)];
            idx=1;
            for i=2:length(sess)
                if sess(i,2)==0 && sess(i-1,2)==1 && sess(i,1)-sess(i-1,1)>6
                    sessStart=sess(i-1,1);
                    sessEnd=sess(i,1);
                    fa=sum(m(sessStart:sessEnd,3)==4);
                    cr=sum(m(sessStart:sessEnd,3)==5);
                    ms=sum(m(sessStart:sessEnd,3)==6);
                    ht=sum(m(sessStart:sessEnd,3)==7);
                    sessOut=[sessOut;sessStart,sessEnd,ht,ms,fa,cr,(ht+cr)*100/(ht+ms+fa+cr),idx];
                    idx=idx+1;
                end
            end
        end
        
        function removeSess(obj,idx)
            m=obj.m;
            
            sessStart=obj.sess(idx,1);
            sessEnd=obj.sess(idx,2);
            m(sessStart:sessEnd,:)=[];
            dt=m(sessStart,1)-m(sessStart-1,1);
            m(sessStart:end,1)=m(sessStart:end,1)-dt+20;
            
            obj.m=m;
            obj.sess=obj.updateSess(m);
        end
        
        function write(obj)
            obj.z.mat2ser(obj.m,obj.f);
        end
   
    end
end