function []= plotSURF(vest,vgrid,A,labelx,labely,labelz,color)
surf(vest,vgrid,A','FaceColor',color,'EdgeColor','none'); camlight left; lighting phong; axis tight; set(gca,'gridlinestyle',':');
% shading faceted  
ylabel(labely);
xlabel(labelx);
zlabel(labelz);
axis tight; set(gca,'gridlinestyle',':');
alpha(0.5)
end