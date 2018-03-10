clear variables;
close;

type = 'bypass';
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
nt_max = 100;



ngrid = 1000000;
% evt =round(linspace(100,10000000,2));
evt =round(linspace(500,100000,50));
AR = 0.9999;

% for name = {'Gamma'};
for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
    wb = waitbar(0,['Aguarde...[' name{1} ']' ]);
    Fsg = [];
    Fbg = [];
    ng = 0;
    for nevt = evt;
        ng = ng+1;
        Vsg=[];
        Vbg=[];
        for nt=1:nt_max;
            [setup] = IN(nevt,ngrid); setup.DIV = 1;  setup.NAME = name{1};
            [sg,bg] = datasetGenSingle(setup,name{1},type);
            [Vsg] = MINMAX_methods(Vsg,sg,name,AR,ngrid,nt);
            %             [Vbg{ng}] = MINMAX_methods(Vbg,bg,name,AR,ngrid,nt);
            V{ng}=Vsg;
        end
        %         pause
        %         [cevt,xevt]=ecdf(bg.evt);
        %         plot(xevt,cevt,':'); hold on
        waitbar(ng/length(evt))
        
        %         [Fsg] = MINMAX_fill(Fsg,Vsg,nt_max,ng);
        %         [Fbg] = MINMAX_fill(Fbg,Vbg,nt_max,ng);
        
    end
%     pause
    close(wb)
    save([pwd '\MINMAX\TEST_MINMAX_PDF[' name{1} ']'],'V')
    % MINMAX_plot(sg,evt,Fsg,name,ngrid)
    %     errorbar(evt,Fsg.AM.pdf,Fsg.AS.pdf,':r'); hold on
    % errorbar(evt,Fsg.AM.std,Fsg.AS.std,':b'); hold on
    %     errorbar(evt,Fsg.AM.data,Fsg.AS.data,':k'); hold on
    %     % legend('PDF Cut','DATA Cut');axis tight;  grid on; set(gca,'GridLineStyle',':');
    % xlabel('Events'); ylabel('PDF Area');
    % MINMAX_plot(bg,evt,Fbg,name,ngrid)
    % pause
    
    %     Vec.Min.sg =  Fsg.M.pdf(1,1); Vec.Max.sg =  Fsg.M.pdf(1,2); Vec.Min.bg =  Fbg.M.pdf(1,1); Vec.Max.bg =  Fbg.M.pdf(1,2);
    %     V.sg = Vsg;
    %     V.bg = Vbg;
    %     V.evt = evt;
    %     save([pwd '\MINMAX\TEST_MINMAX_PDF[' name{1} ']'],'Vec','V')
    
end