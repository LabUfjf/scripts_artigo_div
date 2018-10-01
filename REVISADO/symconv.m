function c = symconv(a, b)
    % In short, this function takes a sym, returns a sym (usually)
    %
    % Convolve two symbolic expressions, a and b.
    %
    % Author: Edward Peguillan III
    % Date: 12 April, 2016, 21:49 UTC
    %
    %                 DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
    %                     Version 2, December 2004
    % 
    %  Copyright (C) 2016 Ed Peguillan III <yankee14.ed@gmail.com>
    % 
    %  Everyone is permitted to copy and distribute verbatim or modified
    %  copies of this license document, and changing it is allowed as long
    %  as the name is changed.
    % 
    %             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
    %    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
    % 
    %   0. You just DO WHAT THE FUCK YOU WANT TO.
    %
    
    % If u and v arent of class sym, then get out
    is_a_sym = isa(a, 'sym'); is_b_sym = isa(b, 'sym');
    
    if (isa(a, 'sym') + isa(b, 'sym')) < 2
        error('Input to symconv must be (sym, sym), not (%s, %s).', ...
            class(a), class(b));
    end
    
    var = symvar(a);
    if(var ~= symvar(b))
        error('Input to symconv must be functions of the same variable.');
    end
    
    syms tau real;
    
    % By the definition of convolution:
    atau = subs(a, var, var - tau); % transform all to the tau axis
    btau = subs(b, var, tau); % give one the t-tau
    c = int(atau * btau, tau, -inf, inf);
    
    % Preemptively repair dumb expressions:
    c = rewrite(c, 'heaviside');
    c = rewrite(c, 'exp');
end