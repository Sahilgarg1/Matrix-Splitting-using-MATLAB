tic;
rows = input('no.of rows ');     %Taking input for rows and columns
cols = input('no. of columns ');
A = rand(rows, cols); %generatimg random matrix
a = -10;
b = 10;
pinv_a = pinv(A);
while any(pinv_a(:)<0)
    A = (b-a).*rand(rows, cols) + a; %ensuring positive penrose-inverse
    pinv_a = pinv(A);
end
range_a = double(colspace(sym(A))); %calculating range of input matrix
kernal_a = null(A,'r');
rank_a = rank(A);
pinv_u = [-1,3,2;2,3,4;-2,3,1;3,1,2]; %initializing pinv_u variable such that it enters the loop
V = pinv_u; 
Y1 = pinv_u;
a1 = 0;
b1 = 0.01;    %setting range for near split
A1 = [A(:,1:rank_a)];
while any(pinv_u(:)<0)||any(V(:)<0)  %checking condition for regular split
x = (b1-a1).*rand(rows,rank_a)+a1; %   %finding near splitting with same range and kernal
range_a2 = A1+x;
k = 0;
l = 0;
range_a3 = zeros(rows,cols-rank_a);
while l < (cols-rank_a)
    l = l+1;
    while k < rank_a
        k = k+1;
        range_a3(:,l) = range_a3(:,l)-(kernal_a(k,l)*range_a2(:,k));
    end
    k = 0;
end
U = [range_a2,range_a3];
kernal_u = null(U,'r');
range_u = double(colspace(sym(U)));
pinv_u = pinv(U);
V = U-A;
V1 = pinv_u*V;
end
disp('A ')
disp(A)
disp('pinv(A) ')
disp(pinv_a)
disp('nullspace(A) ')
disp(kernal_a)
disp('range(a) ')
disp(range_a)
disp('U ')
disp(U)
disp('pinv(U) ')
disp(pinv_u)
disp('nullspace(U) ')
disp(kernal_u)
disp('range(U) ')
disp(range_u)
disp('V ')
disp(V)
disp('pinv_u*V ')
disp(V1)
toc;