dataset = input('choose a dataset: TifinaghData / PhoenicianData', 's'); % PhoenicianData
%load(strcat('data_results\data_', dataset, '_60-60_limitedData0\net-epoch-70.mat')); % get Net framework
%load(strcat('data_results\data_', dataset, '_60-60_limitedData0\net-epoch-70.mat')); % get Net framework
%load(strcat('data_results\data_', dataset, '_60-60_limitedData0\net-epoch-70.mat')); % get Net framework
load(strcat('data_results\data_TL_from_Phoenician_to_TifinaghData_freeze0_60-60__limitedData0\net-epoch-50.mat')); 

figure ; clf ; colormap gray ;
  vl_imarraysc(squeeze(net.layers{1,1}.weights{1,1}),'spacing',2)
  axis equal ; %title('filters in the first layer') ;
  
  