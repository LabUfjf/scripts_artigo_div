function [xlimit,A] = cdfpdf(sg,name,TH,ngrid)

    Mi = min(sg.pdf.truth.x);
    Ma= max(sg.pdf.truth.x);
    xest=linspace(Mi,Ma,ngrid);
    yest = GridNew(sg,xest,name);
    
    cdf=cumsum(yest)/max(cumsum(yest));
    [~,ind] = unique(cdf);
    
    TH = TH/2;
    xlimit(1) = interp1(cdf(ind),xest(ind),TH,'linear','extrap');
    xlimit(2) = interp1(cdf(ind),xest(ind),1-TH,'linear','extrap');
    
    xest=linspace(xlimit(1),xlimit(2),ngrid);
    yest = GridNew(sg,xest,name);
    A=rsum(xest,yest,'mid');
    
end