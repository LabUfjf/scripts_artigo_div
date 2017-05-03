clear variables;% close all; clc
i=0;
vetor=[50 100 1000 10000 50000 100000];
% vetor=[1000 5000 10000 50000 100000 500000];
% vetor=[100:100:10000];
Ntimes=40;
% vetor=[10 100];
h=waitbar(0,'Workando..');
for ev=vetor
    i=i+1;
    
    N.EVT = ev;
    for j=1:Ntimes
        [sg,DATA] = dataGen3(N.EVT);
        %         [DIV.hist{i,j},binstail1(i,j),binstail2(i,j),binshead1(i,j),binshead2(i,j),binsderiv1(i,j),binsderiv2(i,j)] = calcDivHist3(DATA,sg);
        %         [binstail1(i,j),binstail2(i,j),binshead1(i,j),binshead2(i,j),binsderiv1(i,j),binsderiv2(i,j)] = calcDivHist_bindavid(DATA,sg);
        
%         [DIV.hist{i,j}] = calcDivHist3(DATA,sg);
        [DIV.ash{i,j}] = calcDivAsh3(DATA,sg);
%         [DIV.KDE{i,j}] = calcDivKDE3(DATA,sg);
    end
    waitbar(i/length(vetor))
end
close(h)
%
% bins.l.tail=ceil(mean(binstail1,2));
% bins.r.tail=ceil(mean(binstail2,2));
%
% bins.l.head=round(mean(binshead1,2));
% bins.r.head=round(mean(binshead2,2));
%
% bins.l.deriv=round(mean(binsderiv1,2));
% bins.r.deriv=round(mean(binsderiv2,2));

% h=waitbar(0,'Workando..');
% i=0;
% for ev=vetor
%     i=i+1;
%
%     N.EVT = ev;
%     for j=1:Ntimes
%         [sg,DATA] = dataGen3(N.EVT);
%         [DIV.PDF{i,j}] = calcDivPDFNOISE3(DATA,sg,bins,i);
%     end
%     waitbar(i/length(vetor))
% end
% close(h)


for k=1:length(vetor)
    for j=1:Ntimes
        %% ABSOLUTE
%         [ABSLT{k}.tail(j,:), ABSLT{k}.deriv(j,:), ABSLT{k}.head(j,:)] = DivNorm4(DIV.hist{k,j});
        [ABSLTa{k}.tail(j,:), ABSLTa{k}.deriv(j,:), ABSLTa{k}.head(j,:)] = DivNorm4(DIV.ash{k,j});
%         [ABSLTf{k}.tail(j,:), ABSLTf{k}.deriv(j,:), ABSLTf{k}.head(j,:)] = DivNorm4(DIV.KDE{k,j}.FIX);
%         [ABSLTv{k}.tail(j,:), ABSLTv{k}.deriv(j,:), ABSLTv{k}.head(j,:)] = DivNorm4(DIV.KDE{k,j}.VAR);
        
        
        %% NORMALIZED
%         [NORM{k}.tail(j,:), NORM{k}.deriv(j,:), NORM{k}.head(j,:)] = DivNorm3(DIV.hist{k,j});
        [NORMa{k}.tail(j,:), NORMa{k}.deriv(j,:), NORMa{k}.head(j,:)] = DivNorm3(DIV.ash{k,j});
%         [NORMf{k}.tail(j,:), NORMf{k}.deriv(j,:), NORMf{k}.head(j,:)] = DivNorm3(DIV.KDE{k,j}.FIX);
%         [NORMv{k}.tail(j,:), NORMv{k}.deriv(j,:), NORMv{k}.head(j,:)] = DivNorm3(DIV.KDE{k,j}.VAR);
        %         [NORMp{k}.tail(j,:), NORMp{k}.deriv(j,:), NORMp{k}.head(j,:)] = DivNorm3(DIV.PDF{k,j});
    end
    
    
%     figure
%     barStacked2(NORM{k}); title(['Normalized Histogram - Number of Events = ' num2str(vetor(k))])
%     
%     figure
%     barStacked2(NORMa{k}); title(['Normalized ASH - Number of Events = ' num2str(vetor(k))])
%     
%     figure
%     barStacked2(NORMf{k}); title(['Kernel Fix - Number of Events = ' num2str(vetor(k))])
%     
%     figure
%     barStacked2(NORMv{k}); title(['Kernel Variable - Number of Events = ' num2str(vetor(k))])
    %     figure
    %     barStacked2(NORMp{k}); title(['Probability Density Function - Number of Events = ' num2str(vetor(k))])
end