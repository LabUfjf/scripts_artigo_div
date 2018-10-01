function [nd,n,data]= format_data(data)

[nd,n] = size(data);

if nd>n
    data = data';
    [nd,n] = size(data);
end

end