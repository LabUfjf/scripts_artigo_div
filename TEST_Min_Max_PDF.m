clear variables;
close;

type = 'bypass';
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
nt_max = 1;



ngrid = 10000000;
% evt =round(linspace(100,10000000,2));
evt =100000;
AR = 0.9999;

% for name = {'Gaussian'};
for name = {'Uniform','Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
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
            [Vbg] = MINMAX_methods(Vbg,bg,name,AR,ngrid,nt);
        end
        %         pause
%         [cevt,xevt]=ecdf(bg.evt);
%         plot(xevt,cevt,':'); hold on
        waitbar(ng/length(evt))
        
        [Fsg] = MINMAX_fill(Fsg,Vsg,nt_max,ng);
        [Fbg] = MINMAX_fill(Fbg,Vbg,nt_max,ng);
    end
    close(wb)
    
    MINMAX_plot(sg,evt,Fsg,name,ngrid)
%     MINMAX_plot(bg,evt,Fbg,name,ngrid)
    pause
%     Vec.Min.sg =  Fsg.M.pdf(1,1); Vec.Max.sg =  Fsg.M.pdf(1,2); Vec.Min.bg =  Fbg.M.pdf(1,1); Vec.Max.bg =  Fbg.M.pdf(1,2);
%     save([pwd '\MINMAX\TEST_MINMAX_PDF[' name{1} ']'],'Vec')
    
end