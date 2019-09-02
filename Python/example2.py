#!/usr/bin/env python3.7
import sys
import requests

r = requests.get('http://localhost:8080/test/index.html')
print(r.text)