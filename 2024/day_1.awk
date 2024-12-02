#!/usr/bin/awk -f

BEGIN {
#	lines = 0;
#	distance = 0;
#	score = 0; 
}

{
	lines++;
	left[lines] = $1;
	right[lines] = $2;
}

END {
	n = asort(left, left2);
	n = asort(right, right2);

	for (i = 1; i <= n; i++) {
		distance += abs(left2[i] - right2[i]);
	}

	print "total distance: " distance;

	for (i = 1; i <= n; i++) {
		right3[right2[i]]++;
	}

	for (i = 1; i <= n; i++) {
		if (left2[i] in right3) {
			score += left2[i] * right3[left2[i]];
		}		
	}
	
	print "score: " score;

}

function abs(v) {v += 0; return v < 0 ? -v : v}
