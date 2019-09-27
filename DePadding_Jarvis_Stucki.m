function output = DePadding_Jarvis_Stucki(x)
    %Get the specified row and col of matrix (N+2)x(N+2)
    [row col]= size(x);
    
    %Delete the row 1st and 2nd
    x([1,2,row,row-1],:) = [];
    
    %Delete the column 1st and 2nd
    x(:,[1,2,col,col-1]) = [];
    
    output = x;
end