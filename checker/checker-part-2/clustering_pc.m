function [centroids] = clustering_pc(points, NC)
    
    [rows dims] = size(points);
    %rows = nr puncte, dims = dimensiunea lor
    
    clusters = zeros(NC, 1);
    [NC colclu] = size(clusters);
    colclux = 1;
    
    for k = 1 : NC
      for i = 1 : rows
        if mod(i, NC) == k
          %parcurg linia i si pun fiecare element in cluster
          for j = 1 : dims
            %il adaug la clusterul k
            clusters(k, colclu) =  points(i,j);
            colclu++;
          endfor 
        elseif mod(i, NC) == 0
          for j = 1 : dims
            clusters(NC, colclux) = points(i,j);
            colclux++; 
        endfor
      end
      endfor
      colclu = 1;
      colclux = 1;
    endfor
    
    [NC colclu] = size(clusters);
    centroidsOld = zeros(NC, 1);
    [NC col] = size(centroidsOld);
    %calculez centroizii parcurgand cluster pe coloane
    x = 0;
    %pt toti centroizii indexati cu c asociati cu clusterul c
    for c = 1 : NC
      len = 0;
      for z = 1 : colclu
        if clusters(c,z) ~= 0
          len++;
        endif
      endfor
      x = len/dims; %pt impartire si parcurgere x-1
      if(x == 0)
        x = 1;
      endif
      % j parcurgere de fiecare dimensiune
      for j = 1 : dims
        y = 0;
        % i parcurgere de fiecare punct - salt
        for i = 0 : (x-1)
          y += clusters(c, dims*i + j);
        endfor
        centroidsOld(c, col) = y/x;
        col++;
      endfor
      col = 1;
    endfor
    
    while 1
    
      %centroids contine mediile punctelor din cluster pe dimensiunea lor
      norms = zeros(1, NC);
      clusters = zeros(NC, 1);
      [lin col] = size(clusters);
      
      %parcurgere puncte(linii din points)
      for i = 1 : rows
        %parcurgere centroizi de numar NC - centroidul j
        for j = 1 : NC
          %adaugare in vector norms pt a face min
          norms(j) = norm(points(i, :) - centroidsOld(j, :));
        endfor
        %daca norms(j) e minim atunci linia i se duce la clusters(j)
        for j = 1 : NC
          if norms(j) == min(norms)
            for l = 1 : dims
              clusters(j, col) = points(i, l);
              col++;
            endfor
          endif
      endfor
    endfor
    
      %elimin zerourile
      [lin col] = size(clusters);
      newCl2 = zeros(NC, 1);
      [lin2 col2] = size(newCl2);
      
      %parcurg cu i fiecare vector atribuit centroidului i
      for i = 1 : NC
        x = 0;
        %parcurg toate coloanele(dimensiunile pctelor) centroidului i
        for j = 1 : col
          %refac matricea punctelor fara zerouri
          if clusters(i,j) ~= 0
            newCl2(i, col2) = clusters(i,j);
            col2++;
          endif
        endfor
        col2 = 1;
      endfor
      
      clusters = newCl2;
      
      %recalcularea poz centroizilor cu media
        
      centroids = zeros(NC, 1);
      [lin col] = size(centroids);
      [linclu colclu] = size(clusters);
      
      %calculez centroizii parcurgand clusters pe coloane
      x = 0;
      %pt toti centroizii indexati cu c asociati cu clusterul c
      for c = 1 : NC
        len = 0;
        %calculez lungimea vectorului adevarat
        for b = 1 : colclu
          if clusters(c,b) ~= 0
            len++;
          endif
        endfor 
        x = len/dims; %pt impartire si parcurgere x-1
        if(x == 0)
        x = 1;
      endif
        % j parcurgere de fiecare dimensiune
        for j = 1 : dims
          y = 0;
          % i parcurgere de fiecare punct - salt
          for i = 0 : (x-1)
            y += clusters(c, dims*i + j);
          endfor
          centroids(c, col) = y/x;
          col++;
        endfor
        col = 1;
      endfor
      
      if norm(centroidsOld - centroids) < 1e-5
        break;
      endif
   
      centroidsOld = centroids;
    
  endwhile
endfunction