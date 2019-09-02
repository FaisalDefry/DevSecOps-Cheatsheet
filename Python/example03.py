#!/Users/faisaldefry/python3-project/py3-env/bin/python
import requests
from bs4 import BeautifulSoup

BASE_URL = 'http://localhost:8080/adminx'
USERNAME = "faisal"
PASSWORD = ".faisal"

s = requests.Session()

data = {"username": USERNAME, "password": PASSWORD}
r = s.post(f'{BASE_URL}/login/post_login', data=data)

soup = BeautifulSoup(r.text, 'html.parser')
print(soup)
if soup.find(id='tasklist') is not None:
	print('Successfuly logged in')
else:
	print('Authentication Error')