
Programmed by Chanwoo Kim for IEEE Transcation on Speech, Audio, and Language Processing
Nov. 17, 2010


1) Just Run PNCC_IEEETran('outFile', 'inPutFile')



IMPORTANT : The input is assumed in the single-Channel sphere NIST format. 
            The sampling rate should be "16 kHz".
 	    It does not check the header, but just skips the header. 
            We used this program in getting result in IEEE Transcation paper and ICASSP 2012 paper 



2) Output is a feature in Sphinx format





3) To see the spectrogram demo

  Type DemoBatch.m in Matlab

  It will launch three figures: 
  a) spectrogram, 
  b) spectrogram using log nonliearity (This one is still better than MFCC in our recognition experiment)
  c) gammatone weighting, PNCC (This one is much better than b))

  In each figure you will sub-figures obtained under different noisy conditions. If the spectrogram from the noisy
  condition is closer to the top subfigure in each figure, then we consider that feature to be more robust
   