E = 2*10^5;
Ae = 2000;
n = 7;
DOF = 2;
NNODE = 5;
GR = DOF *NNODE;
GC= GR;
x= [0;12000;24000;18000;6000];
y = [0;0;0;8000;8000];
LOC = [1 2; 2 3; 3 4; 4 2; 2 5; 5 1;5 4];

for ii = 1:GR 
    for jj = 1:GC
        KG(ii,jj) = 0.0;
    end
end

for i = 1:n
    j = LOC(i,1);
    k= LOC(i,2);
    LE(i) = sqrt((x(k) - x(j))^2 + (y(k) - y(j))^2);
    l(i) = (x(k) - x(j))/LE(i);
    m(i) =(y(k) - y(j))/LE(i);

    T(1,1) = l(i)^2;
    T(1,2) = l(i) * m(i);
    T(1,3) = -T(1,1);
    T(1,4) = -l(i) * m(i);
    T(2,1) = T(1,2);
    T(2,2) = m(i)^2;
    T(2,3) = -T(1,2);
    T(2,4) = -T(2,2);
    T(3,1) = T(1,3);
    T(3,2) = T(2,3);
    T(3,3) = T(1,1);
    T(3,4) = T(1,2);
    T(4,1) = T(1,4);
    T(4,2) = T(2,4);
    T(4,3) = T(3,4);
    T(4,4) = T(2,2);
    KE = (E * Ae/ LE(i)) * T;

    N(1) = j *2 -1 ;
    N(2) = j*2;
    N(3) = k*2 -1;
    N(4) = k*2;
    for ii = 1:4
        for jj = 1:4
            ik = N(ii);
            jk = N(jj);
            KG(ik,jk) = KG(ik,jk) + KE(ii,jj);
        end
    end
end

GK = KG;

for HR = 4:6
    for HC= 1:GC 
        KG(HR,HC) = 0;
        KG(HC,HR) = KG(HR,HC);
    end
end
KG(4,4) = 1;
KG(5,5) = 1;
KG(6,6) = 1;

for u = 1:GR
    for v = 1:GC
        KGB(u,v) = KG(u,v);
    end
end

for NE = 1:GR
    F(NE) = 0;
end
F(2) = -20000;

d = (KGB^(-1)) * F';

disp('Displacement Vector');
disp(d);
disp('Element No, Stress, Force');

for i = 1:n
    j= LOC(i,1);
    k = LOC(i,2);
    j1 = (j*2) -1;
    j2 = j*2;
    k1 = (k*2) -1;
    k2 = k*2;
    de(1) = d(j1);
    de(2) = d(j2);
    de(3) = d(k1);
    de(4)=d(k2);
    sigma(i) = (E/LE(i)) * [ -l(i)  -m(i) l(i) m(i)]* de';
    FE(i) = Ae *sigma(i);
    fprintf('%d %f %f\n', i, sigma(i), FE(i));
end
disp(' ');

disp('Forces at Nodes and Support Reactions');
FR= GK*d;
disp(FR);
