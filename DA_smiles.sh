IFS=$'\n'

for d in ` cat scripts/D.dat | grep -v "^#" `
do
 for a in ` cat scripts/A.dat | grep -v "^#" `
 do

 IFS=' '
 D=( $d )
 A=( $a )
 echo "D: ${D}"

 echo "Name: ${D[0]} ${A[0]}"

 name="${D[0]}-${A[0]}"
 SMILE="H-${D[1]}-${A[1]}-H"

 echo "${SMILE}" > "mono-${name}.smi"

 name="${D[0]}-${A[0]}"
 SMILE="H-${D[1]}-${A[1]}-${D[1]}-${A[1]}-H"

 echo "${SMILE}" > "di-${name}.smi"

 IFS=$'\n'
 done
done
