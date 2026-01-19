function [y_pred, info, NLearn, LearnRate, gbdt_model, importance] = yu_LSBoost(data_struct,idx,total_data_length,mode)

Train_InputVar = [data_struct.p,...
    data_struct.Tvp,...
    data_struct.q,...
    data_struct.U,...
    data_struct.wdir,...
    data_struct.Rib_GLGS,...
    data_struct.downLong,...
    data_struct.downShort,...
    data_struct.upLong,...
    data_struct.upShort
    ];
Train_InputVar = Train_InputVar(idx,:);

switch mode
    case ustar2
        Train_PredVar = data_struct(1).ustar.*data_struct(1).ustar(idx);
    case wt
        Train_PredVar = data_struct(1).wt(idx,:);
end

%% 去 NaN 值处理/ de-NaN
Train_data = [Train_InputVar,Train_PredVar];
sy = idx;
[~, Train_varNumI] = size(Train_InputVar);
[~, Train_varNumP] = size(Train_PredVar);
[~, Train_varNumT] = size(Train_data);

z_nan = [];
for i = 1:Train_varNumT
    z_1 = find(isnan(Train_data(:,i)));
    z_nan = [z_nan;z_1];
end
N_NaN_Pred_data_union = unique(z_nan);

Train_data(N_NaN_Pred_data_union,:) = [];
sy(N_NaN_Pred_data_union,:) = [];
Train_InputVar = Train_data(:,1:Train_varNumI);
Train_PredVar = Train_data(:,end-Train_varNumP+1:end);

clearvars i

%% LSBoost & 5-folds cross validation
cv = cvpartition(Train_PredVar, 'KFold', 5);

opt = struct('AcquisitionFunctionName', 'expected-improvement-plus', ...
    'MaxObjectiveEvaluations', 30, ...
    'UseParallel', true,... 
    'ShowPlots', false,... 
    'CVPartition', cv);

gbdt_model = fitrensemble(Train_InputVar, Train_PredVar, 'Method', 'LSBoost', ...
    'OptimizeHyperparameters', {'NumLearningCycles', 'LearnRate'}, ...
    'HyperparameterOptimizationOptions', opt);

importance = predictorImportance(gbdt_model);

cv_gbdt_model = crossval(gbdt_model, 'CVPartition', cv);  
kfoldPredictions = kfoldPredict(cv_gbdt_model);         

y_pred = NaN(total_data_length,1);
y_pred(sy) = kfoldPredictions;

info = [rmse,mae,mre];

NLearn = gbdt_model.ModelParameters.NLearn;
LearnRate = gbdt_model.ModelParameters.LearnRate;
