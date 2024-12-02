#!/usr/bin/awk -f

BEGIN {
}

# Iterate over all lines
{
	# create input array
	delete values;
	for (i=1; i <= NF; i++) {
		values[i] = $i;
	}

	# check original values
	if (testSafe(values, NF)) {
		safe++;
		next;
	} 

	# as the previous check was not safe, iterate by removing 1 value
	for (i=1; i <= NF; i++) {
		# copy original array, but skip one value
		copyArray(i);

		if (testSafe(values2, NF-1)) {
			safe++;
			next;
		} 
	}
}

END {
	print "safe: " safe;
}

function testSafe(v, size, i) 
{
	diff = v[2] - v[1];
	for (i=2; i <= size; i++) {
		nextdiff = v[i] - v[i-1];
		if (nextdiff == 0 || abs(nextdiff) > 3 || (diff > 0 && nextdiff < 0) || (diff < 0 && nextdiff > 0)) {
			return 0;
		}
	}

	return 1;
}

function copyArray(skip, i, j)
{
	delete values2;
	j = 1;
	for (i = 1; i <= length(values); i++) {
		if (i != skip) {
			values2[j++] = values[i];
		}
	}
}

function abs(v) {v += 0; return v < 0 ? -v : v}
