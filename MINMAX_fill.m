function [Fsg] = MINMAX_fill(Fsg,Vsg,nt_max,ng)

Fsg.M.pdf(ng,1)=mean(Vsg.xlimit.pdf(:,1));
Fsg.M.pdf(ng,2)=mean(Vsg.xlimit.pdf(:,2));
Fsg.S.pdf(ng,1)=std(Vsg.xlimit.pdf(:,1))/sqrt(nt_max);
Fsg.S.pdf(ng,2)=std(Vsg.xlimit.pdf(:,2))/sqrt(nt_max);
Fsg.AM.pdf(ng)=mean(Vsg.A.pdf);
Fsg.AS.pdf(ng)=std(Vsg.A.pdf)/sqrt(nt_max);

Fsg.M.data(ng,1)=mean(Vsg.xlimit.data(:,1));
Fsg.M.data(ng,2)=mean(Vsg.xlimit.data(:,2));
Fsg.S.data(ng,1)=std(Vsg.xlimit.data(:,1))/sqrt(nt_max);
Fsg.S.data(ng,2)=std(Vsg.xlimit.data(:,2))/sqrt(nt_max);
Fsg.AM.data(ng)=mean(Vsg.A.data);
Fsg.AS.data(ng)=std(Vsg.A.data)/sqrt(nt_max);

% Fsg.M.std(ng,1)=mean(Vsg.xlimit.std(:,1));
% Fsg.M.std(ng,2)=mean(Vsg.xlimit.std(:,2));
% Fsg.S.std(ng,1)=std(Vsg.xlimit.std(:,1))/sqrt(nt_max);
% Fsg.S.std(ng,2)=std(Vsg.xlimit.std(:,2))/sqrt(nt_max);
% Fsg.AM.std(ng)=mean(Vsg.A.std);
% Fsg.AS.std(ng)=std(Vsg.A.std)/sqrt(nt_max);
end