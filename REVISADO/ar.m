function [A] = ar(A,mod)

if strcmp(mod,'real')
    A = real(A);
end
if strcmp(mod,'abs')
    A = abs(A);
end

end