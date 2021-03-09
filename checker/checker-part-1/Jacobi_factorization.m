function [G_J, c_J] = Jacobi_factorization(A)
  D = diag(diag(A));
  U = -(triu(A) - D);
  L = -(tril(A) - D);
  
  G_J = inv(D) * (L + U);
 % c_J = inv(D) * b; 
endfunction
