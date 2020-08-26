# tifAPI
Данная библиотека добавить формат изображений в ComputerCraft
## Установка
Для устоновки напиши `pastebin get EnZksdhv tifIntaller`
После установки, напиши `tifInstaller <Путь, где будет папка tif>`
**Поздравляю 🎉**! Ты установил tifAPI!
## Документация
### Что такое TifImageError?
Это таблица с ошибкой
Пример ошибки:
```lua
local TifImageFunc = api.loadImage("test.tif")
local er = TifImageFunc.drawPixel(1, 1) -- Забыли PaintColor
-- er = {true, "PaintColor"}
```
Пример БЕЗ ошибки:
```lua
local TifImageFunc = api.loadImage("test.tif")
local er = TifImageFunc.drawPixel(1, 1, "1")
-- er = {false}
```
Шаблон ошибки:
```lua
{boolean Error, string Invalid argument}
```
### require("<Папка, в которой папка tif>/tif.api") 
#### Импортировать библиотеку
 
### api.loadImage(string filename): table TifImageFunc
#### Загрузить изображение
#### Пример: 
```lua
local TifImageFunc = api.loadImage("test.tif")
```
#### TifImageFunc - это таблица с функциями, для работы с изображениями
### TifImageFunc.drawImage(number x, number y\[, table monitor\]): return TifImageError

#### Нарисовать изображение на мониторе monitor (если не укажите, то будет в консоле) на координатах x, y
#### Пример: 
```lua
TifImageFunc.drawImage(2, 2)
```
#### Пример с monitor:
```lua
monitor = peripheral.wrap("top")
TifImageFunc.drawImage(1, 1, monitor)
```
### TifImageFunc.drawPixel(number x, number y, string PaintColor): table TifImageError
#### Нарисовать пиксель на координатах x, y
#### Пример: 
```lua
TifImageFunc.drawPixel(2, 2, "4") -- Нарисовать пиксель на координатах 2, 2 жёлтого цвета
```
### TifImageFunc.drawLine(number startX, number startY, number endX, number endY, string PaintColor): table TifImageError
#### Нарисовать линию
#### Пример:
```lua
TifImageFunc.drawLine(1, 1, 5, 1, "1") -- Нарисовать линию начиная с 1, 1(x, y) до 5, 1(x, y) цветом "1"
```
### TifImageFunc.drawBox(number startX, number startY, number endX, number endY, string PaintColor\[, boolean filled\]): table TifImageError
#### Нарисовать прямоугольник
#### Если есть `filled` - тогда прямоугольник будет заполнен
#### Пример без `filled`:
```lua
TifImageFunc.drawBox(1, 1, 5, 3, "1") -- Нарисовать прямоугольник начиная с 1, 1(x, y) до 5, 1(x, y) цветом "1"
```
#### Пример c `filled`:
```lua
TifImageFunc.drawBox(1, 1, 5, 3, "1", true) -- Нарисовать заполненый прямоугольник начиная с 1, 1(x, y) до 5, 1(x, y) цветом "1"
```
### TifImageFunc.fill(number width, number height, string PaintColor): table TifImageError
#### Полностью заполнить изображение каким-либо цветом, и даже изменить размер изображения
#### Пример: 
```lua
TifImageFunc.fillImage(5, 3, "e") -- Изменить размер на 5x3, и закрасить красным цветом
```
### TifImageFunc.save(string filename): nil
#### Сохранить изображение как filename
#### Пример: 
```lua
TifImageFunc.save("test.tif")
```
### TifImageFunc.getImage(): nil
#### Возвращает TifImage
#### TifImage - это таблица с изображением
##### P.s. Нужно **ТОЛЬКО** для дебага
### api.paintToDecimal(string PaintColor): return number Decimal
#### Конвертирует PaintColor в Decimal
### api.convertToPaint(number Decimal) --return string PaintColor
#### Конвертирует Decimal в PaintColor
