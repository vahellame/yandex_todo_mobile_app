# README

Это проект на Flutter, представляющий собой приложение для управления задачами (TODO). Ниже приведены инструкции по настройке и запуску проекта.

## Предварительные требования

Перед продолжением убедитесь, что у вас установлены следующие программы:

- Flutter SDK: [Инструкция по установке](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Инструкция по установке](https://dart.dev/get-dart)

## Настройка

1. Клонируйте репозиторий проекта на ваш компьютер с помощью следующей команды:

   ```shell
   git clone https://github.com/vahellame/yandex_todo_mobile_app
   ```

2. Перейдите в директорию проекта:

   ```shell
   cd yandex_todo_mobile_app
   ```

3. Установите зависимости проекта, выполнив следующую команду:

   ```shell
   flutter pub get
   ```

4. Сгенерируйте необходимые файлы с помощью `build_runner`, выполните следующую команду:

   ```shell
   dart run build_runner build --delete-conflicting-outputs
   ```

## Запуск проекта

После завершения настройки вы можете запустить проект Flutter с помощью следующей команды:

```shell
flutter run
```

Эта команда запустит приложение на подключенном устройстве или эмуляторе.

## Скриншоты

Ниже представлены скриншоты приложения:

<div style="display:flex;justify-content:center">
    <img src="screenshots/1.png" alt="Скриншот 1" width="270" />
    <img src="screenshots/2.png" alt="Скриншот 2" width="270" />
    <img src="screenshots/3.png" alt="Скриншот 3" width="270" />
</div>

## Загрузка

Вы также можете загрузить готовую собранную версию приложения для установки на устройство Android. Нажмите на ссылку ниже, чтобы скачать APK-файл:

[Скачать приложение](https://github.com/vahellame/yandex_todo_mobile_app/releases/download/1.0.0/yandex_todo.apk)

После скачивания APK-файла, установите его на устройстве Android и запустите приложение.

## Создание APK-файла

Если вы хотите самостоятельно создать APK-файл, выполните следующие шаги:

1. Введите следующую команду для сборки релизной версии приложения:

   ```shell
   flutter build apk
   ```

2. После успешной сборки вы найдете APK-файл проекта в директории `build/app/outputs/apk/release/app-release.apk`.

Теперь вы можете установить APK-файл на устройстве Android и запустить приложение.