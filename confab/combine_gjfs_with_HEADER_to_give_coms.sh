EXTENSION="b3lypopt"

for i
do 
 cat HEADER > "${i%.*}_${EXTENSION}.com"
 tail -n +6 "${i}" >> "${i%.*}_${EXTENSION}.com"
done
