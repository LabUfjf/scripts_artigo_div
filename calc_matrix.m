%% ALL

for nv=1:5
    matrix{nv}(:,1)=mean(abs(DIV.hist.SG.all{nv}))';
    matrix{nv}(:,2)=mean(abs(DIV.ash.SG.all{nv}))';
    matrix{nv}(:,3)=mean(abs(DIV.KDE.FIX.SG.all{nv}))';
    matrix{nv}(:,4)=mean(abs(DIV.KDE.VAR.SG.all{nv}))';
end

for nv=1:5
    matrix_e{nv}(:,1)=std(abs(DIV.hist.SG.all{nv}))'/sqrt(20);
    matrix_e{nv}(:,2)=std(abs(DIV.ash.SG.all{nv}))'/sqrt(20);
    matrix_e{nv}(:,3)=std(abs(DIV.KDE.FIX.SG.all{nv}))'/sqrt(20);
    matrix_e{nv}(:,4)=std(abs(DIV.KDE.VAR.SG.all{nv}))'/sqrt(20);
end


for l=1:12
    for nv=1:5
        matrix_menor{l}(nv,:)=matrix{nv}(l,:);
        matrix_menor_error{l}(nv,:)=matrix_e{nv}(l,:);
    end
    
end

%% TAIL

for nv=1:5
    matrix_tail{nv}(:,1)=mean(abs(DIV.hist.SG.tail{nv}))';
    matrix_tail{nv}(:,2)=mean(abs(DIV.ash.SG.tail{nv}))';
    matrix_tail{nv}(:,3)=mean(abs(DIV.KDE.FIX.SG.tail{nv}))';
    matrix_tail{nv}(:,4)=mean(abs(DIV.KDE.VAR.SG.tail{nv}))';
end

for nv=1:5
    matrix_tail_e{nv}(:,1)=std(abs(DIV.hist.SG.tail{nv}))'/sqrt(20);
    matrix_tail_e{nv}(:,2)=std(abs(DIV.ash.SG.tail{nv}))'/sqrt(20);
    matrix_tail_e{nv}(:,3)=std(abs(DIV.KDE.FIX.SG.tail{nv}))'/sqrt(20);
    matrix_tail_e{nv}(:,4)=std(abs(DIV.KDE.VAR.SG.tail{nv}))'/sqrt(20);
end


for l=1:12
    for nv=1:5
        matrix_tail_menor{l}(nv,:)=matrix_tail{nv}(l,:);
        matrix_tail_menor_error{l}(nv,:)=matrix_tail_e{nv}(l,:);
    end
end

%% deriv

for nv=1:5
    matrix_deriv{nv}(:,1)=mean(abs(DIV.hist.SG.deriv{nv}))';
    matrix_deriv{nv}(:,2)=mean(abs(DIV.ash.SG.deriv{nv}))';
    matrix_deriv{nv}(:,3)=mean(abs(DIV.KDE.FIX.SG.deriv{nv}))';
    matrix_deriv{nv}(:,4)=mean(abs(DIV.KDE.VAR.SG.deriv{nv}))';
end

for nv=1:5
    matrix_deriv_e{nv}(:,1)=std(abs(DIV.hist.SG.deriv{nv}))'/sqrt(20);
    matrix_deriv_e{nv}(:,2)=std(abs(DIV.ash.SG.deriv{nv}))'/sqrt(20);
    matrix_deriv_e{nv}(:,3)=std(abs(DIV.KDE.FIX.SG.deriv{nv}))'/sqrt(20);
    matrix_deriv_e{nv}(:,4)=std(abs(DIV.KDE.VAR.SG.deriv{nv}))'/sqrt(20);
end


for l=1:12
    for nv=1:5
        matrix_deriv_menor{l}(nv,:)=matrix_deriv{nv}(l,:);
        matrix_deriv_menor_error{l}(nv,:)=matrix_deriv_e{nv}(l,:);
    end
end

%% HEAD

for nv=1:5
    matrix_head{nv}(:,1)=mean(abs(DIV.hist.SG.head{nv}))';
    matrix_head{nv}(:,2)=mean(abs(DIV.ash.SG.head{nv}))';
    matrix_head{nv}(:,3)=mean(abs(DIV.KDE.FIX.SG.head{nv}))';
    matrix_head{nv}(:,4)=mean(abs(DIV.KDE.VAR.SG.head{nv}))';
end

for nv=1:5
    matrix_head_e{nv}(:,1)=std(abs(DIV.hist.SG.head{nv}))'/sqrt(20);
    matrix_head_e{nv}(:,2)=std(abs(DIV.ash.SG.head{nv}))'/sqrt(20);
    matrix_head_e{nv}(:,3)=std(abs(DIV.KDE.FIX.SG.head{nv}))'/sqrt(20);
    matrix_head_e{nv}(:,4)=std(abs(DIV.KDE.VAR.SG.head{nv}))'/sqrt(20);
end


for l=1:12
    for nv=1:5
        matrix_head_menor{l}(nv,:)=matrix_head{nv}(l,:);
        matrix_head_menor_error{l}(nv,:)=matrix_head_e{nv}(l,:);
    end
end