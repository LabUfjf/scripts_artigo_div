clear variables; close all; clc

% PARÂMETROS DE ENTRADA:




tic
for nt = 1:500;
    
    [setup] = IN(10000);
    % CRIAR BANCO DE DADOS:
    [sg,bg] = datasetGenSingle(setup,'Gauss');
    SCOTT(nt)= calcnbins(sg.evt,'scott');
    
    i = 0;
    for bin=10:2:100
        i=i+1;
        [xh,yh] = data_normalized(sg.evt,bin);
        ytruth = [normpdf(xh,sg.g1.mu,sg.g1.std)];
        [V] = DFSelect(ytruth,yh,'norm');
        for div = 1:12;
            A{div}(i,nt) = V(div);
        end
        
    end
end
toc

bin=10:2:100;
for b =1:12
    boxplot(A{b}',bin)
       xlabel('bin')
    ylabel('Divergencia')
    pause
    close
 
end