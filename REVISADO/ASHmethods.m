function [x,y] = ASHmethods(DATA,M,BIN)

[x.fd,y.fd] = ashN(DATA,M,BIN.fd);
[x.scott,y.scott] = ashN(DATA,M,BIN.scott);
[x.sturges,y.sturges] = ashN(DATA,M,BIN.sturges);
[x.doane,y.doane] = ashN(DATA,M,BIN.doane);
[x.shimazaki,y.shimazaki] = ashN(DATA,M,BIN.shimazaki);
[x.rudemo,y.rudemo] = ashN(DATA,M,BIN.rudemo);
[x.truth,y.truth] = ashN(DATA,M,BIN.truth);
end