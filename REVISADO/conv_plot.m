function y = conv_plot(u,g)
    syms t T R C u
    F(t) = int(u(T)*g(t-T),'T',-inf,+inf);
    simplify(F(t))
    
    F(t) = subs(F(t), {R, C}, {1000, 10E-4});
    
    ezplot(F(t), [-1, 7])
end