LIB=$1

CPUS=8 #number of cores requested
MEMg=8Gb #Memory within Gaussian
MEMp=10000mb #memory for PBS

name="${1}"

#-c center atomic coords
#-f first struct
#-l last struct
# babel -c -f $i -l $i $LIB ${name%.*}.pdb
i=1
~/bin/smi2sdf -p ~/bin/mmxconst.prm -o "${1%.*}.sdf" "${1}" 
 babel -c -f $i -l $i "${1%.*}.sdf" -xb -xk "# opt uff" ${name%.*}_uff.com


cat > ${name%.*}.sh << EOW
#!/bin/sh
#PBS -l walltime=71:59:02
#PBS -l select=1:ncpus=${CPUS}:mem=${MEMp}

module load gaussian openbabel intel-suite

cat > ${name%.*}_uff.com << EOF
%nproc=${CPUS}
#p opt uff

My brain hurts.

0 1
EOW

#echo "%nproc=${CPUS}" >> ${name%.*}.sh

tail --lines=+6 "${name%.*}"_uff.com >> ${name%.*}.sh

cat >> ${name%.*}.sh << EOW

EOF

#I don't know why but g03 inserts a Bq ghost atom at 0,0,0 after UFF which royally fluffs up further jobs / resume from checkpoint
pbsexec g03 ${name%.*}_uff.com
~/bin/jkp_extract_geom.awk ${name%.*}_uff.log | grep -v Bq > ${name%.*}_uffcoords.axyz
                                           #I AIN'T AFRAID OF NO GHOSTS! (Bq)

#BASH filth to add AM1 & b3lyp geom opt at riders
cat - ${name%.*}_uffcoords.axyz > ${name%.*}_am1.com <<EOF
%nproc=${CPUS}
#opt am1

Am1 auto job

0 1
EOF

#blank line wanted for g03
echo >> ${name%.*}_am1.com

pbsexec  g03 ${name%.*}_am1.com
~/bin/jkp_extract_geom.awk ${name%.*}_am1.log > ${name%.*}_am1coords.axyz

cat -  ${name%.*}_am1coords.axyz >  ${name%.*}_b3lypopt.com << EOF
%chk=${name%.*}_b3lypopt.chk
%Mem=${MEMg}
%nproc=${CPUS}
#p opt b3lyp/6-31g*

B3lyp opt autojob from Smiles ${name}

0 1
EOF

  #blank line wanted for g03
  echo >> ${name%.*}_b3lypopt.com

pbsexec g03 ${name%.*}_b3lypopt.com

cat >  ${name%.*}_b3lyp_tddft.com << EOF
%chk=${name%.*}_b3lypopt.chk
%Mem=${MEMg}
%nproc=${CPUS}
#p sp guess=read geom=checkpoint scf=verytight b3lyp/6-31g* td(50-50,nstates=3)

B3lyp sp td dft autojob from Smiles ${name}

0 1

EOF

pbsexec g03 ${name%.*}_b3lyp_tddft.com

cp ${name%.*}* /work/jmf02/DA/ 
EOW

