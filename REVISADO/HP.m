function val = HP(y,r)
    val = zeros(size(y));
    for j = 1:length(val)
        val(j) = H(r+1,:)*(y(j).^(0:8)');
    end
end
