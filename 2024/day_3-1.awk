#!/usr/bin/awk -f

BEGIN {
}

# Iterate over all lines
{
	s = $0;

	# find and calc mul(a,b)	
	while ((where = match(s,"mul\\([0-9]+,[0-9]+\\)")) != 0) {
		s = substr(s,RSTART);
		a = strtonum(substr(s,index(s, "(")+1));
		b = strtonum(substr(s,index(s, ",")+1));
		result += (a*b);
		
		s = substr(s,RLENGTH);
	}

}

END {
	print "result: " result;
}

function abs(v) {v += 0; return v < 0 ? -v : v}
