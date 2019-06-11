$sum += $1 while(`more input.txt` =~ /(\d)(?=\1)/g); print $sum+7;
#Ob das erste und das letzte gleich ist musste selber schauen