function [DATA] = DimGEN(setup,d)

for i=1:d
    [INFO] = datasetGenSingle(setup);
    DATA(i,:)=INFO.sg.evt;
end
end