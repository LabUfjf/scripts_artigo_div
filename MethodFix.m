function [noise,signal] = MethodFix(xfull,yfull,xRoI,sinal,noise,method)

        if strcmp(method,'full')
            [noise,signal,~] = cutADD(xfull,yfull,xRoI,noise);
%             plot(xfull.dy,noise.dy,'.r'); hold on
%             plot(xfull.dy,signal.dy,'.k')
%             legend('Noise','Truth')
%             pause
%             close
        else
            signal = sinal;
%             plot(xRoI.dy,noise.dy,'.r'); hold on
%             plot(xRoI.dy,signal.dy,'.k')
%             legend('Noise','Truth')
%             pause
%             close
        end
        
end