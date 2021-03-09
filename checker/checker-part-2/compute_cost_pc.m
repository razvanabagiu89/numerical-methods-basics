function [cost] = compute_cost_pc(points, centroids)
  
  %suma distantelor
  cost = 0;
  NC = rows(centroids);
  norms = zeros(1, NC);
  dist = zeros(1, NC);
  x = 1;
  
  %parcurgere puncte(linii din points)
    for i = 1 : rows(points)
      %parcurgere centroizi de numar NC - centroidul j
      for j = 1 : rows(centroids)
        %adaugare in vector norms pt a face min
        norms(j) = norm(points(i, :) - centroids(j, :));
      endfor
      %adaug norms min la dist
      dist(x) = min(norms);
      x++;
    endfor
    
   for i = 1 : length(dist)
     cost += dist(i);
   endfor
endfunction