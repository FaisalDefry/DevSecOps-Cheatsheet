#/usr/bin/python3

import json
import os

with open("config.json","r") as input:
  numi_config = json.load(input)

numi_config['database']['db_host'] = os.environ['DB_HOST']
numi_config['database']['db_user'] = os.environ['DB_USER']
numi_config['database']['db_pass'] = os.environ['DB_PASSWORD']

with open("config.json","w") as out:
  json.dump(numi_config,out)

print(numi_config['database'])