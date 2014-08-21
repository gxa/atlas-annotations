#!/bin/bash
# This script retrieves Ensembl gene identifier - Reactome pathway identifier - Reactome pathway name triples and puts them in ${organism}.reactome.tsv files, depending on the organism of the Ensembl gene identifier
# Author: rpetry@ebi.ac.uk

# Change reactomedev.oicr.on.ca to reactomerelease.oicr.on.ca when the latter one is up again
url="http://www.reactome.org/download/current/Ensembl2Reactome.txt"

outputDir=$1
if [[ -z "$outputDir" ]]; then
    echo "Usage: $0 outputDir" >&2
    exit 1
fi

pushd $outputDir
IFS="
"

start=`date +%s`
curl -s -X GET "$url" | awk -F"\t" '{print $1"\t"$6"\t"$2"\t"$4}' | sort -k 1,1 > aux

# Lower-case and replace space with underscore in all organism names; create files with headers for each organism
cat aux | awk -F"\t" '{print $2}' | sort | uniq > aux.organisms
for organism in $(cat aux.organisms); do
    newOrganism=`echo $organism | tr '[A-Z]' '[a-z]' | tr ' ' '_'`
    perl -pi -e "s|$organism|$newOrganism|g" aux
    rm -rf ${newOrganism}.reactome.tsv.gsea.aux
    echo -e "ensgene\tpathwayid\tpathwayname" > ${newOrganism}.reactome.tsv
 done

# Append data retrieved from REACTOME into each of the species-specific files 
# (each file contains the portion of the original data for the species in that file's name)
awk -F"\t" '{print $1"\t"$3"\t"$4>>$2".reactome.tsv"}' aux

# Prepare head-less ensgene to pathway name mapping files for the downstream GSEA analysis
awk -F"\t" '{print $1"\t"$4>>$2".reactome.tsv.gsea.aux"}' aux

# Prepare head-less pathway name to pathway accession mapping files, used to decorate the *.gsea.tsv files produced by the downstream GSEA analysis
awk -F"\t" '{print $4"\t"$3>>$2".reactome.tsv.decorate.aux"}' aux
# Retain only unique rows in *.reactome.tsv.decorate.aux
for f in $(ls *.reactome.tsv.decorate.aux); do
    cat $f | sort | uniq > $f.tmp
    mv $f.tmp $f
done

rm -rf aux*
end=`date +%s`
echo "Operation took: "`expr $end - $start`" s"

popd




