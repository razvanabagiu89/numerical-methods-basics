function [A, b] = generate_probabilities_system(rows)
  
  nodes = (rows*(rows+1))/2;
  %nodes
  b = zeros(1, nodes);
  for i = rows-1:-1:0
    b(1, nodes-i) = 1;
  endfor
  b = b';
  %vector b
  
  figure = zeros(rows+2, 2*rows + 3);
  [lin col] = size(figure);
  %plasare primul element(1)
  %prima linie ramane libera
  figure(2, fix(col/2) + 1) = 1;
  
  stop = 1;
  
  for i = 2:lin
    for j = 1:col
      if figure(i,j) ~= 0
        
        if(stop == nodes)
           break;
         endif
         
         if figure(i+1,j-1) == 0
          figure(i+1,j-1) = ++stop;
        endif
        
         if figure(i+1,j+1) == 0
          figure(i+1,j+1) = ++stop;
        endif
        
       endif
     endfor
   endfor
   
  %am generat figura
  
  A = zeros(nodes);
  A(1,1) = 4;
  idx = 2;
  %inserez diagonala pe A  
  for i = 3:lin
    for j = 1:col 
      
      if figure(i,j) ~= 0
        %verific legaturile si inserez 4,5,6 dupa caz
        
        %inserare 6
        if((figure(i-1,j-1) ~= 0) && (figure(i-1,j+1) ~= 0) &&
          (figure(i,j-2) ~= 0) && (figure(i,j+2) ~=0) &&
          (figure(i+1,j-1) ~= 0) && (figure(i+1,j+1) ~= 0))
            A(idx,idx) = 6;
        
        %inserare 4 - caz stanga
        elseif ((figure(i+1,j-1) == 0) && (figure(i, j-2) == 0))
          A(idx,idx) = 4;
          
        %inserare 4 - caz dreapta
        elseif ((figure(i+1,j+1) == 0) && (figure(i, j+2) == 0))
          A(idx,idx) = 4;
          
        else A(idx,idx) = 5;
        end
        idx++;
        
      endif
    endfor
  endfor
   

  line = 1;   
  %inserare -1
  for i = 2:lin
    for j = 1:col
      %gasesc element nenul
      if figure(i,j) ~= 0
        
        %verific fiecare legatura in parte
        if figure(i-1,j-1) ~= 0
          A(line, figure(i-1,j-1)) = -1;
        endif
        if figure(i-1,j+1) ~= 0
          A(line, figure(i-1,j+1)) = -1;
        endif
        if figure(i+1,j-1) ~= 0
          A(line, figure(i+1,j-1)) = -1;
        endif
        if figure(i+1,j+1) ~= 0
          A(line, figure(i+1,j+1)) = -1;
        endif
        if figure(i,j-2) ~= 0
          A(line, figure(i,j-2)) = -1;
        endif
        if figure(i,j+2) ~= 0
          A(line, figure(i,j+2)) = -1;
        endif
        line++;
        
      endif
    endfor
  endfor
  
endfunction