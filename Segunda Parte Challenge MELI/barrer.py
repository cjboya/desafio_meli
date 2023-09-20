import os
import csv

try:
    import requests
except ModuleNotFoundError:
    print("No estan las dependencias para poder correr el programa")
    print("Se procede a instalarlas")
    if os.name == "nt":
        os.system("pip install requests")
    else:
        os.system("pip3 install requests")
    import requests


# Definir los términos de búsqueda que te interesen
terminos_de_busqueda = ["chromecast", "Google Home", "Apple TV", "Amazon Fire TV"]

# Crear un archivo CSV para escribir los resultados
with open('resultados.csv', 'w', newline='', encoding='utf-8') as csvfile:
    fieldnames = ['Titulo', 'Precio', 'Condicion', 'Vendedor', 'Ciudad']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    
    # Escribir encabezados en el archivo CSV
    writer.writeheader()
    print("Programa funcionando. No lo detenga. Espere al proximo mensaje...")
    for termino in terminos_de_busqueda:
        
        # Realizar la solicitud a la API de MercadoLibre
        url = f'https://api.mercadolibre.com/sites/MLA/search?q={termino}&limit=50'
        response = requests.get(url)
        
        if response.status_code == 200:
            
            results = response.json()['results']
            
            for result in results:
                
                item_id = result['id']
                
                # Realizar la solicitud para obtener información detallada del ítem
                item_url = f'https://api.mercadolibre.com/items/{item_id}'
                item_response = requests.get(item_url)
                
                if item_response.status_code == 200:
                    item_info = item_response.json()
                    
                    # Utilizar try-except para manejar la posible falta de 'seller'
                    try:
                        vendedor = item_info['seller']['nickname']
                    except KeyError:
                        vendedor = 'No disponible'
                    
                    ciudad = item_info['seller_address']['city']['name']
                    
                    # Escribir los resultados en el archivo CSV
                    writer.writerow({'Titulo': item_info['title'], 'Precio': item_info['price'], 'Condicion': item_info['condition'], 'Vendedor': vendedor, 'Ciudad': ciudad})
        else:
            print(f'Error al buscar {termino}: {response.status_code}')


print('Proceso completado. Los resultados se han guardado en resultados.csv')
