function [x,y] = reg_choice(xpdf,ypdf,div,Npt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    
    ind.dy{i} = find(dy>TH(i) & dy<TH(i+1));
    ind.py{i} = find(py>TH(i) & py<TH(i+1));
    x.dy{i} = xpdf(ind.dy{i});
    y.dy{i} = ypdf(ind.dy{i});
    x.py{i} = xpdf(ind.py{i});
    y.py{i} = ypdf(ind.py{i});
    Zpy=zeros(1,length(xpdf));
    Zdy=zeros(1,length(xpdf));
    Zdy(ind.dy{i})=1;
    Zpy(ind.py{i})=1;
    jdy=find(diff([0 Zdy 0]));
    jpy=find(diff([0 Zpy 0]));
    jdy(2:2:end)=jdy(2:2:end)-1;
    jpy(2:2:end)=jpy(2:2:end)-1;
    
    INTpy=setdiff(1:length(jpy),[find(diff(jpy)<3) find(diff(jpy)<3)+1]);
    INTdy=setdiff(1:length(jdy),[find(diff(jdy)<3) find(diff(jdy)<3)+1]);
    Ipy= [jpy(INTpy)];
    Idy= [jdy(INTdy)];
    
    for k1dy=1:length(Idy)/2
        xddy(k1dy)=abs((xpdf(Idy(1*k1dy)))-(xpdf(Idy(2*k1dy))));
    end
    for k1py=1:length(Ipy)/2
        xdpy(k1py)=abs((xpdf(Ipy(1*k1py)))-(xpdf(Ipy(2*k1py))));
    end
    
    fdy = xddy/sum(xddy);
    fpy = xdpy/sum(xdpy);
    
    x.eq.dy{i} =[];
    x.eq.py{i} =[];
    
    for k2dy=1:length(Idy)/2
        x.eq.dy{i}=[ x.eq.dy{i} linspace(xpdf(Idy(1*k2dy)),xpdf(Idy(2*k2dy)),ceil(Nsec*fdy(k2dy)))];
    end
    
    for k2py=1:length(Ipy)/2
        x.eq.py{i}=[ x.eq.py{i} linspace(xpdf(Ipy(1*k2py)),xpdf(Ipy(2*k2py)),ceil(Nsec*fpy(k2py)))];
    end
    
    
    x.eq.dy{i} = x.eq.dy{i}(1:Nsec);
    x.eq.py{i} = x.eq.py{i}(1:Nsec);
    clear xddy xdpy
    
%      disp(['Derivada:' num2str(length(Idy)/2) ' Probabilidade:' num2str(length(Ipy)/2)])
%          subplot(2,2,1);plot(xpdf(ind.dy{i}),dy(ind.dy{i}),'.'); hold on
%          subplot(2,2,2);plot(xpdf(ind.dy{i}),py(ind.dy{i}),'.'); hold on
%          subplot(2,2,2);plot(xpdf(Idy),py(Idy),'o');
%     %    pause
%          subplot(2,2,3);plot(xpdf(ind.py{i}),py(ind.py{i}),'.'); hold on
%          subplot(2,2,4);plot(xpdf(ind.py{i}),py(ind.py{i}),'.'); hold on
%          subplot(2,2,4);plot(xpdf(Ipy),py(Ipy),'o');
%     %    pause
end
end
% pause

end



