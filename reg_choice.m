function [x,y] = reg_choice(xpdf,ypdf,div,Npt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xpdf=sg.pdf.truth.x;
% ypdf=sg.pdf.truth.y;
% div = setup.DIV;
% Npt = setup.PTS;

h = diff(xpdf); h = h(1);
dy = diff(ypdf)/h;
dy = abs(dy/max(abs(dy)));
py = abs(ypdf/max(ypdf));

TH = linspace(0,1,div+1);
Nsec = round(Npt/div);
if div ==1
    i=1;
    x.dy{i} = xpdf;
    y.dy{i} = ypdf;
    x.py{i} = xpdf;
    y.py{i} = ypdf;
    x.eq.dy{i} = xpdf;
    x.eq.py{i} = xpdf;
    %    %     disp(['Derivada:' num2str(length(Idy)/2) ' Probabilidade:' num2str(length(Ipy)/2)])
    %          subplot(2,2,1);plot(xpdf(1:end-1),dy,'.'); hold on
    %          subplot(2,2,2);plot(xpdf,py,'.'); hold on
    %          subplot(2,2,2);plot(xpdf([1 end]),py([1 end]),'o');
    %     %    pause
    %          subplot(2,2,3);plot(xpdf,py,'.'); hold on
    %          subplot(2,2,4);plot(xpdf,py,'.'); hold on
    %          subplot(2,2,4);plot(xpdf([1 end]),py([1 end]),'o');
    %          pause
else
    
    for i = 1:length(TH)-1
        ind.dy{i} = find(dy>TH(i) & dy<=TH(i+1));
        ind.py{i} = find(py>TH(i) & py<=TH(i+1));
        x.dy{i} = xpdf(ind.dy{i});
        y.dy{i} = ypdf(ind.dy{i});
        x.py{i} = xpdf(ind.py{i});
        y.py{i} = ypdf(ind.py{i});        
        %         plot(x.dy{i},y.dy{i},'.'); hold on        
        Zpy=zeros(1,length(xpdf));
        Zdy=zeros(1,length(xpdf));
        Zdy(ind.dy{i})=1;
        Zpy(ind.py{i})=1;
        jdy=find(diff([0 Zdy 0]));
        jpy=find(diff([0 Zpy 0]));
        jdy(2:2:end)=jdy(2:2:end)-1;
        jpy(2:2:end)=jpy(2:2:end)-1;
        
        INTpy=setdiff(1:length(jpy),[find(diff(jpy)<1) find(diff(jpy)<1)+1]);
        INTdy=setdiff(1:length(jdy),[find(diff(jdy)<1) find(diff(jdy)<1)+1]);
        
        Ipy= [jpy(INTpy)];
        Idy= [jdy(INTdy)];
                                                                                                      
        Ipy=Ipy(setdiff(1:length(Ipy),[find(diff(Ipy)<3) find(diff(Ipy)<3)+1]));
        Idy=Idy(setdiff(1:length(Idy),[find(diff(Idy)<3) find(diff(Idy)<3)+1]));
        
        xdpy = diff(xpdf(reshape(Ipy,2,length(Ipy)/2)));
        xddy = diff(xpdf(reshape(Idy,2,length(Idy)/2)));     
        
        fdy = xddy/sum(xddy);
        fpy = xdpy/sum(xdpy);
        
        x.eq.dy{i} =[];
        x.eq.py{i} =[];
        
        kdy=0;
        for k2dy=1:2:length(Idy)
            kdy=kdy+1;
            x.eq.dy{i}=[ x.eq.dy{i} linspace(xpdf(Idy(k2dy)),xpdf(Idy(k2dy+1)),ceil(Nsec*fdy(kdy)))];
        end
        kpy=0;
        for k2py=1:2:length(Ipy)
            kpy=kpy+1;
            x.eq.py{i}=[ x.eq.py{i} linspace(xpdf(Ipy(k2py)),xpdf(Ipy(k2py+1)),ceil(Nsec*fpy(kpy)))];
        end
        
        x.eq.dy{i} = x.eq.dy{i}(1:Nsec);
        x.eq.py{i} = x.eq.py{i}(1:Nsec);
        clear xddy xdpy  jdy jpy Zdy Zpy fdy fpy Idy Ipy  INTpy INTdy
        %              disp(['Derivada:' num2str(length(Idy)/2) ' Probabilidade:' num2str(length(Ipy)/2)])
        %                  subplot(2,2,1);plot(xpdf(ind.dy{i}),dy(ind.dy{i}),'.');xlim([-4 3]); hold on
        %                  subplot(2,2,2);plot(xpdf(ind.dy{i}),py(ind.dy{i}),'.');xlim([-4 3]); hold on
        %                  subplot(2,2,2);plot(xpdf(Idy),py(Idy),'o');xlim([-4 3]);
        %             %    pause
        %                  subplot(2,2,3);plot(xpdf(ind.py{i}),py(ind.py{i}),'.');xlim([-4 3]); hold on
        %                  subplot(2,2,4);plot(xpdf(ind.py{i}),py(ind.py{i}),'.');xlim([-4 3]); hold on
        %                  subplot(2,2,4);plot(xpdf(Ipy),py(Ipy),'o');xlim([-4 3]);
        %         %        pause
    end
end
% pause

end



