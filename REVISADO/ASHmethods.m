function [x,y] = ASHmethods(DATA,M,inter,BIN)

[x.scott,y.scott] = ashN(DATA,M,inter,BIN.scott);
[x.sturges,y.sturges] = ashN(DATA,M,inter,BIN.sturges);
[x.doane,y.doane] = ashN(DATA,M,inter,BIN.doane);
[x.shimazaki,y.shimazaki] = ashN(DATA,M,inter,BIN.shimazaki);
[x.rudemo,y.rudemo] = ashN(DATA,M,inter,BIN.rudemo);
[x.LHM,y.LHM] = ashN(DATA,M,inter,BIN.LHM);
[x.truth,y.truth] = ashN(DATA,M,inter,BIN.truth);
end