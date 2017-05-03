vetor=100:1000:200000;

for l=1:length(vetor)
    for nv=1:5
        matrix{nv}.evts{l}(:,1)=abs(mean((DIV.hist{l}.SG.all{nv})))';
        matrix_e{nv}.evts{l}(:,1)=std(abs(DIV.hist{l}.SG.all{nv}))'/sqrt(20);
        
        %% HEAD
        matrix_head{nv}.evts{l}(:,1)=abs(mean((DIV.hist{l}.SG.head{nv})))';
        matrix_e_head{nv}.evts{l}(:,1)=std(abs(DIV.hist{l}.SG.head{nv}))'/sqrt(20);
        
        %% DERIV
        matrix_deriv{nv}.evts{l}(:,1)=abs(mean((DIV.hist{l}.SG.deriv{nv})))';
        matrix_e_deriv{nv}.evts{l}(:,1)=std(abs(DIV.hist{l}.SG.deriv{nv}))'/sqrt(20);
        
        %% TAIL
        matrix_tail{nv}.evts{l}(:,1)=abs(mean((DIV.hist{l}.SG.tail{nv})))';
        matrix_e_tail{nv}.evts{l}(:,1)=std(abs(DIV.hist{l}.SG.tail{nv}))'/sqrt(20);
        
    end
end
%%
for i=1:12
    for nv=1:5
        
        for j=1:length(vetor)
            %% ALL
            matrix_menor{i}(nv,j)=matrix{nv}.evts{j}(i);
            matrix_menor_error{i}(nv,j)= matrix_e{nv}.evts{l}(i);
            
            %% HEAD
            matrix_menor_head{i}(nv,j)=matrix_head{nv}.evts{j}(i);
            matrix_menor_error_head{i}(nv,j)= matrix_e_head{nv}.evts{l}(i);
            
            %% DERIV
            matrix_menor_deriv{i}(nv,j)=matrix_deriv{nv}.evts{j}(i);
            matrix_menor_error_deriv{i}(nv,j)= matrix_e_deriv{nv}.evts{l}(i);
            
            %% TAIL
            matrix_menor_tail{i}(nv,j)=matrix_tail{nv}.evts{j}(i);
            matrix_menor_error_tail{i}(nv,j)= matrix_e_tail{nv}.evts{l}(i);
        end
    end
    
end


title_name={'LP-L_{Inf}','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'};
dist={'Gaussian','Bimodal Gaussian','Rayleigh','LogNormal','Gamma'};

for i=11
    for nv=1
        figure
        soma=(matrix_menor_tail{i}(nv,:)+matrix_menor_deriv{i}(nv,:)+matrix_menor_head{i}(nv,:));
        
        plot(vetor, 100*((matrix_menor_tail{i}(nv,:)./matrix_menor{i}(nv,:))+(matrix_menor_deriv{i}(nv,:)./matrix_menor{i}(nv,:))+(matrix_menor_head{i}(nv,:)./matrix_menor{i}(nv,:))),':*c')
        hold on
        plot(vetor, 100*(matrix_menor_tail{i}(nv,:)./soma),':*r')
        hold on
        plot(vetor,  100*(matrix_menor_deriv{i}(nv,:)./soma),':*b')
        plot(vetor,  100*(matrix_menor_head{i}(nv,:)./soma),':*k')

        ylabel('Divergence Values (%)')
        legend('Sum','Tail','Derivative','Head','Location','best')
        title([title_name{i} ' for ' dist{nv} ' distribution'])
        grid on
        set(gca,'xscale','log','GridLineStyle',':')
    end
end
