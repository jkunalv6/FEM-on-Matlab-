format short eng

E = 2*10^5;
Ae = 500;
ne = 3;
DOF = 3;
NNODE = 4;
GR = DOF * NNODE ;
GC = GR;
x = [-750;500;500;0];
y = [0;0;0;1250];
z= [0;500;-500;0];
LOC = [1 4;2 4;3 4];

for ii = 1:GR
    for jj = 1:GC
        KG(ii,jj) = 0;
    end 
end

for i = 1:ne 
    j = LOC(i,1);
    k = LOC(i,2);
    LE(i) = sqrt((x(k)- x(j))^2 + (y(k) - y(j))^2 + (z(k)- z(j))^2);
    l(i) = (x(k) -x(j))/ LE(i);
    m(i) = (y(k) - y(j)) / LE(i);
    n(i) = (z(k) -z(j)) /LE(i);

    disp('Element Number');
    disp(i);
    disp('LE l m n');
    disp(LE(i));
    disp(l(i));
    disp(m(i));
    disp(n(i));

    T(1,1) = l(i)^2;
    T(1,2) = l(i)*m(i);
    T(1,3) = l(i) *n(i);
    T(1,4) = -l(i)^2;
    T(1,5) = -l(i)*m(i);
    T(1,6) = -l(i) *n(i);
    T(2,1) = l(i) *m(i);
    T(2,2) = m(i)*2;
    T(2,3) = m(i) *n(i);
    T(2,4) = -l(i) *m(i);
    T(2,5) = -m(i)^2;
    T(2,6) = -m(i)*n(i);
    T(3,1) = l(i)*n(i);
    T(3,2) = m(i) *n(i);
    T(3,4) = -l(i)*n(i);
    T(3,5) = -m(i)*n(i);
    T(3,6) = -n(i)^2;
    T(4,1) = -l(i)^2;
    T(4,2) = -l(i)*m(i);
    T(4,3) = -l(i)*n(i);
    T(4,4) = l(i)^2;
    T(4,5) = l(i)*m(i);
    T(4,6) = l(i)*n(i);
    T(5,1) = -l(i)*m(i);
    T(5,2) = -m(i)^2;
    T(5,3) = -m(i)*n(i);
    T(5,4) = l(i)*m(i);
    T(5,5) = m(i)^2;
    T(5,6) = m(i)*n(i);
    T(6,1) = -l(i)*n(i);
    T(6,2) = -m(i)*n(i);
    T(6,3) = -n(i)^2;
    T(6,4) = l(i)*n(i);
    T(6,5) = m(i)*n(i);
    T(6,6) = n(i)^2;
    E= (E*Ae/LE(i))*T;
    disp('KE');
    disp(KE);
    
 