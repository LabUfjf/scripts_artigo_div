function [D] = KDEMAP(DATA,X,Y,nROI)



YT=0;
for int=1:size(Y,2)
for imeth = 1:size(Y{1},1)
for iroi = 1:nROI
    YRoI= interp1(X,Y{int}(imeth,:),DATA.sg.RoI.x{iroi},'linear','extrap'); 
      YRoI(YRoI<0)=0;
      if isnan(YRoI)
          disp('Encontrado')
          pause          
      end
    D(int,imeth,iroi)=area2d(DATA.sg.RoI.x{iroi},YRoI-DATA.sg.RoI.y{iroi});
end
end
 YT = YT+Y{int};
end

YT=YT/size(Y,2);

DC = reshape(mean(D),size(Y{1},1),nROI);
ls={'-',':','--','-.'};
    
  
figure
subplot(2,1,1);plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'k','linewidth',2); hold on
for im=size(Y{1},1):-1:1
D = DC(im,:);
indu = find(D>0);
inds = find(D==0);
indd = find(D<0);
ND = max(max((abs(DC))));
% figure

subplot(2,1,1);plot(DATA.sg.pdf.truth.x,YT(im,:),'linestyle',ls{im},'color',[0.75 0.75 0.75],'linewidth',1); axis tight

for i = 1:nROI
    if sum(i==indu)==1
        
        cl = [1-abs(D(i)/ND) 1-abs(D(i)/ND) 1];
        subplot(2,1,2);area([min(DATA.sg.RoI.x{i}) max(DATA.sg.RoI.x{i})], [im im],'EdgeColor',cl,'FaceColor',cl);axis tight; hold on
    end
    if sum(i==indd)==1
        cl = [1 1-abs(D(i)/ND) 1-abs(D(i)/ND)];
        subplot(2,1,2);area([min(DATA.sg.RoI.x{i}) max(DATA.sg.RoI.x{i})], [im im],'EdgeColor',cl,'FaceColor',cl);axis tight; hold on
    end
    if sum(i==inds)==1
        subplot(2,1,2);area([min(DATA.sg.RoI.x{i}) max(DATA.sg.RoI.x{i})], [im im],'EdgeColor',[1 1 1]);axis tight; hold on
    end

end

end
 subplot(2,1,2); set(gca,'YTick',[1:size(Y{1},1)]-0.5,'YTickLabel',['VKDE '; 'BKDE ';'AKDE ']);
 
for im=1:size(Y{1},1)
subplot(2,1,2); plot([min(DATA.sg.pdf.truth.x) max(DATA.sg.pdf.truth.x)],[im im],'color',[1 1 1],'linewidth',2);
end
% subplot(2,1,1);legend('MODELO','MGKDE','AKDE ','BKDE ','VKDE ')
subplot(2,1,1);legend('MODELO','AKDE ','BKDE ','VKDE ')
% stairs(D)
end