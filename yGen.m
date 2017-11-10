function [sinal]= yGen(xRoI,sg,name)

   switch name{1}
            case 'Gauss'
                sinal.dy = [normpdf(xRoI.dy,sg.g1.mu,sg.g1.std)];
                sinal.py = [normpdf(xRoI.py,sg.g1.mu,sg.g1.std)];
                sinal.eq.dy = [normpdf(xRoI.eq.dy,sg.g1.mu,sg.g1.std)];
                sinal.eq.py = [normpdf(xRoI.eq.py,sg.g1.mu,sg.g1.std)];
            case 'Bimodal'
                sinal.dy = [normpdf(xRoI.dy,sg.g1.mu,sg.g1.std) + normpdf(xRoI.dy,sg.g2.mu,sg.g2.std)]/2;
                sinal.py = [normpdf(xRoI.py,sg.g1.mu,sg.g1.std) + normpdf(xRoI.py,sg.g2.mu,sg.g2.std)]/2;
                sinal.eq.dy = [normpdf(xRoI.eq.dy,sg.g1.mu,sg.g1.std) + normpdf(xRoI.eq.dy,sg.g2.mu,sg.g2.std)]/2;
                sinal.eq.py = [normpdf(xRoI.eq.py,sg.g1.mu,sg.g1.std) + normpdf(xRoI.eq.py,sg.g2.mu,sg.g2.std)]/2;
            case 'Rayleigh'
                sinal.dy = raylpdf(xRoI.dy,sg.b);
                sinal.py = raylpdf(xRoI.py,sg.b);
                sinal.eq.dy = raylpdf(xRoI.eq.dy,sg.b);
                sinal.eq.py = raylpdf(xRoI.eq.py,sg.b);
            case 'Logn'
                sinal.dy = lognpdf(xRoI.dy,sg.mu,sg.std);
                sinal.py = lognpdf(xRoI.py,sg.mu,sg.std);
                sinal.eq.dy = lognpdf(xRoI.eq.dy,sg.mu,sg.std);
                sinal.eq.py = lognpdf(xRoI.eq.py,sg.mu,sg.std);
            case 'Gamma'
                sinal.dy = gampdf(xRoI.dy,sg.A,sg.B);
                sinal.py = gampdf(xRoI.py,sg.A,sg.B);
                sinal.eq.dy = gampdf(xRoI.eq.dy,sg.A,sg.B);
                sinal.eq.py = gampdf(xRoI.eq.py,sg.A,sg.B);
   end
        
end