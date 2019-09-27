function output = Zeropadding_Floyd(x)
    %Get the size of input matrix NxN
    sz = size(x);
    
    %Create a new zeros matrix with size (N+2)x(N+2)
    output = zeros(sz+2);
    
    %Get the specified row and col of matrix (N+2)x(N+2)
    [row col]= size(output);

    for R = 2: (row-1)
        for C = 2: (col-1)
             output(R,C) = x(R-1,C-1);
         end
     end    
end