#!/usr/bin/env bash

PATH_BIOENTITY_PROPERTIES=$ATLAS_PROD/bioentity_properties
PROJECT_ROOT=$(realpath $(dirname $0)/../..)

export SINGULARITYENV_PREPEND_PATH=$PROJECT_ROOT/sh/ensembl
export SINGULARITYENV_ATLAS_PROD=$ATLAS_PROD
export SINGULARITYENV_GET_GO_DEPTHS=${GET_GO_DEPTHS:-"no"}
export SINGULARITYENV_USE_EXISTING_ONTOLOGY_FILES=${USE_EXISTING_ONTOLOGY_FILES:-"no"}
export SINGULARITYENV_EXPERIMENT_SOURCES=$EXPERIMENT_SOURCES

singularity exec \
  --bind $PATH_BIOENTITY_PROPERTIES,$PROJECT_ROOT \
  docker://quay.io/ebigxa/ensembl-update-env:amm1.1.2 ensemblUpdate.sh $@
