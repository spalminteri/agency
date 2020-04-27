clear all

options = optimset('Algorithm', 'interior-point', 'Display', 'iter-detailed', 'MaxIter', 10000);
AlphaNumber = 4 ;

for nsub = 1:24
    
    resultname=strcat('passymetrieI_Suj',num2str(nsub));
    load(resultname);
    
    data = NaN(length(M), 4) ;
    
    for i = 1:length(M)
        data(i,1) = M(i,6) + 1 ; % the stimuli selected (choice between stim A = best and stim B = worst)
        data(i,2) = M(i,4)*(M(i,6)==1) + M(i,5)*(M(i,6)==0) ; % the factual outcome seen
        data(i,3) = M(i,2) + 4*(M(i,1)-1) ; % the current block 
        data(i,4) = M(i,7) ; % whether the trial was free- of forced-choice.
    end
 
    if AlphaNumber == 2
        [parameters(nsub,:),ll(nsub)] = fmincon(@(x) Model_2alpha_Expe1(x, data), [5 .5*ones(1,AlphaNumber)], ...
            [],[],[],[], zeros(1,AlphaNumber+1), [Inf ones(1,AlphaNumber)],[], options);         
        
    elseif AlphaNumber == 3
        [parameters(nsub,:),ll(nsub)] = fmincon(@(x) Model_3alpha_Expe1(x, data), [5 .5*ones(1,AlphaNumber)], ...
            [],[],[],[], zeros(1,AlphaNumber+1), [Inf ones(1,AlphaNumber)],[], options); 
        
    elseif AlphaNumber == 4
        [parameters(nsub,:),ll(nsub)] = fmincon(@(x) Model_4alpha_Expe1(x, data), [5 .5*ones(1,AlphaNumber)], ...
            [],[],[],[], zeros(1,AlphaNumber+1), [Inf ones(1,AlphaNumber)],[], options); 
        
    elseif AlphaNumber == 0
        [parameters(nsub,:),ll(nsub)] = fmincon(@(x) Model_1alphaPers_Expe1(x, data), [5 .5 .2], ...
            [],[],[],[], zeros(1,3), [Inf 1 Inf],[], options);          
    end
    
end

N = length(find(data(:,4)==1)) ;
RL07 = SumUp_LLH_parameters(parameters, ll, N) ;

if AlphaNumber == 2
    save SumUp2alphaExpe1 RL07    
elseif AlphaNumber == 3
    save SumUp3alphaExpe1 RL07    
elseif AlphaNumber == 4
    save SumUp4alphaExpe1 RL07
elseif AlphaNumber == 0
    save SumUpPersExpe1 RL07    
end