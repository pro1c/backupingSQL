﻿Папка со скриптами для разных нужд.


set-rights.ps1 - создание прав на папку
    1. выбирает все папки в каталоге запуска
    2. ищет пользователя в AD по названию папки
    3. если найден пользователь то:
        2.1. устанавливает FullControl права на эту папку для этого пользователя
        2.2. снимает inheritance прав с этой папки с оставлением всех ролей
        2.3. удаляет права для пользователя "Пользователи домена"


backuping-all.cmd - принимает все изменения и помещает в git-репозиторий файлы 
