IFS=$'\n'

for h in ` cat scripts/H.dat | grep -v "^#" `
do
 for t in ` cat scripts/T.dat | grep -v "^#" `
 do
     for s in ` cat scripts/S.dat | grep -v "^#" `
     do


 IFS=' ' #I'm sorry, I'm just so... sorry of how I wrote this.
 H=( $h ) #YES; bash arrays
 T=( $t )
 S=( $s )
 echo "H: ${H} T: ${T} S: ${S}"

 name="${H[0]}-${S[0]}-${T[0]}"
 SMILE="H-${H[1]}-${S[1]}-${T[0]}-H"

 echo "${SMILE}" > "mono-${name}.smi"

 name="${H[0]}-${S[0]}-${T[0]}"
 SMILE="H-${H[1]}-${S[1]}-${S[1]}-${T[1]}-H"

 echo "${SMILE}" > "di-${name}.smi"

 IFS=$'\n'
 done
 done
done
