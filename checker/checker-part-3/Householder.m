function [Q, R] = Householder(A)
  
  [lin col] = size(A);
   Q = eye(lin);
  
  for i = 1:col-1
      if A(i,i) == 0
        break;
      endif
        
        %step 1
        a_pp = A(i,i);
        for j = (i+1):lin 
          norm1(j) = A(j,i);
        endfor
   
        sigma_p = sign(a_pp) * norm(norm1);
        v_pp = a_pp + sigma_p;
        
        %step 2
        %u_pp sa fie de la a_ii in jos
        u_pp = zeros(lin);
        k = i; %indice pt copiat elementele
        for j = i:lin 
          u_pp(k) = A(j,i);
          k++;
        endfor
        u_pp(i) = v_pp;
        
        %step 3
        utu = u_pp * u_pp';
        uut = u_pp .* u_pp';
        
        H = eye(lin) - (2*uut)/utu;
        
        R = H * A;
        A = H * A;
        Q *= H;
        
   endfor
endfunction