function [xfull,noise,signal] = noise_check(RoI,nDiv,name,Noise,PT_int,method)

[setup] = IN(10000,500);
[sg,~] = datasetGenSingle(setup,name{1});

xRoI.dy = sg.RoI.x.dy{RoI};
xRoI.py = sg.RoI.x.py{RoI};
xRoI.eq.dy = sg.RoI.x.eq.dy{RoI};
xRoI.eq.py = sg.RoI.x.eq.py{RoI};

[xfull] = xRoIfull(setup,sg);
[yfull]= yGen(xfull,sg,name);

[sinal]= yGen(xRoI,sg,name);

[AMP,N,sinal,yfull] = NoiseFix(PT_int(nDiv,1),PT_int(nDiv,2),sg,sinal,yfull,Noise);

[noise.dy] = noiseADD(sinal.dy,yfull.dy,AMP,N,Noise);
[noise.py] = noiseADD(sinal.py,yfull.py,AMP,N,Noise);
[noise.eq.dy] = noiseADD(sinal.eq.dy,yfull.eq.dy,AMP,N,Noise);
[noise.eq.py] = noiseADD(sinal.eq.py,yfull.eq.py,AMP,N,Noise);

[noise,signal] = MethodFix(xfull,yfull,xRoI,sinal,noise,method);

end
