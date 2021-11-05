#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
from bs4 import BeautifulSoup
from  datetime import date, timedelta
import validators
import sys

import dominate
from dominate.tags import *

from selenium import webdriver

from http.server import HTTPServer, BaseHTTPRequestHandler


options = webdriver.ChromeOptions()
options.add_argument('--ignore-certificate-errors')
options.add_argument('--incognito')
options.add_argument('--headless')
prefs = {"profile.managed_default_content_settings.images": 2}
options.add_experimental_option("prefs", prefs)
driver = webdriver.Chrome("/home/k/chromedriver", options=options)


city='rabat'
today = date.today().strftime("%d/%m/%Y")
yesterday = (date.today()+ timedelta(days=-1)).strftime("%d/%m/%Y")
#print(today)
#print(yesterday)

doc = dominate.document(title='Dominate your HTML')

with doc.head:
    link(rel='stylesheet', href='https://cdn.jsdelivr.net/npm/water.css@2/out/dark.css')
    link(rel='stylesheet', href='style.css')
    meta(content='text/html;charset=utf-8' ,  http_equiv='Content-Type')
    meta(content="utf-8" ,  http_equiv="encoding")



URL = "http://www.alwadifa-maroc.com"

# user define function
# Scrape the data
# and get in string
def getdata(url):
    r = requests.get(url)
    return r.text
# Get Html code using parse
def html_code(url):
    # pass the url
    # into getdata function
    htmldata = getdata(url)
    soup = BeautifulSoup(htmldata, 'html.parser')
    # return html code
    return(soup)

def html_code_with_SL(url):
    driver.get(url)
    page_state = driver.execute_script('return document.readyState;')
    while(page_state != 'complete'):
        page_state = driver.execute_script('return document.readyState;')
    page_source = driver.page_source
    soup = BeautifulSoup(page_source, "html.parser")
    return (soup)

def alwadifa():
    doc.add(h2("al wadifa maroc"))
    list = ul()
    soup = html_code(URL)
    job_elems = soup.find_all("div", {"class": "bloc-content"})
    for elem in job_elems:
        date = elem.find("li")
        if (date.text == today or date.text == yesterday):
            elem = elem.find("a")
            title = elem.text
            link = URL+elem["href"]
            list += li(a(title, href=link), __pretty=False)
    doc.add(list)


def get_annones(url):
    list = ul()
    if  not validators.url(url):
        print (url)
        sys.exit("invalid url")
    soup =  html_code(url)
    soup = soup.find(class_="cars-list")
    titles  = soup.find_all("li")
    answer = ""
    date = ""
    description = ""
    for job_elem in titles:
        if (job_elem.find(class_='time') != None):
            date = job_elem.find(class_='time')
            if ("Hier" in date.text):
                URL = job_elem.find("a").get("href")
                link = "https://www.marocannonces.com/"+  URL
                title = job_elem.find(class_='holder').find("h3").text
                list += li(a(title, href=link), __pretty=False)
    doc.add(list)
    return(date.text)


# maroc annonce
def marocannonces(base_url):
    doc.add(h2("maroc annonce"))
    last_item = 'Hier'
    i = 2
    url = base_url
    while ( "Hier" in last_item or "Aujourd'hui" in last_item):
        last_item = get_annones(url)
        url = base_url +"?pge=" + str(i)
        i += 1
        print(i)


# indeed
def indeed():
    doc.add(h2("indeed"))
    list = ul()
    Location = "Noida%2C+Uttar+Pradesh"
    job =""
    base_url = "https://in.indeed.com"
    url = "https://in.indeed.com/jobs?q="+job+"&l="+Location
    url =base_url+"/emplois?l=Rabat&limit=50&fromage=1&lang=en&vjk=39d11a8f1e1fa98d"
    soup = html_code(url)
    job_elems = soup.find_all('a', class_="tapItem")
    for elem in job_elems:
        title = elem.select('.jobTitle span')[1].text
        link = elem["href"]
        list += li(a(title, href= base_url + link), __pretty=False)
    doc.add(list)


def extrat_positon(positions):
    list = ul()
    keywords =["PHD", "PhD","Ph.D"," Doctoral "," Doctorate " ]
    for position in positions:
        is_phd = False
        title_and_link = position.find(class_= "col-sm-12")
        title = title_and_link.text
        for keyword in keywords:
            if keyword in title:
                is_phd = True
        if is_phd:
            link = title_and_link.find('a')["href"]
            list += li(a(title, href="https://euraxess.ec.europa.eu"+link), __pretty=False)
    doc.add(list)

# euraxess
def euraxess(keyword):
    doc.add(h2("euraxess: "+ keyword))
    i = 1
    base_url ="https://euraxess.ec.europa.eu/jobs/search/field_research_field/astronomy-33/field_research_field/physics-344/field_research_profile/first-stage-researcher-r1-446?keywords=" + keyword 
    URL = base_url 
    while (1):
        soup = html_code_with_SL(URL)
        positions = soup.find_all("div", {"class": "views-row"})
        if (positions == []):
            break
        extrat_positon (positions)
        URL= base_url +  "&page="+str(i)
        i+=1
        print(i)


# inspire
def inspire():
    URL = 'https://inspirehep.net/jobs?sort=mostrecent&size=100&page=1&q=&rank=PHD&rank=MASTER'
    soup = html_code_with_SL(URL)
    job_elems = soup.find_all(class_='mv2')
    doc.add(h2("inspire"))
    list = ul()
    for elem in job_elems:
        date = elem.find(class_='ant-row-space-between')
        old_dates = ["days" , "year" , "month"]
        if not any( old_date in date.text for old_date in old_dates):
            # print(date.text)
            position = elem.find(class_='result-item-title')
            title = position.text
            link = position["href"]
            list += li(a(title, href=link), __pretty=False)
    doc.add(list)

# rekrute 
def rekrute():
    doc.add(h2("rekrute"))
    base_url = "https://www.rekrute.com"
    list = ul()
    i = 1
    while(1):
        url = base_url +"/offres.html?s=3&p="+str(i)+"&o=1&positionId%5B0%5D=13&regionId=12"
        soup = html_code(url)
        job_elems = soup.select(".post-id h2 a")
        if len(job_elems) == 0:
            break
        for elem in job_elems:
            title = elem.text
            link = elem["href"]
            list += li(a(title, href=base_url + link), __pretty=False)
        i+=1
        print(i)
    doc.add(list)


def anapec():
    i =1
    base_url = "http://anapec.org"
    more =True
    while(more):
        url= base_url + "/sigec-app-rv/chercheurs/resultat_recherche/page:"+str(i)+"/region:4/language:fr"
        soup = html_code(url)
        job_elems = soup.select(".tablesorter .header tr")
        for elem in job_elems:
            date =  elem.select("td")[2].text
            if (date != today or date != yesterday):
                more = False
            location = elem.select("td")[-1].text
            if city in location.lower():
                link = elem.select_one("td a")["href"]
                title = elem.select("td")[3].text
                print(title , link)
        i+=1


anapec()
exit()
print("alwadifa")
alwadifa()
print("indeed")
indeed()
print("earaxess 1")
euraxess("computational%20physics")
print("earaxess 2")
euraxess("%20particle%20physics")

print("inspire")

inspire()
print("rekrute")
rekrute()
url = ("https://www.marocannonces.com/maroc/offres-emploi-rabat-b309-t590.html")
marocannonces(url)



folder = "/home/k/Desktop/"
file = open(folder  + "jobs.html", "w")



doc.add(script(  dominate.util.raw(r"""
function checkRtl( character ) {
    var RTL = ['ا','ب','پ','ت','س','ج','چ','ح','خ','د','ذ','ر','ز','ژ','س','ش','ص','ض','ط','ظ','ع','غ','ف','ق','ک','گ','ل','م','ن','و','ه','ی'];
    return RTL.indexOf( character ) > -1;
};

function isArabic(text) {
    var pattern = /[\u0600-\u06FF\u0750-\u077F]/;
    result = pattern.test(text);
    return result;
}

var divs = document.getElementsByTagName( 'ul' );

for ( var index = 0; index < divs.length; index++ ) {
    if( isArabic( divs[index].textContent ) ) {
        divs[index].className = 'rtl';
    } else {
        divs[index].className = 'ltr';
    };
};

var links = document.links;
for (var i = 0; i < links.length; i++) {
     links[i].target = "_blank";
}
"""), type="text/javascript"))

doc.add(style(src="style.css"))
file.write(doc.render())
file.close()
class Serv(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.path = '/jobs.html'
        try:
            file_to_open = open("/home/k/Desktop"+ self.path).read()
            self.send_response(200)
        except:
            print(self.path)
            file_to_open = self.path 
            self.send_response(404)
        self.end_headers()
        self.wfile.write(bytes(file_to_open, 'utf-8'))


print("start the server")
httpd = HTTPServer(('localhost',8080),Serv)
httpd.serve_forever()
