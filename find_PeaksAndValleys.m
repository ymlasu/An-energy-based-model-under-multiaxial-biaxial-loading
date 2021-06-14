function [peaks, valleys, cycle_check] = find_PeaksAndValleys(spectrum)
peaks = []; valleys = [];
error = abs(spectrum(1) - spectrum(end));

if error > 0.01
    cycle_check = 0;
    disp('cyclic loading error')
end

cycle_check = 1;
for i = 2:length(spectrum)-1
    if spectrum(i-1)<spectrum(i) && spectrum(i+1)<spectrum(i)
        peaks(end+1) = spectrum(i);
    end
    if spectrum(i-1)>spectrum(i) && spectrum(i+1)>spectrum(i)
        valleys(end+1) = spectrum(i);
    end
end

if length(peaks)>length(valleys)
    valleys(end+1) = spectrum(1);
end
if length(peaks)<length(valleys)
    peaks(end+1) = spectrum(1);
end

if isempty(peaks)
    peaks = max([spectrum(1) spectrum(end)]);
    valleys = min([spectrum(1) spectrum(end)]);
end

end