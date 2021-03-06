#!/bin/bash
#Use me by pasting this line into shell so that the env variable ATLAS_PROD gets set up where you choose:
#source ./util/create_test_env.sh /var/tmp/ATLAS_PROD

export ATLAS_PROD=${1:-"/var/tmp/atlas_prod"}
REMOTE_ATLAS_PROD=ebi-cli:/nfs/production3/ma/home/atlas3-production

mkdir -p $ATLAS_PROD/bioentity_properties
mkdir -p $ATLAS_PROD/bioentity_properties/archive
mkdir -p $ATLAS_PROD/bioentity_properties/archive/ensembl_x_y
mkdir -p $ATLAS_PROD/bioentity_properties/archive/wbps_z
mkdir -p $ATLAS_PROD/bioentity_properties/archive/reactome_ensx_y
mkdir -p $ATLAS_PROD/bioentity_properties/archive/array_designs_x_y_z
mkdir -p $ATLAS_PROD/bioentity_properties/go
mkdir -p $ATLAS_PROD/bioentity_properties/interpro
mkdir -p $ATLAS_PROD/bioentity_properties/mirbase
mkdir -p $ATLAS_PROD/bioentity_properties/array_designs
mkdir -p $ATLAS_PROD/bioentity_properties/array_designs/current
mkdir -p $ATLAS_PROD/bioentity_properties/array_designs/backfill
mkdir -p $ATLAS_PROD/bioentity_properties/annotations
mkdir -p $ATLAS_PROD/bioentity_properties/annotations/ensembl
mkdir -p $ATLAS_PROD/bioentity_properties/annotations/wbps
mkdir -p $ATLAS_PROD/bioentity_properties/annotations/mirbase

ln -fhs $ATLAS_PROD/bioentity_properties/archive/ensembl_x_y $ATLAS_PROD/bioentity_properties/ensembl
ln -fhs $ATLAS_PROD/bioentity_properties/archive/reactome_ensx_y $ATLAS_PROD/bioentity_properties/reactome
ln -fhs $ATLAS_PROD/bioentity_properties/archive/wbps_z $ATLAS_PROD/bioentity_properties/wbps
ln -fhs $ATLAS_PROD/bioentity_properties/archive/array_designs_x_y_z $ATLAS_PROD/bioentity_properties/array_designs/current


echo -e "GO:0019952\tGO:0000003" > $ATLAS_PROD/bioentity_properties/go/go.alternativeID2CanonicalID.tsv

mkdir -p $ATLAS_PROD/analysis/baseline/proteomics/experiments
mkdir -p $ATLAS_PROD/analysis/baseline/rna-seq/experiments
mkdir -p $ATLAS_PROD/analysis/differential/microarray/experiments
mkdir -p $ATLAS_PROD/analysis/differential/rna-seq/experiments

mkdir -p $ATLAS_PROD/gtfs

scp $REMOTE_ATLAS_PROD/bioentity_properties/bioentityOrganism.dat $ATLAS_PROD/bioentity_properties/bioentityOrganism.dat

scp -r $REMOTE_ATLAS_PROD/analysis/baseline/proteomics/experiments/E-PROT-1 $ATLAS_PROD/analysis/baseline/proteomics/experiments
scp -r $REMOTE_ATLAS_PROD/analysis/baseline/rna-seq/experiments/E-MTAB-513 $ATLAS_PROD/analysis/baseline/rna-seq/experiments
scp -r $REMOTE_ATLAS_PROD/analysis/differential/microarray/experiments/E-GEOD-57907 $ATLAS_PROD/analysis/differential/microarray/experiments
scp -r $REMOTE_ATLAS_PROD/analysis/differential/microarray/experiments/E-GEOD-1301 $ATLAS_PROD/analysis/differential/microarray/experiments
scp -r $REMOTE_ATLAS_PROD/analysis/differential/rna-seq/experiments/E-GEOD-54705 $ATLAS_PROD/analysis/differential/rna-seq/experiments
