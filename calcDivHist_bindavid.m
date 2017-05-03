function [binstail1 ,binstail2 ,binshead1 ,binshead2 ,binsderiv1 ,binsderiv2 ] = calcDivHist_bindavid(DATA,sg)

type='nearest';

for nv = 1:size(DATA,1);
    
    xpdf.sg=sg.gauss.pdf.x;
    ypdf.sg=sg.gauss.pdf.y;
    
    %     [xpdf,ypdf]=getAnalytical(sg,bg,nv);
    [ind]=findregion2(xpdf);
    
    DATASG.TR=DATA(nv,:);
    
    [x.tr.sg,y.tr.sg]=data_normalized(DATASG.TR,calcnbins(DATASG.TR,'fd'));
    
    [ binstail1 ] = BinFind(xpdf.sg.eq.tail(1:(end/2)),x.tr.sg);
    [ binstail2 ] = BinFind(xpdf.sg.eq.tail(((end/2)+1):end),x.tr.sg);
    
    [ binshead1 ] = BinFind(xpdf.sg.eq.head(1:(end/2)),x.tr.sg);
    [ binshead2 ] = BinFind(xpdf.sg.eq.head(((end/2)+1):end),x.tr.sg);
    
    [ binsderiv1 ] = BinFind(xpdf.sg.eq.deriv(1:(end/2)),x.tr.sg);
    [ binsderiv2 ] = BinFind(xpdf.sg.eq.deriv(((end/2)+1):end),x.tr.sg);
    
    
%     y.ptr.sg.all = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.all,type,'extrap');
%     
%     y.ptr.sg.head = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.head,type,'extrap');
%     
%     y.ptr.sg.tail = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.tail,type,'extrap');
%     
%     y.ptr.sg.deriv = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.deriv,type,'extrap');
%     
%     %         [DIV.SG.all{nv}(cvtr,:)] = DFSelect(ypdf.sg.all,ypdf.sg.all);
%     
%     [DIV.SG.all{nv}(:,:)] = DFSelect(y.ptr.sg.all,ypdf.sg.eq.all);
%     
%     %% FULL
%     y.ptr.sg.headf=ypdf.sg.eq.all;
%     
%     y.ptr.sg.tailf=ypdf.sg.eq.all;
%     
%     y.ptr.sg.derivf=ypdf.sg.eq.all;
%     
%     y.ptr.sg.headf(ind.sg.head)=y.ptr.sg.head;
%     
%     y.ptr.sg.tailf(ind.sg.tail)=y.ptr.sg.tail;
%     
%     y.ptr.sg.derivf(ind.sg.deriv)=y.ptr.sg.deriv;
%     
%     %% FULL
%     [DIV.SG.head{nv}(:,:)] = DFSelect(y.ptr.sg.headf,ypdf.sg.eq.all);
%     
%     [DIV.SG.tail{nv}(:,:)] = DFSelect(y.ptr.sg.tailf,ypdf.sg.eq.all);
%     
%     [DIV.SG.deriv{nv}(:,:)] = DFSelect(y.ptr.sg.derivf,ypdf.sg.eq.all);
%     %% FIT
%     [DIV.SG.head{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.head,ypdf.sg.eq.head);
%     
%     [DIV.SG.tail{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.tail,ypdf.sg.eq.tail);
%     
%     [DIV.SG.deriv{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.deriv,ypdf.sg.eq.deriv);
end

% figure
% plot(xpdf.sg.eq.all,ypdf.sg.eq.all,'.')
% hold on
% plot(xpdf.sg.eq.all,y.ptr.sg.all,'b.')
% plot(x.tr.sg,y.tr.sg,'r.')
% title(['Number of Events = ' num2str(length(DATASG.TR))])
% 
% figure
% hist(DATASG.TR,calcnbins(DATASG.TR,'fd'))
% title(['Number of Events = ' num2str(length(DATASG.TR))])



end