function [d,x,y,sd,vmax] = calc_diff(data,mode,nd)
%==========================================================================
% DADOS:
%==========================================================================
if nd == 1; var1 = data(1,:); end
if nd == 2; var2 = data(2,:); end
n=length(data);
%==========================================================================
% CALCULAR PROJEÇÃO DOS DADOS INICIAIS
%==========================================================================
[x,prob,lambda.d0]=proj_2d(data);

switch mode
    case 'proj'
       if nd == 1; y.v1=prob.proj.v1; end
       if nd == 2; y.v2=prob.proj.v2; end
    case 'hist'
       if nd == 1; y.v1=prob.v1; end
       if nd == 2; y.v2=prob.v2; end
end
%==========================================================================
% CALCULAR PARÃMETROS DOS DADOS
%==========================================================================
if nd == 1; sd.v1 = std(var1); end
if nd == 2; sd.v2 = std(var2); end
if nd == 1; m.v1 = mean(var1); end
if nd == 2; m.v2 = mean(var2); end
%==========================================================================
% CRIAR DATA GAUSSIANA COM PARÂMETROS DOS DADOS
%==========================================================================
if nd == 1; data_norm.v1 = m.v1+sd.v1*randn(n,1); end
if nd == 2; data_norm.v2 = m.v2+sd.v2*randn(n,1); end
%==========================================================================
% CALCULAR BINAGEM PARA DATA E DATA GAUSSIANA
%==========================================================================
if nd == 1; bin.v1 = calcnbins(var1,'fd'); end
if nd == 1; bin.n.v1 = calcnbins(data_norm.v1,'fd'); end
if nd == 2; bin.v2 = calcnbins(var2,'fd'); end
if nd == 2; bin.n.v2 = calcnbins(data_norm.v2,'fd'); end
%==========================================================================
% TRANSFORMAR DATASETS EM HISTOGRAMA
%==========================================================================
if nd == 1; [x.v1,y.v1] = data_normalized(var1,round(bin.v1)); end
if nd == 2; [x.v2,y.v2] = data_normalized(var2,round(bin.v2)); end
if nd == 1; [x.n.v1,y.n.v1] = data_normalized(data_norm.v1,round(bin.n.v1)); end
if nd == 2; [x.n.v2,y.n.v2] = data_normalized(data_norm.v2,round(bin.n.v2)); end

if nd == 1; h.v1 = diff(x.v1); d.v1 = max(abs(smooth(diff(y.v1),10,'moving'))/h.v1(1)); end
if nd == 2; h.v2 = diff(x.v2); d.v2 = max(abs(smooth(diff(y.v2),10,'moving'))/h.v2(1)); end
if nd == 1; h.n.v1 = diff(x.n.v1); d.n.v1 = max(abs(smooth(diff(y.n.v1),10,'moving'))/h.n.v1(1)); end
if nd == 2; h.n.v2 = diff(x.n.v2); d.n.v2 = max(abs(smooth(diff(y.n.v2),10,'moving'))/h.n.v2(1)); end

% plot(abs(smooth(diff(y.v1),10,'moving'))/h.v1(1),'k'); hold on
% plot(abs(smooth(diff(y.n.v1),10,'moving'))/h.n.v1(1),'r');
% pause
%==========================================================================
% CALCULAR VALORES MÁXIMOS
%==========================================================================
if nd == 1; vmax.v1 = max(y.v1); end
if nd == 2; vmax.v2 = max(y.v2); end
end

