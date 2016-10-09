function L2S_main

numSim = 1;
load('L2S_results_1.mat');

totalConfigs = length(L2SStruct.chan_multipath)*length(L2SStruct.version)*...
    length(L2SStruct.w_channel)*length(L2SStruct.cyclic_prefix)*...
    length(L2SStruct.data_len);
totalSims = L2SStruct.maxChannRea*totalConfigs;

SNRp_mtx = zeros([size(SNRp) L2SStruct.maxChannRea]);
per_mtx_pre = zeros([size(per) L2SStruct.maxChannRea]);

for simIdx = numSim:(numSim + L2SStruct.maxChannRea - 1)
    chanIdx = mod(simIdx,L2SStruct.maxChannRea) + 1;
    
    SNRp_mtx(:,:,chanIdx) = SNRp;
    per_mtx_pre(:,:,chanIdx) = per;
    
    filename = ['L2S_results_' num2str(simIdx + 1) '.mat'];
    load(filename);
    
end % Channel realizations loop

per_mtx = permute(per_mtx_pre,[3 2 1]);

SNR_AWGN = zeros([length(c_sim.drates) length(c_sim.EbN0s)]);
for dRate = c_sim.drates
    SNR_AWGN(dRate,:) = (c_sim.EbN0s).*(hsr_drate_param(dRate,false))/c_sim.w_channel;
end % Data rates loop

numSim = numSim + L2SStruct.maxChannRea;

end