function PNCCs = ExtractPNCC(audio) %16 KHz
    addpath('./PNCC');
    
    [PNCCs] = PNCC_IEEETran( audio);
    PNCCs =PNCCs';
    rmpath('./PNCC')
end