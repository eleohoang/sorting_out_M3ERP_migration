#!/bin/bash
#undefine variables
echo "Clear variables"
unset x
unset a
unset b
unset c
unset d
unset e
#reset temporary files
echo "Delete and recreate temporary files"
rm -f ./listformat_rawfile.txt 
touch ./listformat_rawfile.txt
rm -f ./list.txt
touch ./list.txt
rm -f ./listformat_goalfile.txt
touch ./listformat_goalfile.txt
rm -f ./diffrent_trans.txt
touch ./diffrent_trans.txt
extension=".java"
donename="$filename$extension"
rm -f "$donefolder/$donename"
touch "$donefolder/$donename"
# declare files 
echo "Declare files"
list_raw="./listformat_rawfile.txt"
list_goal="./listformat_goalfile.txt"
listsort="./list.txt"
diffrent_trans="./diffrent_trans.txt"
# create list transactions of raw file
echo "Create list transactions of raw file"
rm -f ./tempfile_raw.java
touch ./tempfile_raw.java
rm -f ./tempfile_raw1.java
touch ./tempfile_raw1.java
cat $rawfile | tr "\t" " " | tr -s " " > tempfile_raw1.java
sed 's/^ *//' tempfile_raw1.java > tempfile_raw.java
grep 'public void writeP' tempfile_raw.java >>listformat_rawfile.txt
rm -f ./tempfile_raw.java
rm -f ./tempfile_raw1.java
# create list transactions of goal file
echo "Create list transactions of goal file"
rm -f ./tempfile_goal.java
touch ./tempfile_goal.java
rm -f ./tempfile_goal1.java
touch ./tempfile_goal1.java
cat $goalfile | tr "\t" " " | tr -s " " > tempfile_goal1.java #remove the blank space and tab 
sed 's/^ *//' tempfile_goal1.java > tempfile_goal.java #removw the first blank
grep 'public void writeP' tempfile_goal.java >>listformat_goalfile.txt
rm -f ./tempfile_goal1.java
#compare transactions between raw file and goal file
echo "Compare transactions between goal file and raw file"
rm -f ./temp_raw.java
rm -f ./temp_goal.java
touch ./temp_raw.java
sort $list_raw > temp_raw.java
touch ./temp_goal.java
sort $list_goal > temp_goal.java
#diff temp_goal.java temp_raw.java -w | sed '1d' | egrep '-' | sed 's/-//g' | sed '/^@/d' >>$diffrent_trans
d=0
while IFS= read -r linex
echo $linex
do
    x=0
    while IFS= read -r liney
    do
		linex=$(echo "${linex%(*}" | xargs )
		liney=$(echo "${liney%(*}" | xargs )
		if [[ "$linex" == "$liney" ]]; then
			x=`expr $x + 1`
			sed -i "/$liney/d" temp_raw.java
			break
		fi
    done <"temp_raw.java"
	if [[ -z $linex ]]; then
		break
	fi
	if [[ "$x" -eq 0 ]]; then
	    d=`expr $d + 1`
		echo "$linex" >>diffrent_trans.txt
	fi
done <"temp_goal.java"
echo "We have "$d" new transaction(s):"
while IFS= read -r linek
do
	echo "$linek"
done <"diffrent_trans.txt"
rm -f ./temp_raw.java
rm -f ./temp_goal.java
# create all transactions of the goal file, prepare for sorting
echo "Start put all transactions of the goal file in new file, prepare for sorting"
linebegin="$(cat ./listformat_goalfile.txt |tee >(head -n1 )>/dev/null | xargs)"
lineno1=$(grep -n "$linebegin" tempfile_goal.java)
lineno1=${lineno1%%:*}
lineno2=$(grep -n 'public void clear(){' tempfile_goal.java)
lineno2=${lineno2%%:*}
lineno2=`expr $lineno2 - 1`
sed -n "${lineno1},${lineno2} p" $goalfile >>list.txt
 echo "Finish put all transactions of the goal file in new file, prepare for sorting"
# create the first section - declare variables and tables in goal file 
echo "Start create the first section - declare variables and tables in goal file"
sed -n "1,`expr $lineno1 - 1` p" $goalfile >>"$donefolder/$donename"
echo "Finish create the first section - declare variables and tables in goal file"
#sorting follow list transactions - the second section
echo "Start sorting follow list transactions - the second section"
while IFS= read -r line
do
	line=$line | xargs
	echo "$line"
	lineno3=$(grep -n "$line" tempfile_goal.java)
	lineno3=${lineno3%%:*}
	linex=$(grep -A 1 -iw "$line" listformat_goalfile.txt | sed '1d')
	linex=$linex | xargs
	if [[ -z "$linex" ]]; then
		lineno4=$(grep -n "public void clear(){" tempfile_goal.java)
	else
		lineno4=$(grep -n "$linex" tempfile_goal.java)
	fi
	lineno4=${lineno4%%:*}
	sed -n "${lineno3},`expr $lineno4 - 1` p" $goalfile >>"$donefolder/$donename"
done <"$list_raw"
echo "Finish sorting follow list transactions - the second section" 
# create the third section
echo "Start create the third section - spe transactions"
while IFS= read -r line
do
	line=$line | xargs
	echo "$line"
	lineno5=$(grep -n "$line" tempfile_goal.java)
	lineno5=${lineno5%%:*}
	linex=$(grep -A 1 -iw "$line" listformat_goalfile.txt | sed '1d')
	linex=$linex | xargs
	if [[ -z "$linex" ]]; then
		lineno6=$(grep -n "public void clear(){" tempfile_goal.java)
	else
		lineno6=$(grep -n "$linex" tempfile_goal.java)
	fi
	lineno6=${lineno6%%:*}
	sed -n "${lineno5},`expr $lineno6 - 1` p" $goalfile >>"$donefolder/$donename"
done <"$diffrent_trans"
echo "Finish create the third section - spe transactions"
# create the final section - clear variables
echo "Start create the final section - clear variables"
lineno7=$(wc -l < $goalfile)
sed -n "${lineno2},${lineno7} p" $goalfile >>"$donefolder/$donename"
echo "Finish create the final section - clear variables"
#remove file
rm -f ./listformat_rawfile.txt 
rm -f ./list.txt
rm -f ./listformat_goalfile.txt
rm -f ./diffrent_trans.txt
rm -f ./tempfile_goal.java

