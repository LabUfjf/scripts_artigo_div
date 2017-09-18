function [CV] = CROSS(EVT,NBLOCKS)

NEVT = length(EVT);

BLOCK.MASTER = randperm(NEVT);
BLOCK.DIV = floor(NEVT/NBLOCKS);
NEVTOVER = BLOCK.DIV*NBLOCKS;
D = NEVT-NEVTOVER;
BLOCK.SLICE = reshape(BLOCK.MASTER(1:end-D),BLOCK.DIV,NBLOCKS);

for i=1:NBLOCKS
    ROTATE=circshift([1:NBLOCKS]',i-1); 
    IND = BLOCK.SLICE(:,ROTATE(1:end-1)');
    CV(i,:) = EVT(IND(:));   
end