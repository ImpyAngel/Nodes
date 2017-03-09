# ПРОБЕЛЫ ТУТ ОЧЕНЬ ВАЖНЫ!!!

if [ $((2+2)) -eq 4 ]
then 
	echo "equal"
else 
	echo "different"
fi
# exist a elif-block
# нет никаких &&  ||  и подобных 
# && это просто запустить что-то если удалось 
# меньше там будет -lt

# однако есть синтаксис, который выглядит по-человечески

if [[ 1 < 2 && ("A" == "A") ]]
then 
	echo "OK"
else
	echo "NEOK"
fi

#if [ $s == x* ];
#	раскрывается в имени файлов с маской
#if [ "$s" == "x* ];
#	сравнение строк
#if [[ $s == x* ]];
#	сопостовление с образцом "x*"
#if [[ "$s" == "x*" ];
#	то же самое, что 2

# существует switch-оператор

case "$CMD" in
	[nN] | [Nn][Oo])
		echo "Noooo"
	;;
	[0-9]*)
esac

# в циклах подстав вроде как нет
# while until
for i in  1 2 3 4 5
do
	echo $i
done
# есть всякие  continue 
# можно писать break 2 и выйти из 2 циклов

for ((i = 0; i < 10; i +=2 )) do
	if [[ $i == 6 ]] ;
	then
		break; 
	fi
	echo $i
done

# функции

# возвращаем только int, можно опускать слово function
function hello() {
	echo hello
}

hello2() {
	echo hello
	return 1
}
# еще нет аргументов, но они есть, а именно через проценты можно

# массивы есть, 
arr[0]=5
arr[1]=10
arr[2]=15
echo ${arr[1]}

arr2=(1 2 3 4 5)
echo ${arr2[@]} # вывод
echo ${#arr2[*]} # длинна

# обычные массивы не надо объявлять, но ассациотивные надо

declare -A arr3

arr3=([a b c]=1 [def]=2) # 2 элемента

for k in ${!arr3[@]};
do echo -n "[$k] "; done

for k in "${!arr3[@]}";
do echo -n "[$k] "; done

for k in "${!arr3[*]}";
do echo -n "[$k] "; done

# запусти и посмотри что будет

# есть строки

s=abacaba.c.tar.gz

echo ${#s} # 16 - length
echo ${s:3:4} 
echo ${s#*.c} # c.tar.gz
echo ${s##*.} # gz
echo ${s/aba/zyz} # одно заменить
echo ${s//aba/zyz} # все

# мораль : НЕ ПИСАТЬ НА BASH

srtrace ls |& grep "^open" | sed -re 's/.*"(*)".*/\1/*
