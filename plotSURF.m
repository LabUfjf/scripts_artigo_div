function []= plotSURF(vest,vgrid,A,labelx,labely,labelz)
surf(vest,vgrid,A','FaceColor',[0.5 0.5 0.5],'EdgeColor','none'); camlight left; lighting phong; axis tight; set(gca,'gridlinestyle',':');
ylabel(labely);
xlabel(labelx);
zlabel(labelz);
axis tight; set(gca,'gridlinestyle',':');
end