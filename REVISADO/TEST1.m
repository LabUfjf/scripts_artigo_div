function [] = TEST1(S,type)
%==========================================================================
% Objetivo: * Definir o Maximo e Mínimo de cada PDF
%           * Melhorar essa função para o teste com DATA
%==========================================================================
% S=4;
% type = 'sg';
[AR] = STDPCT(S);
inter = 'linear';
itmax = 1;
ngrid = 200000000;
% evt =round(linspace(1000,100000,50));
evt =1000;
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Laplace'};    
    wb = waitbar(0,['Aguarde...[' name{1} ']' ]);
    ng = 0;
    for nevt = evt;
        ng = ng+1;
        for nt=1:itmax;
            [setup] = IN(name{1},type,'none','dist',inter,'bypass',nevt,ngrid,1000,1);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);                                            % Gerar os Dados à partir desses Parâmetros
            [V{ng}] = MINMAX_methods(DATA.sg,name{1},AR,ngrid,nt);
        end
        waitbar(ng/length(evt))
    end
    for i = 1:length(V)
        pdf.xlimit(i,:) = V{i}.xlimit.pdf;
        pdf.A(i) = V{i}.A.pdf;
    end
    [I,~] = PDF_integral(DATA.sg,pdf.xlimit(1),pdf.xlimit(2),name);
    pdf.I = I;
    save([pwd '\TEST1\TEST1[' name{1} ']STD[' num2str(S) '][' type ']'],'pdf')
    close(wb)
end

end