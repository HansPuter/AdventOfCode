#!/usr/bin/awk -f

BEGIN {
	FS=""
	str = "XMAS"
	rev = "SAMX";
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

	# horizonat left->right / right->left
	search(arr);

	# vertical up->down / down->up
	for (j=1; j <= linelen; j++) {
		s = "";
		for (i in arr) {
			s = s substr(arr[i], j, 1);
		}
		arr2[j] = s;
	}
	search(arr2);
	delete arr2;

	# diagonal to the right up->down / down->up
	i = 0;
	for (y=length(arr)-length(str)+1; y >= 1; y--) {
		x = 1; y2 = y;		
		while (y2 <= length(arr)) {
			arr2[i+1] = arr2[i+1] substr(arr[y2], x, 1);
			x++; y2++;
		}

		i++;
	}

	for (x=2; x <= linelen-length(str)+1; x++) {
		y = 1;
		x2 = x;		
		while (y <= length(arr)) {
			arr2[i+1] = arr2[i+1] substr(arr[y], x2, 1);
			x2++; y++;
		}

		i++;
	}

	search(arr2);
	delete arr2;

	# diagonal to the left up->down / down->up
	i = 0;
	for (y=length(arr)-length(str)+1; y >= 1; y--) {
		x = linelen; y2 = y;		
		while (y2 <= length(arr)) {
			arr2[i+1] = arr2[i+1] substr(arr[y2], x, 1);
			x--; y2++;
		}

		i++;
	}

	for (x=linelen-1; x >= length(str); x--) {
		y = 1;
		x2 = x;		
		while (x2 >= 1) {
			arr2[i+1] = arr2[i+1] substr(arr[y], x2, 1);
			x2--; y++;
		}

		i++;
	}
	search(arr2);

	print "result: " result;
}

function search(arr, i)
{
	for (i in arr) {
		result += gsub(/XMAS/, "XMAS", arr[i]); 
	}

	for (i in arr) {
		result += gsub(/SAMX/, "SAMX", arr[i]); 
	}
}

#	for (i in arr2) {
#		print arr2[i];
#	}
