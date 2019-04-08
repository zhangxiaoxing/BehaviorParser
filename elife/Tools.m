classdef Tools < handle
    properties (Constant)
        thres=15;
    end
    
    methods (Static)
        function out=clearLicklessTrialsAlt(faq)
            before=size(faq,1);
            out=[];
            if size(faq,1)>=25
                lickless=ismember(faq(:,4),[4 6]);
                for i=1:size(faq,1)-24
                    if nnz(lickless(i:i+24))==25
                        out=faq(1:i,:);
                        break;
                    end
                end
                if isempty(out)
                    out=faq;
                end
            else
                out=[];
            end
            after=size(out,1);
            if before~=after
                fprintf('Missing lick, before %d, after %d\n',before,after);
            end
        end
        
        function out=clearLicklessTrials(faq)
            before=size(faq,1);
            tfaq=[faq,(1:before).'];
            tfaq=tfaq(ismember(faq(:,4),[3,4]),:);
            out=[];
            if size(tfaq,1)>=Tools.thres
                lickless=(tfaq(:,4)==4);
                for i=1:size(lickless,1)-(Tools.thres-1)
                    if nnz(lickless(i:i+Tools.thres-1))==Tools.thres
                        out=faq(1:tfaq(i,end),:);
                        break;
                    end
                end
                if isempty(out)
                    out=faq;
                end
            else
                out=[];
            end
            after=size(out,1);
            if before~=after
                fprintf('Missing lick, before %d, after %d\n',before,after);
            end
        end
        
        function out=clearContLickAlt(faq)
            before=size(faq,1);
            out=[];
            if before>=25
                contLick=ismember(faq(:,4),[3 5]);
                for i=size(faq,1):-1:25
                    if nnz(contLick(i-24:i))==25
                        out=faq(i:end,:);
                        break;
                    end
                end
                if isempty(out)
                    out=faq;
                end
            else
                out=[];
            end
            after=size(out,1);
            if before~=after
                fprintf('Cont. lick, before %d, after %d\n',before,after);
            end
        end
        
        function out=clearContLick(faq)
            before=size(faq,1);
            tfaq=[faq,(1:before).'];
            tfaq=tfaq(ismember(faq(:,4),[5,6]),:);
            out=[];
            if size(tfaq,1)>=Tools.thres
                contLick=(tfaq(:,4)==5);
                for i=size(contLick,1):-1:Tools.thres
                    if nnz(contLick(i-(Tools.thres-1):i))==Tools.thres
                        out=faq(tfaq(i,end):end,:);
                        break;
                    end
                end
                if isempty(out)
                    out=faq;
                end
            else
                out=[];
            end
            after=size(out,1);
            if before~=after
                fprintf('Cont. lick, before %d, after %d\n',before,after);
            end
        end
       
        function out=clearBadPerfAlt2(facSeq)
            
            if length(facSeq)>=80
                facSeq(:,5)=0;
                i=80;
                while i<length(facSeq)
                    goodOff=nnz((facSeq(i-79:i,4)==3 | facSeq(i-79:i,4)==6)& facSeq(i-79:i,3)==0);
                    if goodOff>=nnz(facSeq(i-79:i,3)==0)*80/100
                        %             if goodOff>=32
                        if facSeq(i-79,3)==0
                            facSeq(i-79:i-1,5)=1;
                        else
                            facSeq(i-78:i,5)=1;
                        end
                        %             facSeq(i-79:i,5)=1;
                    end
                    i=i+1;
                end
                out=facSeq(facSeq(:,5)==1,:);
            else
                out=[];
            end
        end
        
        function [out, wellTrained]=clearBadPerfAlt(facSeq,thres)
            wellTrained=false;
            if length(facSeq)>=40
                wtTrials=false(size(facSeq,1),1);
                i=40;
                while i<length(facSeq)
                    good=nnz(ismember(facSeq(i-39:i,4),[3 6]));
                    if good>=40*thres/100
                            wtTrials(i-39:i,1)=true;
                            wellTrained=true;
                    end
                    i=i+1;
                end
                out=facSeq(wtTrials,:);
            else
                out=[];
            end
        end
        
    end
end