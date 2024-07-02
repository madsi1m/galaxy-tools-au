#!/usr/bin/env bash

# python3.8

JAX=0.3.25
JAXLIB=0.3.25+cuda11.cudnn805

cat <<EOF >> /tmp/requirements.txt
absl-py==1.0.0
biopython==1.79
chex==0.0.7
dm-haiku==0.0.9
dm-tree==0.1.6
docker==5.0.0
immutabledict==2.0.0
jax==0.3.25
ml-collections==0.1.0
numpy==1.21.6
pandas==1.3.4
scipy==1.7.2
tensorflow-cpu==2.11.0
matplotlib==3.8.*
EOF

pip install -r /tmp/requirements.txt
pip install jax==${JAX} jaxlib==$JAXLIB -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
