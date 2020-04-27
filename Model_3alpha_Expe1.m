function [post] = Model_3alpha_Expe1(params, data)

prior_beta  = log(gampdf(params(1) , 1.2, 5.0));
prior_alphas = log(betapdf(params(2:4), 1.1, 1.1));
priors = sum([prior_beta  prior_alphas]) ;
lik=0;

Q       = zeros(max(data(:,3)), max(data(:,1)));

for i = 1 : length(data)
        
    deltaI = data(i, 2) - Q(data(i, 3), data(i, 1)) ;
    
    if data(i, 4) == 1
        lik = lik + params(1) * Q(data(i, 3), data(i, 1)) - log(sum(exp(params(1) * Q(data(i, 3), :))));
        Q(data(i, 3), data(i, 1)) = Q(data(i, 3), data(i, 1)) + ...
            params(2) * deltaI * (deltaI>0) + params(3) * deltaI * (deltaI<0) ;
    else
        Q(data(i, 3), data(i, 1)) = Q(data(i, 3), data(i, 1)) + ...
            params(4) * deltaI ;        
    end
    
end

post = - (priors + lik) ;