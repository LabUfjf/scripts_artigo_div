function [x,y] = HISTmethods(DATA,BIN)

[x.fd,y.fd] = data_normalized(DATA,BIN.fd);
[x.scott,y.scott] = data_normalized(DATA,BIN.scott);
[x.sturges,y.sturges] = data_normalized(DATA,BIN.sturges);
[x.doane,y.doane] = data_normalized(DATA,BIN.doane);
[x.shimazaki,y.shimazaki] = data_normalized(DATA,BIN.shimazaki);
[x.rudemo,y.rudemo] = data_normalized(DATA,BIN.rudemo);
[x.truth,y.truth] = data_normalized(DATA,BIN.truth);
end