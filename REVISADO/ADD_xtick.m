function [] = ADD_xtick(DATA,x)

minD=min(min(DATA));
maxD=max(max(DATA));


for i = 1:length(x)
plot([x(i) x(i)],[minD maxD],':k'); hold on
end
axis tight