function threshold = calculateThreshold(der)
diff = max(der) - min(der);
step = diff/8;
threshold = min(der) + step;
end

