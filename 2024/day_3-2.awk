#!/usr/bin/awk -f

BEGIN {
	enabled = 1;
	DONT = "don't()";
	DO   = "do()";
}

# Iterate over all lines
{
	# collect lines into one string
	memory = memory $0;
}

END {
	# remove everything between DONT and DO
	while ((dont_cmd=index(memory, DONT)) != 0) {
		memory2 = substr(memory, 1, dont_cmd-1);
		memory  = substr(memory, dont_cmd+length(DONT));

		if ((do_cmd=index(memory, DO)) == 0) {
			memory = memory2;
			break;
		}

		memory = memory2 substr(memory, do_cmd+length(DO));
	}
	
	# find and calc mul(a,b)	
	s = memory;
	while ((where = match(s,"mul\\([0-9]+,[0-9]+\\)")) != 0) {
		s = substr(s,RSTART);
		a = strtonum(substr(s,index(s, "(")+1));
		b = strtonum(substr(s,index(s, ",")+1));
		result += (a*b);
		
		s = substr(s,RLENGTH);
	}

	print "result: " result;
}


function abs(v) {v += 0; return v < 0 ? -v : v}
