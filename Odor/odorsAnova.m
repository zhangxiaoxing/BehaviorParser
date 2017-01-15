classdef odorsAnova < handle
    properties
        data;
    end
    
    properties (Access=private)
    ctrl;
    off;
    end
    
    methods
        function obj=odorsAnova(data)
            obj.data=data;
            obj.ctrl=strcmp('ctrl',obj.data(:,6));
            obj.off=strcmp('lightOff',obj.data(:,5));
        end
        
        
        function out=f(obj)
            out=[obj.groupAnovan(2);
                obj.groupAnovan(3);
                obj.groupAnovan(4)];
        end
        
        function out=groupAnovan(obj,idx)
            out=[
            obj.anovan(obj.ctrl & obj.off,idx),...
            obj.anovan(obj.ctrl & ~obj.off,idx),...
            obj.anovan(~obj.ctrl & obj.off,idx),...
            obj.anovan(~obj.ctrl & ~obj.off,idx)];
        end
        
        function out=anovan(obj,filter,idx)
            perf=obj.data(filter,[idx,8]);
            out=anovan(cell2mat(perf(:,1)),{perf(:,2)},'display','off');
        end
    end
end