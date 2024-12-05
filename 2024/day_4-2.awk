#!/usr/bin/awk -f

BEGIN {
	FS=""
}

# Iterate over all lines
{
	y++;
	# collect lines into array
	arr[y] = $0;
}

END {
	linelen = length(arr[1]);
	print "size of array: " linelen "x" length(arr);

	y = 1;
	split(arr[y], line1);
	split(arr[y+1], line2);

	for ( ; y <= length(arr)-2; y++) {
		split(arr[y+2], line3);
		result += search(line1, line2, line3);

		copyArray1();
		copyArray2();
	} 

	print "result: " result;
}

function copyArray1(i)
{
	for (i=1; i <= length(line1); i++) 
		line1[i] = line2[i];
}

function copyArray2(i)
{
	for (i=1; i <= length(line2); i++) 
		line2[i] = line3[i];
}

function search(l1, l2, l3, res, i)
{
	res = 0;
	for (i=1; i <= linelen-2; i++) {
		 if (l2[i+1] == "A") {
		 	if (l1[i] == "M" && l1[i+2] == "M") {
			 	if (l3[i] == "S" && l3[i+2] == "S") {
			 		res++;
			 	}
		 		continue;
		 	}

		 	if (l1[i] == "M" && l1[i+2] == "S") {
			 	if (l3[i] == "M" && l3[i+2] == "S") {
			 		res++;
			 	}
		 		continue;
		 	}

		 	if (l1[i] == "S" && l1[i+2] == "M") {
			 	if (l3[i] == "S" && l3[i+2] == "M") {
			 		res++;
			 	}
		 		continue;
		 	}

		 	if (l1[i] == "S" && l1[i+2] == "S") {
			 	if (l3[i] == "M" && l3[i+2] == "M") {
			 		res++;
			 	}
		 		continue;
		 	}
		 }
	}

	return res;
}

#	for (i in arr2) {
#		print arr2[i];
#	}
