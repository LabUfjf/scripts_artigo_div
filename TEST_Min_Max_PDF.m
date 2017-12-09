clear variables;
close;

type = 'bipass';
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
nt_max = 100;

wb = waitbar(0,['Aguarde...']);
ng = 0;
ngrid = 1000000;
evt =round(linspace(100,10000,20));
for nevt = evt;
    ng = ng+1;
    for nt=1:nt_max;
        for name = {'Rayleigh'};
            %     for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
            [setup] = IN(nevt,1000000); setup.DIV = 1;  setup.NAME = name{1};
            [sg,bg] = datasetGenSingle(setup,name{1},type);
            
            [xlimit.pdf(nt,:),A1(nt)] = cdfpdf(sg,name,0.001,ngrid);
            [xlimit.data(nt,:),A2(nt)]  =  cdfdata(sg,name,0.001,ngrid);
            [xlimit.std(nt,:),A3(nt)] = stdrange(sg,name,ngrid,4);
            close
        end
    end
    
    M.pdf(ng,1)=mean(xlimit.pdf(:,1));
    M.pdf(ng,2)=mean(xlimit.pdf(:,2));
    S.pdf(ng,1)=std(xlimit.pdf(:,1))/sqrt(nt_max);
    S.pdf(ng,2)=std(xlimit.pdf(:,2))/sqrt(nt_max);
    AM.pdf(ng)=mean(A1);
    AS.pdf(ng)=std(A1)/sqrt(nt_max);
    
    M.data(ng,1)=mean(xlimit.data(:,1));
    M.data(ng,2)=mean(xlimit.data(:,2));
    S.data(ng,1)=std(xlimit.data(:,1))/sqrt(nt_max);
    S.data(ng,2)=std(xlimit.data(:,2))/sqrt(nt_max);
    AM.data(ng)=mean(A2);
    AS.data(ng)=std(A2)/sqrt(nt_max);
    
    M.std(ng,1)=mean(xlimit.std(:,1));
    M.std(ng,2)=mean(xlimit.std(:,2));
    S.std(ng,1)=std(xlimit.std(:,1))/sqrt(nt_max);
    S.std(ng,2)=std(xlimit.std(:,2))/sqrt(nt_max);
    AM.std(ng)=mean(A3);
    AS.std(ng)=std(A3)/sqrt(nt_max);   
 
    waitbar(ng/length(evt))
end

close(wb)

subplot(1,2,1);errorbar(evt,M.pdf(:,1),S.pdf(:,1),':r'); hold on
subplot(1,2,1);errorbar(evt,M.std(:,1),S.std(:,1),':b'); hold on
subplot(1,2,1);errorbar(evt,M.data(:,1),S.data(:,1),':k'); 

subplot(1,2,1);errorbar(evt,M.pdf(:,2),S.pdf(:,2),':r')
subplot(1,2,1);errorbar(evt,M.std(:,2),S.std(:,2),':b')
subplot(1,2,1);errorbar(evt,M.data(:,2),S.data(:,2),':k')
subplot(1,2,1);legend('PDF','STD','DATA');axis tight; grid on; set(gca,'GridLineStyle',':');

subplot(1,2,2);errorbar(evt,AM.pdf,AS.pdf,':r'); hold on
subplot(1,2,2);errorbar(evt,AM.std,AS.std,':b'); hold on
subplot(1,2,2);errorbar(evt,AM.data,AS.data,':k'); hold on
subplot(1,2,2);legend('PDF','STD','DATA');axis tight;  grid on; set(gca,'GridLineStyle',':');






% hist(xlimit.std,200)
% hold on
% hist(xlimit.data,200)
% hist(xlimit.pdf,200)

%     wb = waitbar(0,['Aguarde[' name{1} ']...']);
%     j = 0;
%     for n = 100000
%         j=j+1;
%         for i = 1:100000
%
%             Mi.sg(i)= min(sg.evt);
%             Ma.sg(i)= max(sg.evt);
%             Mi.bg(i)= min(bg.evt);
%             Ma.bg(i)= max(bg.evt);
%             waitbar(i/100000)
%         end
%         Vec.Min.sg= (Mi.sg);
%         Vec.Max.sg= (Ma.sg);
%         Vec.Min.bg= (Mi.bg);
%         Vec.Max.bg= (Ma.bg);
%     end
%     close(wb)
%     save(['TEST_MINMAX_PDF[' name{1} ']'],'Vec');
% end

