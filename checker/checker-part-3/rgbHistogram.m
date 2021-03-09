function [sol] = rgbHistogram(path_to_image, count_bins)
  A = imread(path_to_image);
  %matrice 3D R G B
  %Aij1 = R; Aij2 = G; Aij3 = B;
  
  %impart canalele R G B in 3 matrici
  R = A(:,:,1);
  G = A(:,:,2);
  B = A(:,:,3);
  
  %transform din matrici in vector pt a folosi histc
  R = reshape(R.', 1, []);
  G = reshape(G.', 1, []);
  B = reshape(B.', 1, []);
  
  interval = linspace(0,256,count_bins+1);
  
  R_sol = histc(R, interval);
  G_sol = histc(G, interval);
  B_sol = histc(B, interval);
  
  [a r_end] = size(R_sol);
  [a g_end] = size(G_sol);
  [a b_end] = size(B_sol);

  %sterg ultimul element rezultat din histc - irelevant
  R_sol(r_end) = [];
  G_sol(g_end) = [];
  B_sol(b_end) = [];

  sol = horzcat(R_sol,G_sol,B_sol); 
end