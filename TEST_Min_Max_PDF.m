clear variables;
close;

type = 'bipass';
nt = 10000;
for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    wb = waitbar(0,['Aguarde[' name{1} ']...']);
    j = 0;
    for n = linspace(10,50000,nt)
        j=j+1;
        for i = 1:1000
            [setup] = IN(round(n),100); setup.DIV = 1;
            [sg,~] = datasetGenSingle(setup,name{1},type);
            Mi(i)= min(sg.evt);
            Ma(i)= max(sg.evt);
        end
        Vec.Min(j)= mean(Mi);
        Vec.Max(j)= mean(Ma);
        waitbar(j/nt)
    end
    close(wb)
    save(['TEST_MINMAX_PDF[' name{1} ']'],'Vec');
end

