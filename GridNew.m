function [ytruth] = GridNew(sg,xh2,name)

  switch name{1}
      
                case 'Gaussian'
                    ytruth = [normpdf(xh2,sg.g1.mu,sg.g1.std)];
                case 'Bimodal'
                    ytruth = [normpdf(xh2,sg.g1.mu,sg.g1.std) + normpdf(xh2,sg.g2.mu,sg.g2.std)]/2;
                case 'Rayleigh'
                    ytruth = raylpdf(xh2,sg.b);
                case 'Logn'
                    ytruth = lognpdf(xh2,sg.mu,sg.std);
                case 'Gamma'
                    ytruth = gampdf(xh2,sg.A,sg.B);
  end
            
end