
#pbm 
adduct="(c1(h)c(h)c(h)c(h)c(h)c1C%X%Y(C(h)(h)C(h)(h)C(h)(h)C(O)OC(h)(h)(h)))"
name="pbm"
#cpdt adduct="(c1(h)c(h)Sc2c1C%X%Y(c3c(h)c(h)Sc23))"

#adduct="(c1(h)c(h)c(h)c(h)c(h)c1C%X%Y(C(h)(h)C(h)(h)C(h)(h)C(O)OC(h)(h)(h)))"

#adduct="(C%X%Y(h)(h))"
#name="methano"

#adduct="([Si]%X%Y(h)(h))"
#name="siliranemethano"


rm library.smi

 adduct1smi=` echo "${adduct}" | sed s/X/98/ | sed s/Y/99/ `
 adduct2smi=` echo "${adduct}" | sed s/X/96/ | sed s/Y/97/ `
 adduct3smi=` echo "${adduct}" | sed s/X/94/ | sed s/Y/95/ `

for isomer in fullerene/*mono*.smi
do
 isomersmi=` cat $isomer `
 iso=` basename $isomer `
 echo "${name} :"

  #write out concatenated smile
  echo "${adduct1smi}${isomersmi}" > ${name}_${iso}
done

for isomer in fullerene/*bis*.smi
do
 isomersmi=` cat $isomer `
 iso=` basename $isomer `
 echo "${name} :"

  #write out concatenated smile
  echo "${adduct1smi}${adduct2smi}${isomersmi}" > ${name}_${iso}
done

for isomer in fullerene/*tris*.smi
do
 isomersmi=` cat $isomer `
 iso=` basename $isomer `
 echo "${name} :"

  #write out concatenated smile
  echo "${adduct1smi}${adduct2smi}${adduct3smi}${isomersmi}" > ${name}_${iso}
done

