clear variables;
close;

type = 'bipass';
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
nt_max = 50;
ngrid = 10000000;
wb = waitbar(0,['Aguarde...']);
for nt=1:nt_max;
    %         for name = {'Gaussian'};
    for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
        [setup] = IN(10000,1000000); setup.DIV = 1;  setup.NAME = name{1};
        [sg,bg] = datasetGenSingle(setup,name{1},type);
        
        [xlimit.pdf(nt,:),A1(nt)] = cdfpdf(sg,name,0.001,ngrid);
        [xlimit.data(nt,:),A2(nt)]  =  cdfdata(sg,name,0.001,ngrid);
         [xlimit.std(nt,:),A3(nt)] = stdrange(sg,name,ngrid);
        plot(sg.pdf.truth.x,sg.pdf.truth.y); hold on
        %         plot(bg.pdf.truth.x,bg.pdf.truth.y);
        plot(xlimit.pdf(nt,1),0,'*k',xlimit.pdf(nt,2),0,'*k')
        plot(xlimit.data(nt,1),0,'*r',xlimit.data(nt,2),0,'*r')
        pause
        %        [1-rsum(sg.pdf.truth.x,sg.pdf.truth.y,'mid')   1-rsum(bg.pdf.truth.x,bg.pdf.truth.y,'mid')]
        %         pause
                close
    end
    waitbar(nt/nt_max)
end

close(wb)
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

