#!/usr/bin/env bash

path=/tmp
path=/var/www/static.mah.priv.at/cors/gribs
model=icon-d2
extra=
extra='-v -d'
extra='-v'
grid=regular-lat-lon
single_level='relhum_2m u_10m v_10m vmax_10m t_2m'
model_level='u v w t p qv'
time_invariant='hhl'

# multi-levels: 25-65
# wieviele steps? 1 step = 1h  -> 4-20h
min_level=1
max_level=65
max_step=0


latest_timestamp=`python3 opendata-downloader.py --get-latest-timestamp --model ${model}`

gribdir=${path}/${model}/${latest_timestamp}

echo "gribdir:" ${gribdir}
echo "start:" `date`

mkdir -p ${gribdir}


#python3 opendata-downloader.py  --compressed  ${extra} \
#      --model ${model}  \
#      --grid  ${grid} \
#      --single-level-fields ${single_level}  \
#      --max-time-step ${max_step}  --directory ${gribdir}
#

python3 opendata-downloader.py --compressed ${extra} \
      --model ${model}  \
      --grid  ${grid} \
      --time-invariant-fields  ${time_invariant}  \
      --max-time-step ${max_step}  \
      --min-model-level ${min_level}  \
      --max-model-level ${max_level}  \
      --directory ${gribdir}

echo "finish:" `date`