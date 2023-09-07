# Bibliotecas
import csv
import requests
from bs4 import  BeautifulSoup
import pandas as pd

# URL da página que queremos fazer scraping
#url = "https://www.climatempo.com.br/previsao-do-tempo/cidade/259/recife-pe"
url = "https://www.climatempo.com.br/previsao-do-tempo/15-dias/cidade/259/recife-pe"

# Conexão: Enviar uma solicitação GET para a URL
response = requests.get(url)

# Verificar se a solicitação foi bem-sucedida (status 200)
if response.status_code == 200:
    # Parse a página com o BeautifulSoup
    soup = BeautifulSoup(response.text, "html.parser")

    # Elementos HTML que contêm os títulos da informação que queremos
    dia = soup.find_all("div", class_= "date-inside-circle")
    desc = soup.find_all("p", class_="-gray -line-height-24 _center")


    #cria arquivo csv
    with open('datas.csv', mode='w', newline='', encoding='utf-8') as file:
      writer = csv.writer(file)
      headers = ['Dia']
      writer.writerow(headers)

      # Loop pelos elementos e imprimir os dias
      for headline in dia:

          #cada dia
          dataPrev = [headline.text.replace('\n', ' ')]

          # Escrever no csv usando DictWriter
          writer = csv.DictWriter(file, fieldnames=headers)
          # É passado o csv, e então as colunas.

          # Chama a função
          writer.writerow({'Dia': dataPrev})



else:
    print("Falha ao acessar a página:", response.status_code)

# Verificar se a solicitação foi bem-sucedida (status 200)
if response.status_code == 200:
    # Parse a página com o BeautifulSoup
    soup = BeautifulSoup(response.text, "html.parser")

    # Elementos HTML que contêm os títulos da informação que queremos
    dia = soup.find_all("div", class_= "date-inside-circle")
    desc = soup.find_all("p", class_="-gray -line-height-24 _center")


    #cria arquivo csv
    with open('desc.csv', mode='w', newline='', encoding='utf-8') as file:
      writer = csv.writer(file)
      headers = ['Descricao']
      writer.writerow(headers)


      # Loop pelos elementos e imprimir as descrições
      for descrition in desc:

          # cada descrição
          descPrev = [descrition.text.replace('\n', ' ')]

          # Escrever no csv usando DictWriter
          writer = csv.DictWriter(file, fieldnames=headers)
          # É passado o csv, e então as colunas.

          # Chama a função
          writer.writerow({'Descricao': descPrev})


else:
    print("Falha ao acessar a página:", response.status_code)

df1 = pd.read_csv('datas.csv', encoding='utf-8')
df2 = pd.read_csv('desc.csv', encoding='utf-8')

df1.head(5)

df2.head(5)

resultado = pd.concat([df1, df2], axis=1)
resultado.to_csv('export_data.csv', index=False)

df = pd.read_csv('export_data.csv', encoding='utf-8')
df.head(10)