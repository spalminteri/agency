%% To compute the performances and proportions of switch in the first experiment

Performance_FreeOnly   = NaN(24,2) ;
Performance_FreeForced = NaN(24,2) ;

FreeSwitch1   = NaN(24,2) ;
ForcedSwitch1 = NaN(24,2) ;

listFirstHalfTrials  = find(rem(1:240, 40) <= 20 & rem(1:240, 40) >= 1) ;
listSecondHalfTrials = find(rem(1:240, 40) >= 21 | rem(1:240, 40) == 0) ;

for participantIndex = 1:24
    
    load(['passymetrieI_Suj', num2str(participantIndex)])
    
    % We create a 10th column that monitors if the previous trial was a free or a forced choice:
    M(2:end, 10) = M(1:end-1, 7) ;
    M(M(:,3) == 1, 10) = NaN ; % the first trial of each block cannot be filled for this column.
    
    % We create a 11th column indicating whether the participant has switched symbol between the previous and the current trial:
    M(2:end, 11) = 1 * (M(1:end-1, 6) ~= M(2:end, 6)) ; 
    M(M(:,3) == 1, 11) = NaN ; % the first trial of each block cannot be filled for this column.    
 
    % And a 12th column indicating whether the previous observed outcome was positive (1) or negative (0):
    M(2:end, 12) = 1 * (M(1:end-1, 6) == 1 & M(1:end-1, 4) == 1 | M(1:end-1, 6) == 0 & M(1:end-1, 5) == 1) ; 
    M(M(:,3) == 1, 12) = NaN ; % the first trial of each block cannot be filled for this column.    
    
    M2 = M(M(:,7) == 1, :) ; % Here we create a matrix in which we only keep the free-choice trials
    M2freeOnly    = M2(rem(M2(:,2),2) == 1, :) ; % Here we keep the free-trial only conditions, i.e., the conditions number 1 and 3;
    M2freeForced  = M2(rem(M2(:,2),2) == 0, :) ; % and here we keep the mixed free- and forced-trial conditions, i.e., the conditions number 2 and 4;
    
    Performance_FreeOnly(participantIndex, :)   = [mean(M2freeOnly(listFirstHalfTrials, 6));    mean(M2freeOnly(listSecondHalfTrials, 6))] ;
    Performance_FreeForced(participantIndex, :) = [mean(M2freeForced(listFirstHalfTrials, 6));  mean(M2freeForced(listSecondHalfTrials, 6))] ;

    FreeSwitch1(participantIndex, 1)   = mean(M2freeForced(M2freeForced(:,10) == 1 & M2freeForced(:,12) == 1, 11)) ;
    FreeSwitch1(participantIndex, 2)   = mean(M2freeForced(M2freeForced(:,10) == 1 & M2freeForced(:,12) == 0, 11)) ;
    ForcedSwitch1(participantIndex, 1) = mean(M2freeForced(M2freeForced(:,10) == 0 & M2freeForced(:,12) == 1, 11)) ;
    ForcedSwitch1(participantIndex, 2) = mean(M2freeForced(M2freeForced(:,10) == 0 & M2freeForced(:,12) == 0, 11)) ;
    
    Free_total(:, participantIndex)=mean(M2(:,6),2);
end

Expe1_perfree=mean(Free_total,1);

%% To plot the performances in the first experiment
figure(2)
subplot(2,2,1)
hold on
plot(mean(Performance_FreeForced),'--ks','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[230 230 250]/255,'MarkerSize',7)
plot(mean(Performance_FreeOnly),  '--k^','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[200 250 200]/255,'MarkerSize',7)
errorbar(mean(Performance_FreeForced), std(Performance_FreeForced)/sqrt(24), 'LineStyle','none','Color','k') 
errorbar(mean(Performance_FreeOnly),   std(Performance_FreeOnly)/sqrt(24),   'LineStyle','none','Color','k')

ylabel({'Proportion of', 'correct choices'})
ylim([0.5 1])
xlim([.5 2.5])
set(gca,'Xtick',[1,2],'XTickLabel',{'First half', 'Second half'})
set(gca,'Ytick',[0.5, 0.6, 0.7, 0.8, 0.9, 1],'YTickLabel',{'0.5', '0.6', '0.7', '0.8', '0.9', '1'})
legend('Partial Free + forced','Partial Free only','Location','southeast','AutoUpdate','off') %'southeast'northwest
legend('boxoff')

plot(mean(Performance_FreeForced), '--ks','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[230 230 250]/255,'MarkerSize',7)
plot(mean(Performance_FreeOnly),   '--k^','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[200 250 200]/255,'MarkerSize',7)
hold off

%% To plot the proportions of switch in the first experiment

subplot(2,2,3)
hold on
bar([1,2], mean(FreeSwitch1),   .6, 'FaceColor', [200 200 200]/255)
bar([4,5], mean(ForcedSwitch1), .6, 'FaceColor', [150 150 150]/255)
errorbar([1,2,4,5],mean([FreeSwitch1, ForcedSwitch1]),std([FreeSwitch1, ForcedSwitch1])/sqrt(24),'LineStyle','none','Color','k')
hold off

text(3, 0.95, 'Free choices on the {\it next}  trial', 'HorizontalAlignment', 'center')
ylabel({'Proportion of switch', 'between trial t and t+1'})
ylim([0 1])
yticks(0:.2:1)
xticks([])
xlabel({'F:  +1      -1                 +1      -1      ','  Free-choice          Forced-choice'})

%% To compute the performances and the proportions of switch in the second experiment

Performance_Partial = NaN(24,2) ;
Performance_Complete = NaN(24,2) ;

FreeSwitch2   = NaN(24,4) ;
ForcedSwitch2 = NaN(24,4) ;

listFirstHalfTrials  = find(rem(1:160, 20) <= 10 & rem(1:160, 20) >= 1) ;
listSecondHalfTrials = find(rem(1:160, 20) >= 11 | rem(1:160, 20) == 0) ;

for participantIndex = 1:24
    
    load(['passymetrieII_Suj', num2str(participantIndex)])
    
    % We create a 10th column that monitors if the previous trial was a free or a forced choice:
    M(2:end, 10) = M(1:end-1, 7) ;
    M(M(:,3) == 1, 10) = NaN ; % the first trial of each block cannot be filled for this column.
    
    % We create a 11th column indicating whether the participant has switched symbol between the previous and the current trial:
    M(2:end, 11) = 1 * (M(1:end-1, 6) ~= M(2:end, 6)) ; 
    M(M(:,3) == 1, 11) = NaN ; % the first trial of each block cannot be filled for this column.    
 
    % And a 12th column indicating whether the previous factual outcome was positive (1) or negative (0):
    M(2:end, 12) = 1 * (M(1:end-1, 6) == 1 & M(1:end-1, 4) == 1 | M(1:end-1, 6) == 0 & M(1:end-1, 5) == 1) ; 
    M(M(:,3) == 1, 12) = NaN ; % the first trial of each block cannot be filled for this column.   

    % And a 13th column indicating whether the previous counterfactual outcome was positive (1) or negative (0):
    M(2:end, 13) = 1 * (M(1:end-1, 6) == 1 & M(1:end-1, 5) == 1 | M(1:end-1, 6) == 0 & M(1:end-1, 4) == 1) ; 
    M(M(:,3) == 1, 13) = NaN ; % the first trial of each block cannot be filled for this column. 
    
    M2 = M(M(:,7) == 1, :) ; % Here we create a matrix in which we only keep the free-choice trials  
    M2partial  = M2(rem(M2(:,2),2) == 1, :) ; % Here we keep only the partial conditions, i.e., the conditions number 1 and 3;
    M2complete = M2(rem(M2(:,2),2) == 0, :) ; % and here we keep the complete conditions, i.e., the conditions number 2 and 4;
    
    Performance_Partial(participantIndex, :)  = [mean(M2partial(listFirstHalfTrials, 6));   mean(M2partial(listSecondHalfTrials, 6))] ;
    Performance_Complete(participantIndex, :) = [mean(M2complete(listFirstHalfTrials, 6));  mean(M2complete(listSecondHalfTrials, 6))] ;

    
    FreeSwitch2(participantIndex, 1)   = mean(M2complete(M2complete(:,10) == 1 & M2complete(:,12) == 1 & M2complete(:,13) == 0, 11)) ;
    FreeSwitch2(participantIndex, 2)   = mean(M2complete(M2complete(:,10) == 1 & M2complete(:,12) == 1 & M2complete(:,13) == 1, 11)) ;
    FreeSwitch2(participantIndex, 3)   = mean(M2complete(M2complete(:,10) == 1 & M2complete(:,12) == 0 & M2complete(:,13) == 0, 11)) ;
    FreeSwitch2(participantIndex, 4)   = mean(M2complete(M2complete(:,10) == 1 & M2complete(:,12) == 0 & M2complete(:,13) == 1, 11)) ;
    
    ForcedSwitch2(participantIndex, 1) = mean(M2complete(M2complete(:,10) == 0 & M2complete(:,12) == 1 & M2complete(:,13) == 0, 11)) ;
    ForcedSwitch2(participantIndex, 2) = mean(M2complete(M2complete(:,10) == 0 & M2complete(:,12) == 1 & M2complete(:,13) == 1, 11)) ;
    ForcedSwitch2(participantIndex, 3) = mean(M2complete(M2complete(:,10) == 0 & M2complete(:,12) == 0 & M2complete(:,13) == 0, 11)) ;
    ForcedSwitch2(participantIndex, 4) = mean(M2complete(M2complete(:,10) == 0 & M2complete(:,12) == 0 & M2complete(:,13) == 1, 11)) ;    

  Free_total2(:, participantIndex)=mean(M2(:,6),2);
end

Expe2_perfree=mean(Free_total2,1);

%% To plot the performances in the second experiment

subplot(2,2,2)
hold on
plot(mean(Performance_Complete),'--kd','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[255 255 100]/255,'MarkerSize',7) ;
plot(mean(Performance_Partial), '--ks','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[230 230 250]/255,'MarkerSize',7) ;
errorbar(mean(Performance_Partial),  std(Performance_Partial)/sqrt(24),  'LineStyle','none','Color','k')
errorbar(mean(Performance_Complete), std(Performance_Complete)/sqrt(24), 'LineStyle','none','Color','k')

ylim([0.5 1])
xlim([.5 2.5])
set(gca,'Xtick',[1,2],'XTickLabel',{'First half', 'Second half'})
set(gca,'Ytick',[0.5, 0.6, 0.7, 0.8, 0.9, 1],'YTickLabel',{'0.5', '0.6', '0.7', '0.8', '0.9', '1'})
legend('Complete Free + forced','Partial Free + forced','Location','southeast','AutoUpdate','off') %'southeast'northwest
legend('boxoff')

plot(mean(Performance_Complete),'--kd','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[255 255 100]/255,'MarkerSize',7) ;
plot(mean(Performance_Partial),'--ks','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[230 230 250]/255,'MarkerSize',7) ;
hold off

%% To plot the proportions of switch in the second experiment

subplot(2,2,4)
hold on
bar(mean(FreeSwitch2), 'FaceColor', [200 200 200]/255)
bar(6:9,mean(ForcedSwitch2), 'FaceColor', [150 150 150]/255)

text(5, 0.95, 'Free choices on the {\it next}  trial', 'HorizontalAlignment', 'center')
errorbar([1,2,3,4,6,7,8,9],mean([FreeSwitch2, ForcedSwitch2]),std([FreeSwitch2, ForcedSwitch2])/sqrt(24),'LineStyle','none','Color','k')
hold off
ylim([0 1])
yticks(0:.2:1)
xticks([])
xlabel({'  F:  +1  +1  -1  -1         +1  +1  -1  -1       ','CF:  -1  +1  -1  +1         -1  +1  -1  +1       ', '  Free-choice          Forced-choice'})

%% the legends
axes('Position',[0 0 1 1],'Visible','off') ;
text(.29, .97, 'Experiment 1', 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'FontSize', 12)
text(.73, .97, 'Experiment 2', 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'FontSize', 12)