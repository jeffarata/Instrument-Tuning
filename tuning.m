% Jeff Arata
% 10/6/17

% This project and the associated files were provided by Joe Hoffbeck and
% are found in his paper "Enhance Your DSP Course With These Interesting
% Projects.pdf"

function [ note, tuning ] = tuning( x, fs )
% This function takes in a signal x and its sampling frequency and returns
% which note is closest to being played (by key number on a piano mod 12) 
% and whether the note is sharp or flat.

keys = 1:88;                            % Keys on a Piano
freq = 440 * 2 .^ ((keys - 49)/12);     % Frequencies of piano notes

notes = {'C', 'C#', 'D', 'Eb', 'E', 'F', 'F#', 'G', 'Ab', 'A', 'Bb', 'B'};

N = length(x);
X = abs(fft(x))';

freq_ax = linspace(0, fs/2, floor(N/2+1));      % Calculate PSD
PSD = (1/(fs*N)) * (X(1:floor(N/2+1)) .^ 2);
PSD(2:end-1) = 2*PSD(2:end-1);

figure(1)                       
plot(freq_ax, 10*log10(PSD))

[val, idx] = max(10*log10(PSD));    % Find freq at max of PSD. Gives note 
                                    % played, not necessarily fundamental
                                    % frequency.
tol_db = 12;    % db tolerance for finding fundamental

% Checks if a lower multiple of the found frequency also has a high value
% in the PSD. Difference must be less than the decibel tolerance. This is
% necessary as sometimes higher harmonics register at greater PSD values.
for kk = 1:5
    if abs(10*log10(PSD(round(idx/(2^kk)))) - val) < tol_db
        fun_freq = round(idx/(2^kk));
    end
end

[val, key] = min(abs(freq - fun_freq));     % Gets closest piano key

note_key = mod(key, 12) - 3; % Minus 3 as notes start at C, not A like a piano
note = notes{note_key};      % The note itself

if fun_freq - freq(key) > 0         % Figures out tuning of the note played
    tuning = 'sharp';
elseif fun_freq - freq(key) < 0
    tuning = 'flat';
else
    tuning = 'in tune';
end

end

