clear variables;
close;

type = 'bipass';
nt = 1;
for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    wb = waitbar(0,['Aguarde[' name{1} ']...']);
    j = 0;
    for n = 100000
        j=j+1;
        for i = 1:100000
            [setup] = IN(round(n),100); setup.DIV = 1;
            [sg,bg] = datasetGenSingle(setup,name{1},type);
            Mi.sg(i)= min(sg.evt);
            Ma.sg(i)= max(sg.evt);
            Mi.bg(i)= min(bg.evt);
            Ma.bg(i)= max(bg.evt);
            waitbar(i/100000)
        end
        Vec.Min.sg= (Mi.sg);
        Vec.Max.sg= (Ma.sg);
        Vec.Min.bg= (Mi.bg);
        Vec.Max.bg= (Ma.bg);
    end
    close(wb)
    save(['TEST_MINMAX_PDF[' name{1} ']'],'Vec');
end

