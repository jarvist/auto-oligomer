for i
do
    babel -i g03 "${i}" -o pdb "${i%.*}.pdb"
    ~/confab/bin/confab -r 1.5 -v yes -i pdb "${i%.*}.pdb" "${i%.*}.sdf"
done
