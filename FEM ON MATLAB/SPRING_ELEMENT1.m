% Spring element ex1 
% example 2.1

format short eng 
n = 4;
DOF =1 ;
NNODE = 4;
GR = DOF *NNODE;
GC = GR ;
A(1) = 1 ;
A(2) = 1 ;
A(3) = 1;
A(4) = 1 ;

E(1) = 500 ;
E(2) = 600;
E(3) = 400;
E(4) = 400;

L(1) = 1 ;
L(2) = 1 ;
L(3) = 1;
L(4) = 1 ;

LOC = [1 2 ; 2 3; 2 4 ; 3 4];

for ii = 1: GR 
    for jj = 1: GC
        KG(ii,jj) = 0.0 ;
    end 
end 

for i = 1 : n 
    j = LOC(i,1);
    KE(1,1) = A(i) * E(i) / L(i) ;
    KE(1,2) = -KE(1,1) ;
    KE(2,1) = -KE(1,1);
    KE(2,2) = KE(1,1);
    disp('i');
    disp(i);
    disp('KE');
    disp(KE);

    N(1) = j;
    N(2) = j+1 ;
    for ii = 1:2 
        for jj = 1:2
            ik = N(ii);
            jk = N(jj);
            KG(ik, jk) = KG(ik,jk) + KE(ii, jj);
        end 
    end 
end 
GK = KG;
disp('KG');
disp(KG);

HR =1 ;
for HC = 1 :GC
    KG(HR,HC) = 0;
    KG(HC,HR) = KG(HR,HC);
end 


HR =4 ;
for HC = 1 :GC
    KG(HR,HC) = 0;
    KG(HC,HR) = KG(HR,HC);
end 
KG(1,1) = 1.0;
KG(4,4) = 1.0;


for u = 1:GR
    for v = 1:GC
        KGB(u,v) = KG(u,v);
    end
end 
disp('KGB');
disp(KGB);

for NE = 1: GR
    F(NE) = 0.0;
end 


F(3) = 1000;
disp('Applied Forces');
disp(F);

d = (KGB^(-1)) * F' ;
disp('Displacement Vector');
disp(d);

disp('Forces at Nodes and Support Reactions');
FR = GK * d;
disp(FR);

disp('Element No, Stresses');
for i = 1:n
    j = LOC(i,1);
    j1 = j ;
    k1 = j + 1;
    de(1) = d(j1);
    de(2) = d(k1);
    sigma(i) = E(i) * (de(2)- de(1))/L(i);
    fprintf('%d %f\n', i , sigma(i));
end 
