function output = ZeroPadding_Jarvis(x)
    %Get the size of input matrix NxN
    sz = size(x);
    
    %Create a new zeros matrix with size (N+2)x(N+2)
    output = zeros(sz+4);
    
    %Get the specified row and col of matrix (N+2)x(N+2)
    [row col]= size(output);

    for R = 3: (row-2)
        for C = 3: (col-2)
             output(R,C) = x(R-2,C-2);
         end
     end    
end