#This code explodes the multi-conformer .sdf file generated earlier by confab into a set of Gaussian job files for the 'k' lowest E conformers

for i
do
    for k in ` seq -w 2 `
    do
        babel -f "${k}" -l "${k}" --writeconformers --separate "${i}" -o gjf "${i%.*}_${k}.gjf" #-m #add -m switch for multiple files, not just lowest E
    done
done
