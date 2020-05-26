#!/bin/bash
test_count=0
test_passed=0

echo "Archivos en el directorio de corrida:"
ls 2>&1



ls 2>&1

echo -e "\nCorriendo compilacion..."
echo "gcc -o tp1 main.c ordenador.c merge_sort.S mymalloc.S -Wall -Werror -I. -g"
gcc -o tp1 main.c ordenador.c merge_sort.S mymalloc.S -Wall -Werror -I. -g 2>&1

if [ ! $? -eq 0 ]
then
    echo -e "Error de compilacion. Pruebas fallidas.\n\n"
    exit 1
fi

check_test(){
	if [ $? -eq 0 ]; then
		echo -e  "El programa compilo correctamente"
		((test_passed++))
	else
		echo -e "Salida obtenida: "$(grep -v '^#' $2 | ./tp1 -i - -o -  | tail -1)
		echo -e "Error :("

	fi
}

echo -e "\nCompilacion exitosa"
echo -e "\n~~~~~~~~ Corriendo pruebas ~~~~~~~~~"

for f in $(ls tests/* | sort -V); do
	if [[ $f == test*.txt ]]; then
		((test_count++))
		echo -e "\n~~~~~~~~ Corriendo test$test_count.txt ~~~~~~~~~"
		if [[ $test_count -gt 9 ]]; then
			expected_output=$(cat salidas/salida_$test_count.txt)
		else
			expected_output=$(cat salidas/salida_0$test_count.txt)
		fi
		echo  "Salida esperada: $expected_output" 
		if [[ $test_count -gt 9 ]]; then
			grep -v '^#' $f | ./tp1 -i - -o - | grep -f "salidas/salida_$test_count.txt" > /dev/null		
		else
			grep -v '^#' $f | ./tp1 -i - -o -  | grep -f "salidas/salida_0$test_count.txt" > /dev/null		
		fi
		check_test expected_output $f

	fi
done

echo -e "\n~~~~~~~~ Pasaste $test_passed pruebas de $test_count ~~~~~~~~~"
if [ "$test_passed" -gt "3" ]; then
	echo "Entrega aceptada!"
else
	echo -e "Pasaron todos los test"
	exit 1
fi

exit 0
#echo -e "\n\n$GREEN Se corrieron $test_count pruebas... $RESET"
