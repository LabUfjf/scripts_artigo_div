% RIEMANN SUM TEST
clear variables; close all; clc

type = 'bypass';

ires = 0;
nd = 0;
for Nest = 50000000;
    %     for name = {'Uniform'};
    for name = {'Uniform','Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
        nd = nd+1;
        
        [setup] = IN(10000,Nest); setup.DIV = 1;
        setup.NAME = name{1};
        [sg,~] = datasetGenSingle(setup,name{1},type);
        %         vest = round(linspace(100000,1000000,5000));
        vest = [0.5 1:1:10]*1e6;
        wb = waitbar(0,'Aguarde...');
        i = 0;
        %         for itp = {'nearest'};
        for itp = {'linear'};
            i=i+1;
            j=0;
            for nest=vest
                j = j+1;
                xest = linspace(sg.pdf.truth.x(1),sg.pdf.truth.x(end),nest);
                xgrid = sg.pdf.truth.x;
                yest = GridNew(sg,xest,name);
                ygrid = interp1(xest,yest,xgrid,itp{1},'extrap');
                ytruth = GridNew(sg,xgrid,name);
                [AT{nd}(j),E{nd}(j)]  = rsum(xgrid,abs(ygrid-ytruth),'mid',sg,name,1);
                Integ(nd)=sg.Integral;
                waitbar(j/length(vest))
            end
        end
        close(wb)
    end
    
end

for i=1:6
    
    A(i,:)=abs(AT{i});
%     B(i,:)=Integ(i)-abs(AT{i});
%     C(i,:)= abs(E{i});
    %     plot(vest, Integ(i)-abs(AT{i}{1})); hold on
    
end
% bar3(A); axis tight
name = {'Uniform','Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
bar3(A'); axis tight
set(gca,'XTickLabel',name)
set(gca,'YTickLabel',vest)
grid on; set(gca,'GridLineStyle',':'); axis tight;
xlabel('Distance')
ylabel('Grid Points')
zlabel('Error')

legend({'Uniform','Gaussian','Bimodal','Rayleigh','Logn','Gamma'})


