#!/usr/bin/env bash

PATH_BIOENTITY_PROPERTIES=$ATLAS_PROD/bioentity_properties
PROJECT_ROOT=`dirname $0`/../..

SINGULARITYENV_PREPEND_PATH=$PROJECT_ROOT/sh/ensembl
SINGULARITYENV_ATLAS_PROD=$ATLAS_PROD
SINGULARITYENV_GET_GO_DEPTHS=${GET_GO_DEPTHS:-"no"}
SINGULARITYENV_USE_EXISTING_ONTOLOGY_FILES=${USE_EXISTING_ONTOLOGY_FILES:-"no"}
SINGULAIRTYENV_EXPERIMENT_SOURCES=$EXPERIMENT_SOURCES

singularity exec \
  --bind $PATH_BIOENTITY_PROPERTIES,$PROJECT_ROOT \
  docker://quay.io/ebigxa/ensembl-update-env:amm2.3.8 $@
