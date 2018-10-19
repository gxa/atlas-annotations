# Atlas Annotations (v1.0.0)


This is a repository for scripts that we use for retrieving annotations used by Atlas Solr searches and more.
It also stores the config of Atlas properties per species name and which public BioMart database we retrieve it from.

Version 1.0.0 was used for the August/September 2018 Atlas (bulk and single cell) releases.

### Dependencies
src - only java and [Ammonite](http://www.lihaoyi.com/Ammonite/)
ensemblUpdate.sh - various bash utilities,mysql, environment variable $ATLAS_PROD (see util/create_test_env.sh to work with this script)

We are in the process of detaching this from our direct filesystem dependencies. As such, the use of $ATLAS_PROD is being replaced
everywhere to point more specificly to the exact needs of each script.

### Entry points

`sh/ensembl/ensemblUpdate.sh`
the entry point to the annotations update process

`sh/atlas_species.sh`
Regenerate the species file based on annotation sources config

`amm -s src/pipeline/retrieve/Retrieve.sc`
Runs only the BioMart mapping verification for defined organisms (depends on the organisms file inside either
`annsrc` or the overriding `$ANNOTATION_SOURCES` path). These tests are automated in our internal Jenkins setup (http://193.62.52.166:30752/jenkins)
under the `Ensembl Update` tab.

### Structure

#### ./annsrcs
Annotation source files describing the mapping of Atlas properties we want to foreign properties with sources of their retrieval

#### ./util
Tools that make the Atlas team's work easier, including scripts to automatically update the annotation sources

#### ./sh
Executables that the Atlas development team runs to update their annotations

#### ./src
Scala (Ammonite) source code

|  path  	|   what it does	|
|:-:	|:-:	|
|   `./src/pipeline/Start.sc`	|   entry point for fetching annotations	|
|   `./src/pipeline/is_ready/PropertiesAdequate.sc`	|  check annotation sources vs what we think needs to be in them (e.g. all array designs ) |
|   `./src/pipeline/retrieve`	|  fetch annotations - internals 	|
|  ` ./src/go/PropertiesFromOwlFile.sc`	|   Parse the go.owl for what we need	|
|   `./src/interpro/Parse.sc	`|   Parse the Interpro provided file	|
|  ` ./src/atlas/AtlasSpecies.sc`	|   Create the species config for the webapp	|
