function output = DePadding_Floyd(x)
    %Get the specified row and col of matrix (N+2)x(N+2)
    [row col]= size(x);
    
    %Delete the row 1st and last row 
    x([1,row],:) = [];
    
    %Delete the column 1st and last column
    x(:,[1,col]) = [];
    
    output = x;
end