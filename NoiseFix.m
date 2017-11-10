function [AMP,N,sinal,yfull] = NoiseFix(F1,F2,sg,sinal,yfull,Noise)

       if strcmp(Noise,'normal')
            % AMP = PT_int(div,1)*max(sg.pdf.truth.y);
            AMP = F1*max(sg.pdf.truth.y);
            N = [];
        end
        if strcmp(Noise,'poisson')
            % N=round(PT_int(div,2));
            N=F2;
            AMP = [];            
            sinal.dy=(sinal.dy/sum(yfull.dy))*N;
            sinal.py=(sinal.py/sum(yfull.py))*N;
            sinal.eq.dy=(sinal.eq.dy/sum(yfull.eq.dy))*N;
            sinal.eq.py=(sinal.eq.py/sum(yfull.eq.py))*N;
            yfull.dy=(yfull.dy/sum(yfull.dy))*N;
            yfull.py=(yfull.py/sum(yfull.py))*N;
            yfull.eq.dy=(yfull.eq.dy/sum(yfull.eq.dy))*N;
            yfull.eq.py=(yfull.eq.py/sum(yfull.eq.py))*N;
            
        end
        
end