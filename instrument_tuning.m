% Jeff Arata
% 10/6/17
% This project and the associated files were provided by Joe Hoffbeck and
% are found in his paper "Enhance Your DSP Course With These Interesting
% Projects.pdf"


% Musical Instrument Tuning - Sharp or Flat

% This script checks the tuning of an instrument by reading in a file of a
% recording of an instrument and checking the frequency of the first
% harmonic against a table of values taken from wikipedia.

% Notes coded by numbers
%
%   Note    Number
%    C        1
%    C#       2
%    D        3
%    Eb       4
%    E        5
%    F        6
%    F#       7
%    G        8
%    Ab       9
%    A        10
%    Bb       11
%    B        12
%
    
clear;
clc;

[x, fs] = audioread('oboe.wav');

[note, pitch] = tuning(x, fs);

fprintf('The note from the audio is %s and its tuning is %s.\n', note, pitch)
