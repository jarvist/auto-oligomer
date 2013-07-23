module load intel-suite
module load openbabel

for i in *.smi
do
 . scripts/build_tddft_job_from_smile.sh "${i}"
done
