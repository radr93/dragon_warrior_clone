/*

add_commas_to_number_strings(number, commas)

number	Real or String	- The number to format
commas	Boolean			- If true, uses commas, if false, uses "K" or "M" abbreviations

This script takes a number (real or string) and converts it to a string that either:
	- adds a comma when incrementing by thousands/millions (1,000 10,000 100,000 1,000,000 etc.)
	- adds a "K" or "M" and removes numbers when incrementing by thousands/millions (12K, 100K, 2M)

Returns the string.

*/

var number = argument0;
var commas = argument1;

// Convert numbers to string
if (!is_string(number)){
	number = round(number);
	var numString = string(number);
	if (string_digits(number) != string_digits(numString)){
		show_error("scr_AddCommasToNumberString error line 18: argument0 was either not a string or a real.", true);
	}
	else{
		number = numString;
	}
}

// Modify the number string depending on how many numbers there are
var length = string_length(number)
switch(length){
	case 1:
	case 2:
	case 3:
		return(number);
	case 4:
		if (commas){
			var preComma = string_copy(number, 1, 1);
			var postComma = string_copy(number, 2, 3);
			number = preComma+","+postComma;
			return(number);
		} else{
			var number1 = string_copy(number, 1, 1);
			var number2 = string_copy(number, 2, 1);
			number = number1+"."+number2+"K"
			return(number);
		}
	
	case 5:
		if (commas){
			var preComma = string_copy(number, 1, 2);
			var postComma = string_copy(number, 3, 3);
			number = preComma+","+postComma;
			return(number);
		} else{
			var number = string_copy(number, 1, 2)+"K";
			return(number);
		}
	case 6:
		if (commas){
			var preComma = string_copy(number, 1, 3);
			var postComma = string_copy(number, 4, 3);
			number = preComma+","+postComma;
			return(number);
		} else{
			number = string_copy(number, 1, 3)+"K";
			return(number);
		}
	case 7:
		if (commas){
			var preComma1 = string_copy(number, 1, 1);
			var postComma1 = string_copy(number, 2, 3);
			var postComma2 = string_copy(number, 5, 3);
			number = preComma1+","+postComma1+","+postComma2;
			return(number);
		} else{
			var number = string_copy(number, 1, 1)+"M";
			return(number);
		}
	case 8:
		if (commas){
			var preComma1 = string_copy(number, 1, 2);
			var postComma1 = string_copy(number, 3, 3);
			var postComma2 = string_copy(number, 6, 3);
			number = preComma1+","+postComma1+","+postComma2;
			return(number);
		} else{
			var number = string_copy(number, 1, 2)+"M";
			return(number);
		}
	case 9:
		if (commas){
			var preComma1 = string_copy(number, 1, 3);
			var postComma1 = string_copy(number, 4, 3);
			var postComma2 = string_copy(number, 7, 3);
			number = preComma1+","+postComma1+","+postComma2;
			return(number);
		} else{
			var number = string_copy(number, 1, 3)+"M";
			return(number);
		}
	case 10:
		if (commas){
			var preComma1 = string_copy(number, 1, 1);
			var postComma1 = string_copy(number, 2, 3);
			var postComma2 = string_copy(number, 5, 3);
			var postComma3 = string_copy(number, 8, 3);
			number = preComma1+","+postComma1+","+postComma2+","+postComma3;
			return(number);
		} else{
			var number = string_copy(number, 1, 1)+"B";
			return(number);
		}
	case 11:
		if (commas){
			var preComma1 = string_copy(number, 1, 2);
			var postComma1 = string_copy(number, 3, 3);
			var postComma2 = string_copy(number, 6, 3);
			var postComma3 = string_copy(number, 9, 3);
			number = preComma1+","+postComma1+","+postComma2+","+postComma3;
			return(number);
		} else{
			var number = string_copy(number, 1, 2)+"B";
			return(number);
		}
	case 12:
		if (commas){
			var preComma1 = string_copy(number, 1, 3);
			var postComma1 = string_copy(number, 4, 3);
			var postComma2 = string_copy(number, 7, 3);
			var postComma3 = string_copy(number, 10, 3);
			number = preComma1+","+postComma1+","+postComma2+","+postComma3;
			return(number);
		} else{
			var number = string_copy(number, 1, 3)+"B";
			return(number);
		}
		
}
show_error("string_format_number has reached the end without returning a number...", true);
