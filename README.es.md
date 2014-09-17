Abrir o montar la .iso, y copiar .sfs, initrd.gz, vmlinuz y cualquier otro archivo necesario (como "zdrv_123.sfs") en el directorio "puppyFiles".

Luego, abra "Settings.nsh" en un editor de texto, y llene con su información ahi. Asegurese de guardarlo!

Ahora ejecute NSIS (C:\Archivos de Programa\NSIS\makensisw.exe), luego arrastre "main.nsi" dentro de la ventana.

Su instalador será creado y puesto en el mismo directorio de main.nsi.

### Tutorial desde Windows 

- Descargar el proyecto PLIC junto con NSIS en el mismo directorio.

#### Enlaces de descarga 

##### [NSIS](http://nsis.sourceforge.net/Main_Page)

##### [Fork de PLIC](https://github.com/Woofshahenzup/PLIC/archive/master.zip)

![screenshot](http://s5.postimg.org/65p5yrmav/PLIC1.png)

- Una vez instalado NSIS, ir al directorio C:\Archivos de Programa\NSIS\ y ejecutar makensisw.exe y dejar abierta la ventana.

![screenshot](http://s5.postimg.org/csbtry3zb/PLIC2.png)

- Abrir como texto el archivo /PLIC/Settings.nsh y llenar con la información relacionada a la .iso.

![screenshot](http://s5.postimg.org/a8blk3r1j/PLIC3.png)

- Extraer los archivos de la iso necesarios hasta el directorio /PLIC/PuppyFiles.

![screenshot](http://s5.postimg.org/n4y4e0xif/PLIC4.png)

- Arrastrar el archivo main.nsi hasta la ventana de makensisw. 

![screenshot](http://s5.postimg.org/3pnckx487/PLIC5.png)

- Empezará a crear el ejecutable.

![screenshot](http://s5.postimg.org/luvpl8ecn/PLIC6.png)

- Casi termina de crearlo.

![screenshot](http://s5.postimg.org/hzsbinv6v/PLIC7.png)

- Revisan que el tamaño de la .iso y del ejecutable sean casi del mismo tamaño.

![screenshot](http://s5.postimg.org/b6wk04trb/PLIC8.png)

- Hice Clon del repositorio para ayudar a traducirlo al español.

![screenshot](http://s5.postimg.org/60gtbcplz/PLIC9.png)

- La ventana interior no toma los acentos o tildes, lo demás en orden.

![screenshot](http://s5.postimg.org/ngfkqsdyf/PLIC99.png)

 Fin.