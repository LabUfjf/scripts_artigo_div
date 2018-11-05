function [h] = h_methods(DATA,nPoint)
[h] = h_plugin(DATA.sg.evt);
[h] = h_CV(DATA.sg.evt,h.PI.SJ,h);
[h.truth] = h_truth(DATA,nPoint);
end