
function [Label0, Label, F, U,alpha,LOSS,iter] = FCLT(B, U0, alpha, maxiter)
    [n,m]=size(B);
    U=U0;
    [m,c]=size(U);
    BB=B'*B;
    E=U'*BB*U;
    aa = sum(E,2)+ eps*ones(c,1);%
    LOSS(1)= sum(diag(E)./aa);% 
    [~,Label0]=max(B*U0,[],2);
for iter=1:maxiter 
    E=U'*BB*U;
    d=diag(E);%E    a_j
   aa= sum(E,2);

     gradient=diag(1./(aa.^2 + eps))*(2*diag(aa)*U'*BB- diag(d)*repmat(sum(B,1),c,1) );
     gradient=gradient';
     
    nn(iter)=norm(gradient, 'fro' ) ;
    U = U + alpha*gradient;  
    for i=1:m
        U(i,:)= EProjSimplex_new(U(i,:));% 
    end
    
    E=U'*BB*U;
    aa = sum(E,2)+ eps*ones(c,1);%
    LOSS(iter+1)= sum(diag(E)./aa);% 
    if (iter>1 && abs(LOSS(iter+1)-LOSS(iter)) < 10^-6)
       break;
    end 
end


 F=B*U;
 [~,Label]=max(F,[],2);
 

 

