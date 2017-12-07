function [xlimit,A] = MINMAX(sg,method,name,TH)
ngrid = 10000000;
if strcmp(method,'probmax')
   
end

if strcmp(method,'cdfdata')
    [xlimit,A] = cdfdata(sg.evt,TH,ngrid);
end


% plot(xest,yest); hold on
% plot(xlimit(1),0,'or',xlimit(2),0,'or')


end