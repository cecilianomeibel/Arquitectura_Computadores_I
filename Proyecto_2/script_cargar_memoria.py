def insertar_datos_en_mif(archivo_txt, archivo_mif):
    # Leer los datos del archivo .txt, una línea por cada dato
    with open(archivo_txt, 'r') as archivo:
        datos = [linea.strip() for linea in archivo.readlines()]  # Elimina saltos de línea

    # Leer el contenido existente del archivo .mif
    with open(archivo_mif, 'r') as archivo:
        lineas_mif = archivo.readlines()

    # Buscar la sección CONTENT BEGIN
    indice_content = next(i for i, linea in enumerate(lineas_mif) if "CONTENT BEGIN" in linea)

    # Insertar los datos del archivo .txt en el archivo .mif
    nuevas_lineas = lineas_mif[:indice_content + 1]  # Mantener las líneas anteriores a "CONTENT BEGIN"
    
    for direccion, valor in enumerate(datos):
        # Escribir cada valor en la dirección correspondiente, en formato UNS
        nuevas_lineas.append(f"{direccion} : {valor};\n")

    # Agregar la línea "END;" al final de la memoria
    nuevas_lineas.append("END;\n")

    # Guardar las modificaciones en el archivo .mif
    with open(archivo_mif, 'w') as archivo:
        archivo.writelines(nuevas_lineas)

    print(f"Datos del archivo {archivo_txt} insertados en {archivo_mif} con éxito.")

# Usar la función para insertar los datos de un .txt en un .mif
#insertar_datos_en_mif("imagen_original.txt", "dmemfile.mif")
insertar_datos_en_mif("imagen_2bytes.txt", "dmemfile.mif")