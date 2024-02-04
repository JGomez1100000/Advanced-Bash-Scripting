#!/bin/bash
# Esta línea indica que el script debe ser interpretado por Bash.

csv_file="./arrays_table.csv"
# Se asigna el nombre del archivo CSV a la variable csv_file.

# Se parsean las columnas de la tabla en 3 arreglos diferentes.
column_0=($(cut -d "," -f 1 $csv_file))
# El comando 'cut' se utiliza para cortar (split) las líneas en campos basándose en el delimitador ","
# '-d ","' especifica que el delimitador es la coma.
# '-f 1' indica que se debe extraer la primera columna.
# Los resultados se almacenan en el arreglo column_0.

column_1=($(cut -d "," -f 2 $csv_file))
# Lo mismo que la línea anterior, pero para la segunda columna. Los resultados se almacenan en column_1.

column_2=($(cut -d "," -f 3 $csv_file))
# Lo mismo que las líneas anteriores, pero para la tercera columna. Los resultados se almacenan en column_2.

# Se imprime la primera columna del CSV.
echo "Displaying the first column:"
echo "${column_0[@]}"
# "${column_0[@]}" expande todos los elementos del arreglo column_0.
# Se imprime el contenido de la primera columna en la salida estándar.



## Create a new array as the difference of columns 1 and 2
# initialize array with header
column_3=("column_3")
# Se inicializa el array column_3 con un encabezado "column_3".

# get the number of lines in each column
nlines=$(cat $csv_file | wc -l)
# Se cuenta el número de líneas en el archivo CSV usando cat para leer el contenido y wc -l para contar las líneas. 
# El resultado se almacena en la variable nlines.

echo "There are $nlines lines in the file"
# Se imprime en la salida estándar el número de líneas en el archivo.

# populate the array
for ((i=1; i<$nlines; i++)); do
  # Se inicia un bucle que va desde i=1 hasta i<nlines.
  column_3[$i]=$((column_2[$i] - column_1[$i]))
  # Se asigna a cada elemento de column_3 la diferencia entre los elementos correspondientes de column_2 y column_1.
done

echo "${column_3[@]}"
# Se imprime en la salida estándar el contenido del array column_3.


## Combine the new array with the csv file
# first write the new array to file
# initialize the file with a header
echo "${column_3[0]}" > column_3.txt
for ((i=1; i<nlines; i++)); do
  echo "${column_3[$i]}" >> column_3.txt
done
paste -d "," $csv_file column_3.txt > report.csv


