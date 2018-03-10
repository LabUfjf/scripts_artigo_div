clear variables;
clc;
evt =round(linspace(500,100000,50));
mk = ['s^ov>'];
id = 0;
for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
    id=id+1;
    load([pwd '\MINMAX\TEST_MINMAX_PDF[' name{1} ']'],'V')
    
    %     pause
    %         for i=1:length(V)
    %             M(id,i)=mean(V{i}.A.data);
    %             S(id,i)=std(V{i}.A.data);
    %         end
    
    
    %         errorbar(evt,M,S,[mk(id) 'k'],'markersize',4)
    
    %
    for j=1:50
        MV(id,:,j) = V{j}.A.data;
    end
    
    
    
end

map = [0.2, 0.1, 0.5
    0.1, 0.5, 0.8
    0.2, 0.7, 0.6
    0.8, 0.7, 0.3
    0.9, 1, 0];

aboxplot(MV,'labels',evt,'WidthL',0.75,'Colormap',map);
hold on
plot(1:55,ones(55,1)*mean(V{50}.A.pdf),':r','Linewidth',2)

set(gca,'XTick',linspace(0,50,11));
set(gca,'XTickLabel',linspace(0,100000,11));

grid on
set(gca,'GridLineStyle',':')
axis tight
axis([1 50.5 0.9986 1])

legend({'Gaussiana','Bimodal','Rayleigh','Logn','Gamma','Analítica'},'FontSize',12)

xlabel('Eventos')
ylabel('Área')