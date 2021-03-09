function [values, colind, rowptr] = matrix_to_csr(A)
  
  %n = size(A,1); % dis good
  
  matrixSize = size(A);
  nz = 0;
  for i = [1 : matrixSize(1)]
    for j = [1 : matrixSize(2)]
      if A(i,j) ~= 0
        nz = nz+1;
      endif
    endfor
  endfor
  %dis good
  
  values = nonzeros(A'); % dis good
  values = values';
   
  [col, row] = find(A');
  colind = col'; % dis good

   %parcurg matricea A iar cand gasesc element != 0
   %il caut in values si ii scriu indexul in rowptr
   %apoi trec la urmatoare linie si repet
    
    k = 0; a = 1;
    for i = [1 : matrixSize(1)]
      ok = 0;
      for j = [1 : matrixSize(2)]
        if ok == 1 && A(i,j) ~= 0
          k = k+1;
        elseif A(i,j) ~= 0
          k = k+1;
          ok = ok+1;
          rowptr(a) = k;
          a = a+1; 
        end
      endfor
    endfor
 rowptr(length(rowptr) +1) = nz+1;  
endfunction