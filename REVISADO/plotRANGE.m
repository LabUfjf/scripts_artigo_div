function [] = plotRANGE(Ma,Mi)
load RANGE_Gaussian
for i = 1:4
plot([RANGE.X(i,1) RANGE.X(i,1)],[Mi Ma],':k'); hold on
plot([RANGE.X(i,2) RANGE.X(i,2)],[Mi Ma],':k'); hold on
end
end