aafunction yn = mpegDFT(sn,Fs,tSec)

    % window length based on tSec.
    WL = round(Fs*tSec);
    
    % maximum amount of windows that can fit into input signal
    numWin = floor(length(sn)/WL);
    
    % define window
    ham = hamming(WL);
    
    % create vector for window signal
    winVect = zeros(length(sn),1);
    
    % fill the vector with hamming windows
    for i = 0:numWin-1
        winSindex = (i+1)*WL-WL+1;
        winEIndex = (i+1)*WL;
        
        winVect(winSindex:winEIndex) = ham;
    
    end
    
    % replace the end of the winVect with the remaining segment of the window
    winMod = mod(length(sn),WL);
    winRem = ham(1:end-(WL-winMod));
    remIndexStart = length(winVect)-winMod+1;
    winVect(remIndexStart:length(winVect)) = winRem;
    
    
    % windowed signal - no overlap
    an = sn.*winVect;
    
    % overlap
    olap = 0.5;
    
    % hop size
    hop = floor(WL*(1-olap));
    
    % take no olap signal and place into buffers
    rn = buffer(an,WL);
    
    % overlap-add segments based on hopsize
    for i=1:numWin
    
        in1 = hop;
        in2 = 2*hop-1;
        
        c1 = rn(in1:in2,i);
        c2 = rn(1:in1,i+1);
        c3 = c1+c2;
        yn(:,i) = c3;
    
    end
    
    % put back together into a single vector
    yn = yn(:);


end