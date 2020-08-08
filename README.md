# tifAPI
Данная библиотека добавить формат изображений в ComputerCraft
## Установка
Для устоновки напиши `pastebin get EnZksdhv tifIntaller`
После установки, напиши `tifInstaller <Путь, где будет папка tif>`
**Поздравляю 🎉**! Ты установил tifAPI!
## Документация
### require("<Папка, в которой папка tif>/tif.api") 
#### Импортировать библиотеку
 
### api.loadImage(string filename): table TifImage
#### Загрузить изображение
#### Пример: 
```lua
local image = api.loadImage("test.tif")
```
#### TifImage - это таблица с изображением
### api.drawImage(table TifImage, number x, number y\[, table monitor\]): return nil

#### Нарисовать изображение на мониторе monitor (если не укажите, то будет в консоле) на координатах x, y
#### Пример: 
```lua
api.drawImage(image, 2, 2)
```
#### Пример с monitor:
```lua
monitor = peripheral.wrap("top")
api.drawImage(image, 1, 1, monitor)
```
### api.drawPixel(table TifImage, number x, number y, string PaintColor): return table TifImage
#### Нарисовать пиксель на координатах x, y
#### Пример: 
```lua
image = api.drawPixel(image, 2, 2, "4") -- Нарисовать пиксель на координатах 2, 2 жёлтого цвета
```
### api.fillImage(number width, number height, string PaintColor): return table TifImage
#### Полностью заполнить изображение каким-либо цветом, и даже изменить размер изображения
#### Пример: 
```lua
image = api.fillImage(5, 3, "e") -- Изменить размер на 5x3, и закрасить красным цветом
```
### api.saveImage(table TifImage, string filename): return nil
#### Сохранить изображение как filename
#### Пример: 
```lua
api.saveImage(image, "test.tif")
```
### api.paintToDecimal(string PaintColor): return number Decimal
#### Конвертирует PaintColor в Decimal
### api.convertToPaint(number Decimal) --return string PaintColor
#### Конвертирует Decimal в PaintColor
