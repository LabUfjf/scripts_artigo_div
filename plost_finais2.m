
title_name={'LP-L_{Inf}','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'};

for i=1:length(vetor)
    for j=1:12
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% HISTOGRAM
        Nhist{j}.tail(:,i)=(NORM{i}.tail(:,j));
        Nhist{j}.deriv(:,i)=(NORM{i}.deriv(:,j));
        Nhist{j}.head(:,i)=(NORM{i}.head(:,j));
        
        Ahist{j}.tail(:,i)=(ABSLT{i}.tail(:,j));
        Ahist{j}.deriv(:,i)=(ABSLT{i}.deriv(:,j));
        Ahist{j}.head(:,i)=(ABSLT{i}.head(:,j));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ASH
        Nash{j}.tail(:,i)=(NORMa{i}.tail(:,j));
        Nash{j}.deriv(:,i)=(NORMa{i}.deriv(:,j));
        Nash{j}.head(:,i)=(NORMa{i}.head(:,j));
        
        Aash{j}.tail(:,i)=(ABSLTa{i}.tail(:,j));
        Aash{j}.deriv(:,i)=(ABSLTa{i}.deriv(:,j));
        Aash{j}.head(:,i)=(ABSLTa{i}.head(:,j));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% KDE FIX
        Nkdef{j}.tail(:,i)=(NORMf{i}.tail(:,j));
        Nkdef{j}.deriv(:,i)=(NORMf{i}.deriv(:,j));
        Nkdef{j}.head(:,i)=(NORMf{i}.head(:,j));
        
        Akdef{j}.tail(:,i)=(ABSLTf{i}.tail(:,j));
        Akdef{j}.deriv(:,i)=(ABSLTf{i}.deriv(:,j));
        Akdef{j}.head(:,i)=(ABSLTf{i}.head(:,j));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% KDE VAR
        Nkdev{j}.tail(:,i)=(NORMv{i}.tail(:,j));
        Nkdev{j}.deriv(:,i)=(NORMv{i}.deriv(:,j));
        Nkdev{j}.head(:,i)=(NORMv{i}.head(:,j));
        
        Akdev{j}.tail(:,i)=(ABSLTv{i}.tail(:,j));
        Akdev{j}.deriv(:,i)=(ABSLTv{i}.deriv(:,j));
        Akdev{j}.head(:,i)=(ABSLTv{i}.head(:,j));
    end
end

for k=1:12
    figure
    subplot(2,2,2)
    barStacked3(Nhist{k});
    title(['Normalized Histogram - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Normalized Divergence')
    
    %     saveas(gca,['figuras/Nhist' num2str(k)],'fig')
    %     saveas(gca,['figuras/Nhist' num2str(k)],'png')
    %     close
    
  
    subplot(2,2,4)
    barStacked3(Nash{k});
    title(['Normalized ASH - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Normalized Divergence')
    
    %     saveas(gca,['figuras/Nash' num2str(k)],'fig')
    %     saveas(gca,['figuras/Nash' num2str(k)],'png')
    %     close
    
    
    
    subplot(2,2,1)
    barStacked3(Ahist{k});
    title(['Normalized Histogram - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Absolute Divergence')
    
    %      saveas(gca,['figuras/Ahist' num2str(k)],'fig')
    %     saveas(gca,['figuras/Ahist' num2str(k)],'png')
    %     close
    
    
    subplot(2,2,3)
    barStacked3(Aash{k});
    title(['Normalized ASH - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Absolute Divergence')
    
    
    
    
    
    figure
    subplot(2,2,2)
    barStacked3(Nkdef{k});
    title(['KDE with fixed bandwidth - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Normalized Divergence')
    
    %     saveas(gca,['figuras/Nkdef' num2str(k)],'fig')
    %     saveas(gca,['figuras/Nkdef' num2str(k)],'png')
    %     close
    
    
    subplot(2,2,4)
    barStacked3(Nkdev{k});
    title(['KDE with variable bandwidth - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Normalized Divergence')
    
    %      saveas(gca,['figuras/Nkdev' num2str(k)],'fig')
    %     saveas(gca,['figuras/Nkdev' num2str(k)],'png')
    %     close
    %% ABSOLUTE
    
    
    
    %      saveas(gca,['figuras/Aash' num2str(k)],'fig')
    %     saveas(gca,['figuras/Aash' num2str(k)],'png')
    %     close
    
    
    subplot(2,2,1)
    barStacked3(Akdef{k});
    title(['KDE with fixed bandwidth - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Absolute Divergence')
    
    %      saveas(gca,['figuras/Akdef' num2str(k)],'fig')
    %     saveas(gca,['figuras/Akdef' num2str(k)],'png')
    %     close
    
    
    subplot(2,2,3)
    barStacked3(Akdev{k});
    title(['KDE with variable bandwidth - ' title_name{k}])
    xlabel('Number of Events')
    ylabel('Absolute Divergence')
    
    %      saveas(gca,['figuras/Akdev' num2str(k)],'fig')
    %     saveas(gca,['figuras/Akdev' num2str(k)],'png')
    %     close
end