function [sol] = hsvHistogram(path_to_image, count_bins)
  
  A = imread(path_to_image); %in format RGB

  [lin col x] = size(A);
  A = cast(A, 'double');
  
  for i = 1 : lin
    for j = 1 : col
    
      R1 = A(i,j,1)/255;
      G1 = A(i,j,2)/255;
      B1 = A(i,j,3)/255;
      
      C_MAX = max([R1 G1 B1]);
      C_MIN = min([R1 G1 B1]);
      
      delta = C_MAX - C_MIN;
      if delta == 0
        H = 0;
      elseif C_MAX == R1
        H = 60 * mod(((G1-B1)/delta),6);
      elseif C_MAX == G1
        H = 60 * (((B1-R1)/delta) + 2);
      elseif C_MAX == B1
        H = 60 * (((R1-G1)/delta) + 4);
      end
      
      H = H/360;
      A(i,j,1) = H;
      if C_MAX == 0
        S = 0;
      else
        S = delta/C_MAX;
      end
      A(i,j,2) = S;
      V = C_MAX;
      A(i,j,3) = V;
      
  endfor
endfor

  %matrice 3D H S V
  %Aij1 = H; Aij2 = S; Aij3 = V;
  H = A(:,:,1);
  S = A(:,:,2);
  V = A(:,:,3); 

  
  %transform din matrici in vector pt a folosi histc
  H = reshape(H.', 1, []);
  S = reshape(S.', 1, []);
  V = reshape(V.', 1, []);
  
  interval = linspace(0,1.01,count_bins+1);
  
  H_sol = histc(H, interval);
  S_sol = histc(S, interval);
  V_sol = histc(V, interval);
  
  [a h_end] = size(H_sol);
  [a s_end] = size(S_sol);
  [a v_end] = size(V_sol);
  

  %sterg ultimul element rezultat din histc - irelevant
  H_sol(h_end) = [];
  S_sol(s_end) = [];
  V_sol(v_end) = [];

  sol = horzcat(H_sol,S_sol,V_sol);
end