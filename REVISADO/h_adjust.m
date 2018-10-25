function [Hi,Hk] = h_adjust(hi,hk,nd)

if isempty(hk)
    for i=1:length(hi{1})
        for d=1:nd;
            Hi{i}(d,d) =hi{d}(i)^2;
        end
    end
    Hk=[];
end
if isempty(hi)
    for i=1:length(hk{1})
        for d=1:nd;
            Hk{i}(d,d) =hk{d}(i)^2;
        end
    end
    Hi=[];
end