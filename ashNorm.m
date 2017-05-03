function [x,pdf] = ashNorm(data,M,bin)
[ x,y ] = ash(data,M,bin);
ah = area2d(x,y);
pdf = y/ah;
end