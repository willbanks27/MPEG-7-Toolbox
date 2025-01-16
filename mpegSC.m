% Direct implementation of the spectral centroid as defined by the 
% MPEG-7 standard (p.48-49, section  2.7.9)

% Written by Will Banks 0 willbanks27@proton.me

% From the text:
    % The spectral centroid (SC) is not related to the harmonic structure of 
    % the signal. It gives the power-weighted average of the discrete 
    % frequencies of the estimated spectrum over the sound segment.
    % SC - Spectral Cenotroid
    % sn - digital audio signal s(n)
    % Fs - sampling frequency
    % NFT - size of the fast Fourier transform
    % PS - power spectrum extracted from the audio segment
    % fDelta - frequency interval between two successive FFT bins
    % fk - frequency array f(k) corresponding to the index k

function SC = mpegSC(sn,Fs,NFT)

    % winow type, size, and overlap are based on "MPEG-7: Audio and Beyond"
    % winow for spectral features 
    win = hamming(round(0.03*Fs));
    
    % overlap of approx. 66.67%
    hopSize = round(0.01*Fs);
    % compute the multiplier to get the olap size
    olapMult = 1 - hopSize/length(win);
    olap = round(length(win)*olapMult);
    
    % frequency analysis range based on human hearing
    freqRange = [20, 20e3];
    
    % apply window
    sn = sn.*win;

    % compute power spectrum, PS, and normalize
    PS = (1/(NFT)).*abs(fft(sn,NFT)).^2;
    
    % take half of the power spectrum
    PS = PS(1:length(PS)/2);
    
    % compute frequency resolution
    fDelta = Fs/NFT;
    
    % create array for frequency bins and transpose for matrix multiplication
    fk = (0:length(PS)-1) * fDelta;  
    fk = transpose(fk);
    
    % compute the spectral centroid as the sum of the array f(k)xPS divided
    % by the total sum of the power spectrum of the signal segment
    SC = (sum(PS.*fk)/sum(PS));

end