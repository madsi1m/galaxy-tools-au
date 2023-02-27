#!/usr/bin/env bash

# You will probably need to create a venv and 'pip install -r alphafold/requirements.txt'
# for the script to be able to read the pickle outputs as they contain jax objects.

set -e

KNRM="\e[0m"
KYEL="\e[93m"
KGRN="\e[92m"
KRED="\e[91m"

EXPECT_OUTPUTS="
test-data/monomer_output/extra/plddts.tsv
test-data/monomer_output/extra/model_confidence_scores.tsv
test-data/monomer_output/extra/ranked_0.pkl
test-data/monomer_output/extra/ranked_1.pkl
test-data/monomer_output/extra/ranked_2.pkl
test-data/monomer_output/extra/ranked_3.pkl
test-data/monomer_output/extra/ranked_4.pkl
test-data/multimer_output/extra/plddts.tsv
test-data/multimer_output/extra/model_confidence_scores.tsv
test-data/multimer_output/extra/ranked_0.pkl
test-data/multimer_output/extra/ranked_1.pkl
test-data/multimer_output/extra/ranked_2.pkl
test-data/multimer_output/extra/ranked_3.pkl
test-data/multimer_output/extra/ranked_4.pkl"

printf "${KYEL}TEST monomer output with per-residue scores${KNRM}\n"
python outputs.py test-data/monomer_output -p --model-pkl

echo ""
printf "${KYEL}TEST multimer output with per-residue scores${KNRM}\n"
python outputs.py test-data/multimer_output -p -m --model-pkl

for path in $EXPECT_OUTPUTS; do
  if [ ! -f $path ]; then
    printf "${KRED}FAIL: output file '$path' not found${KNRM}\n"
    exit 1
  fi
done

if [[ "$@" != *"--keep"* ]]; then
  echo ""
  printf "${KGRN}Removing output data...\n"
  rm -rf \
    test-data/*mer_output/extra
else
    printf "${KGRN}Output files created:
    test-data/*mer_output/extra/plddts.tsv
    test-data/*mer_output/extra/model_confidence_scores.tsv
    test-data/*mer_output/extra/model_*.pkl\n"
fi

printf "\nPASS\n\n${KNRM}"
