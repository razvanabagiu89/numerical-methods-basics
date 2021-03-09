# Numerical Methods basics

## How to run

/checker/checker-part-x where x = 1..4 and run the MATLAB script.

## About
This project showcases the introduction to ML.

## Part 1: Sparse Jacobi

- generate_probabilities_system

Pentru aceasta functie m-am folosit de o matrice auxiliara, si anume figura
din pdf generata intr-o matrice. In functie de aceasta, am stabilit cate
legaturi are fiecare nod si care noduri se leaga intre ele impunand
conditiile din if-uri.


- matrix_to_csr

Pentru a aduce matricea din forma densa in forma CSR m-am folosit de cativa
parametrii precum: nz - numar de elemente nenule calculate cu un contor
incrementat la fiecare element nenul gasit, values - vector cu elemente
nenule din A, colind - vector cu indexii coloanelor elementelor nenule din
A calculat extragand coloanele unui vector transpus cu elementele lui A
si rowptr - calculat prin parcurgerea matricei A, iar la elemtent nenul gasit
acesta se identifica cu cel din values ca index, si trec acest index in 
vectorul rowptr. Variabila ok determina daca a fost gasit primul element nenul
al fiecarei linii, iar daca da (ok = 1), incrementarea contorului k se continua
pentru a sari peste celalalte elemente. La final de rowptr (ultimul element)
se va adauga "nz + 1" , contorul de elemente nenule + 1.


- Jacobi_factorization

Pentru aceasta factorizare am ales 3 matrici ajutatoare si anume: D - matricea
ce contine diagonala lui A, U - (upper) matricea superior triunghiulara
asociata lui A, L - (lower) matricea inferior triunghiulara asociata lui A
, U si L avand elementele cu minus in fata. Apoi am urmat algoritmul
de calcul de la seminar, inlocuind in cod prin N = D, si P = L + U, iar
matricea de iteratie G fiind inversa lui D inmultita cu matricea P. Vectorul
de iteratie c va fi inversa lui N inmultita cu parametrul b primit - vectorul
termenilor liberi.

- Jacobi_sparse

Pentru aceasta functie am initializat o aproximare initiala, vectorul x0 cu
zero-uri, iar pe y - l-am calculat folosind functia deja implementata
csr_multiplication intre valorile CSR ale matricii G si vectorul initial x0.
Prima iteratie va fi x = y + c, aceste operatii fiind repetate pana cand
se va ajunge la o diferenta mai mica decat toleranta impusa.

## Part 2: K-Means

- clustering_pc

Pentru aceasta functie am initializat un vector coloana de NC linii denumit
clusters, in care am adaugat in functie de index toata linia asociata 
matricei points (element cu element), vectorul clusters devenind o matrice.
Am pus un caz special in care restul i mod NC este zero, deoarece acesta nu
era inclus in if ul generalizat.
Astfel fiind calculata matricea clusters in care fiecare linie reprezinta
un cluster individual, am calculat matricea centroidsOld (centroids teoretic
la iteratia zero) prin a face media aritmetica pe dimensiuni (dims*i + j) a
fiecarui cluster. Acestia fiind pasii 1) 2) din enunt, am continuat cu un while
in care am reinitializat vectorul coloana de clusters si un vector norms
orizontal cu NC coloane in care salvez fiecare norma in parte de la fiecare
punct la toti centroizii (centroidsOld). Pentru acest vector norms calculez
minimul, iar indexul la care se afla acel minim, linia sa se copiaza in
noile clustere initializate (liste goale de puncte avand cate un reprezentant
conform enuntului). In continuare matricea clusters contine multe zero-uri
redundante asa ca am scapat de ele prin blocul de cod cu newCl2 (se copiaza
elementele nenule si i se asociaza tot lui clusters). Recalcularea mediei
se bazeaza pe acelasi principiu de la iteratia zero, astfel cu ajutorul
matricei clusters cu noile puncte asociata cu distanta euclidiana minima.
Am impus o toleranta, iar cand diferenta dintre centroidsOld si centroids
va fi mai mica, se va da break si se va returna centroids. Daca nu, atunci
centroidsOld devine centroids, si centroids se recalculeaza avand iteratia
anterioara drept centroidsOld.


- compute_cost_pc

Pentru aceasta functie m-am refolosit de codul scris la functia anterioara,
astfel fiind calculate toate distantele de la fiecare punct la toti
centroizii, distanta minima am stocat-o in vectorul dist, ca la final 
sa fac suma elementelor vectorului.

## Part 3: Householder prediction

- rgbHistogram

Am citit imaginea primita ca path cu functia imread si am stocat-o intr-o
matrice tridimensionala, in care a treia dimensiune determina canalele
de culoare.Am impartit aceste canale in matrici, apoi transformate in
vectori pentru a le da parametru functiei histc recomandata in enunt.
Intervalul a fost impartit in count_bins, urmand ca ultimul element
din vectorii rezultati de histc sa fie sters(element redundant), iar la final
am concatenat toti vectorii rezultati in vectorul sol.

- hsvHistogram

Am folosit pseudocodul din enunt pentru fiecare pixel, apoi am modificat
intervalul(0-1.01) impartit la count_bins si am reluat algoritmul folosit
la functia anterioara.

