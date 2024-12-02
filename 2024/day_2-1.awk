#!/usr/bin/awk -f

BEGIN {
}

# Iterate over all lines
{
	# initial diff from first 2 values
	diff = $2 - $1;
	if (abs(diff) > 3 || diff == 0) {
		# unsafe;
		next;
	}

	# iterate over rest of values
	for (i=3; i <= NF; i++) {
		nextdiff = $i - $(i-1);
		if (nextdiff == 0 || abs(nextdiff) > 3) {
			# unsafe;
			next;
		}

		if ((diff > 0 && nextdiff < 0) || (diff < 0 && nextdiff > 0)) {
			# unsafe;
			next;
		}
	}

	# safe
	safe++;
}

END {
	print "safe: " safe;
}

function abs(v) {v += 0; return v < 0 ? -v : v}
