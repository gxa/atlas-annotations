#!/usr/bin/env python

import json
from sys import exit
import logging
import argparse


def get_args():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('-E', '--ensembl',
                            required=True,
                            help='Version of Ensembl')
    arg_parser.add_argument('-EG', '--ensembl_genomes',
                            required=True,
                            help='Version of Ensembl Genome')
    arg_parser.add_argument('-W', '--wormbase_parasite',
                            required=True,
                            help='Version of Wormbase parasite')
    arg_parser.add_argument('-F', '--efo',
                            required=True,
                            help='Version of EFO')
    arg_parser.add_argument('-U', '--efo_url',
                            required=True,
                            help='Version of EFO')
    arg_parser.add_argument('-O', '--output_dir',
                            required=False,
                            default='./',
                            help='Path to output directory')
    args = arg_parser.parse_args()
    return args

logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(message)s',
        datefmt='%d-%m-%y %H:%M:%S')

def main():
    try:
        args = get_args()
        data = {}
        data['ensembl'] = args.ensembl
        data['ensembl_genomes'] = args.ensembl_genomes
        data['wormbase_parasite'] = args.wormbase_parasite
        data['efo'] = args.efo
        data['efo_url'] = args.efo_url

        with open(args.output_dir + '/' + 'release-metadata.json', 'w') as outfile:
            json.dump(data, outfile, indent=2, sort_keys=True)
            logging.info(args.output_dir + '/' + 'release-metadata.json')
        exit(0)

    except Exception as e:
        logging.error("Failed due to {}".format(str(e)))
        raise e

if __name__ == '__main__':
    main()