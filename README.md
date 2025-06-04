# Описание проекта

 **Cardly** - это сервис для обмена коллекционными карточками и наборами, включая карточки с изображениями животных, пейзажей и т.д.

## Сборка и развертывание

### Требования

#### Для мобильного приложения:
- Flutter SDK (версия указана в pubspec.yaml)
- Android Studio
- JDK 17 или выше
- Android SDK (для Android сборки)


#### Для бэкенда:
- JDK 17 или выше
- Kotlin 1.9.25 или выше
- Docker и Docker Compose
- Gradle 8.13 или выше
- Spring Boot 3.4.4 или выше

### Сборка мобильного приложения

1. Перейдите в директорию frontend:
```bash
cd frontend
```

2. Установите зависимости:
```bash
flutter pub get
```

3. Для сборки Android APK:
```bash
flutter build apk --release
```
APK файл будет находиться в `build/app/outputs/flutter-apk/app-release.apk`

### Развертывание бэкенда

1. Перейдите в директорию backend:
```bash
cd backend
```

2. Запустите с помощью Docker Compose:
```bash
docker-compose up --build
```

### Конфигурация

#### Бэкенд
- Для изменения порта или других параметров отредактируйте `docker-compose.yml`

#### Мобильное приложение
- API URL настраивается в `frontend/lib/config/api_config.dart`


---

## Команда (ТП 5-1)


- **[Доброва Анна](https://github.com/dobrayAnika)** - *Team Lead, PM*
- **[Чершнев Евгений](https://github.com/floyzzzy)** - *Аналитик* 
- **[Григорьев Иван](https://github.com/ChipoDev)** - *Backend-разработчик, Frontend-разработчик*
- **[Папонов Данил](https://github.com/danil13231212341)** - *Дизайнер* 
- **[Бирюков Дмитрий](https://github.com/birbik)** - *Тестировщик*
- **[Наумов Никита](https://github.com/capti)** - *DevOps*

---

## Сервисы

- Miro [Roadmap](https://miro.com/app/board/uXjVINPrEUY=/)
- Figma [User paths](https://www.figma.com/board/s0O3zvAPgI4DXJF2BDwrAS/user-paths?node-id=0-1&p=f&t=3ufcMhcMNEwCXd1o-0)
- Figma [UI-kit](https://www.figma.com/design/JEGceh2Gm2ZW494FGIaT0A/Cardly-Brandbook?node-id=44-59&p=f&t=d6eTvzQ74P8yNRGe-0) | [Design](https://www.figma.com/design/ljUhVgNlQLElUQvEOcWSBz/Makets?node-id=0-1&t=3v5P2D8Ki25GG22M-1) | [BrandBook](https://www.figma.com/design/JEGceh2Gm2ZW494FGIaT0A/Cardly-Brandbook?node-id=0-1&t=OAp4Ihb40HiQLx4m-1)

- Jira [Jira-Task Manager](https://id.atlassian.com/invite/p/jira-software?id=QN1WxX0URg-5Gy9WJ0o66w)

- Jira [Jira-Task Manager](https://id.atlassian.com/invite/p/jira-software?id=Pgb7DyoRSL65_Eho2VE_SA)


---

## Документация 

- Техническое задание [PDF](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A2%D0%B5%D1%85%D0%BD%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B5%20%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5.pdf) | [DOCX](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A2%D0%B5%D1%85%D0%BD%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B5%20%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5.docx)
- Roadmap [PDF](https://github.com/capti/Cardly/blob/main/Documentation/roadmap.pdf) | [DOCX](https://github.com/capti/Cardly/blob/main/Documentation/roadmap.docx)
- Целевая аудитория и рынок [PDF](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A6%D0%B5%D0%BB%D0%B5%D0%B2%D0%B0%D1%8F%20%D0%B0%D1%83%D0%B4%D0%B8%D1%82%D0%BE%D1%80%D0%B8%D1%8F%20%D0%B8%20%D1%80%D1%8B%D0%BD%D0%BE%D0%BA.pdf) | [DOCX](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A6%D0%B5%D0%BB%D0%B5%D0%B2%D0%B0%D1%8F%20%D0%B0%D1%83%D0%B4%D0%B8%D1%82%D0%BE%D1%80%D0%B8%D1%8F%20%D0%B8%20%D1%80%D1%8B%D0%BD%D0%BE%D0%BA.docx)
- Ограничения проекта [PDF](https://github.com/capti/Cardly/blob/main/Documentation/%D0%9E%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%87%D0%B5%D0%BD%D0%B8%D1%8F%20%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B0.pdf) | [DOCX](https://github.com/capti/Cardly/blob/main/Documentation/%D0%9E%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%87%D0%B5%D0%BD%D0%B8%D1%8F%20%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B0.docx)
- SWOT-анализ [PDF](https://github.com/capti/Cardly/blob/main/Documentation/SWOT-%D0%B0%D0%BD%D0%B0%D0%BB%D0%B8%D0%B7.pdf) | [DOCX](https://github.com/capti/Cardly/blob/main/Documentation/SWOT-%D0%B0%D0%BD%D0%B0%D0%BB%D0%B8%D0%B7.docx)
- Технические риски [PDF](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A2%D0%B5%D1%85%D0%BD%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B5%20%D1%80%D0%B8%D1%81%D0%BA%D0%B8.pdf) | [DOCX](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A2%D0%B5%D1%85%D0%BD%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B5%20%D1%80%D0%B8%D1%81%D0%BA%D0%B8.docx)

- Итоговый отчет ПМ за 2 этап [PDF](https://github.com/capti/Cardly/blob/main/Documentation/%D0%98%D1%82%D0%BE%D0%B3%D0%BE%D0%B2%D1%8B%D0%B9%20%D0%BE%D1%82%D1%87%D0%B5%D1%82%20%D0%9F%D0%9C%201%20%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B%205%20%D0%B3%D1%80%D1%83%D0%BF%D0%BF%D1%8B%20%D0%B7%D0%B0%202%20%D1%8D%D1%82%D0%B0%D0%BF.pdf) | [DOCX](https://github.com/capti/Cardly/blob/main/Documentation/%D0%98%D1%82%D0%BE%D0%B3%D0%BE%D0%B2%D1%8B%D0%B9%20%D0%BE%D1%82%D1%87%D0%B5%D1%82%20%D0%9F%D0%9C%201%20%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B%205%20%D0%B3%D1%80%D1%83%D0%BF%D0%BF%D1%8B%20%D0%B7%D0%B0%202%20%D1%8D%D1%82%D0%B0%D0%BF.docx)

- BrandBook [PDF](https://github.com/capti/Cardly/blob/main/Documentation/brandbook.pdf)
- [Финансовая модель](https://github.com/capti/Cardly/tree/main/Documentation/Financial%20model)
- [Диаграммы](https://github.com/capti/Cardly/tree/main/Documentation/Diagrams)
- [Пользовательские пути](https://www.figma.com/board/s0O3zvAPgI4DXJF2BDwrAS/user-scenario?node-id=0-1&t=WPJXqXWfhTH9b5QX-1)
- [Swagger API](https://github.com/capti/Cardly/blob/main/Documentation/Swagger/cardly.yaml)




---

## Презентация проекта

[Презентация технического задания- 1 аттестация](https://github.com/capti/Cardly/blob/main/Documentation/%D0%9F%D1%80%D0%B5%D0%B7%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F.pdf)

## Видео защиты проекта 
[Видеопрезентация технического задания RUTUB](https://rutube.ru/video/private/495ed0d28afb267b57f242186af0053f/?p=t5f3gbQUlFE5zIx2hcnJZQ)

---

## Проверка

**Мы оценили**

[Наш чек-лист](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A4%D0%B8%D0%B4%D0%B1%D1%8D%D0%BA.pdf)

**Нас оценили**

- [Команда 5-3](https://github.com/TrefflyTeam/documentation/blob/main/%D0%A0%D0%B5%D0%B7%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D1%82%D1%8B%20%D0%BE%D1%86%D0%B5%D0%BD%D0%B8%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BE%D1%82%20%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B%205.3.pdf)
- [Команда 5-4](https://github.com/TP-Jobsy/jobsy-docs/blob/main/%D0%A7%D0%B5%D0%BA%D0%BB%D0%B8%D1%81%D1%82%201%20%D1%8D%D1%82%D0%B0%D0%BF.pdf)
- [Команда 6-1](https://gitlab.usr0.ru/tailoredtastes/tailoredtastes-documentation/-/tree/master/%D0%9A%D1%80%D0%BE%D1%81%D1%81-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0?ref_type=heads)
- [Команда 6-2](https://github.com/AlexanderLaptev/Taskbench/blob/main/docs/%D0%A7%D0%B5%D0%BA%D0%BB%D0%B8%D1%81%D1%82%201%20%D1%8D%D1%82%D0%B0%D0%BF.pdf)
  
- [Тестовая документация](https://github.com/capti/Cardly/tree/dev/Documentation/Testing)



---

## Презентация проекта

- [Презентация технического задания - 1 аттестация](https://github.com/capti/Cardly/blob/main/Documentation/%D0%9F%D1%80%D0%B5%D0%B7%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F.pdf)
- [Презентация технического задания - 2 аттестация](https://github.com/capti/Cardly/blob/main/Documentation/%D0%9F%D1%80%D0%B5%D0%B7%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F%202%20%D1%8D%D1%82%D0%B0%D0%BF.pdf)

## Видео защиты проекта 
- [Видеопрезентация технического задания RUTUB](https://rutube.ru/video/private/495ed0d28afb267b57f242186af0053f/?p=t5f3gbQUlFE5zIx2hcnJZQ)
- [Видеопрезентация MVP RUTUB](https://rutube.ru/video/private/abbadde6a376d9174a7dde41d90ad139/?p=KPUl4SrlU9Tk7hcOFwXyZQ)

---

## Проверка

**Мы оценили**

- [Наш чек-лист 1](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A4%D0%B8%D0%B4%D0%B1%D1%8D%D0%BA.pdf)
- [Наш чек-лист 2](https://github.com/capti/Cardly/blob/main/Documentation/%D0%A2%D0%9F.%20%D0%A7%D0%B5%D0%BA%D0%BB%D0%B8%D1%81%D1%82%202%20%D1%8D%D1%82%D0%B0%D0%BF.pdf)
  
**Нас оценили**

- [Команда 5-3. 1 аттестация](https://github.com/TrefflyTeam/documentation/blob/main/%D0%A0%D0%B5%D0%B7%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D1%82%D1%8B%20%D0%BE%D1%86%D0%B5%D0%BD%D0%B8%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BE%D1%82%20%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B%205.3.pdf) | [Команда 5-3. 2 аттестация](https://github.com/TrefflyTeam/documentation/blob/main/2%20%D1%8D%D1%82%D0%B0%D0%BF%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B8%20%D0%BE%D1%82%205.3.pdf)
- [Команда 5-4. 1 аттестация](https://github.com/TP-Jobsy/jobsy-docs/blob/main/%D0%A7%D0%B5%D0%BA%D0%BB%D0%B8%D1%81%D1%82%201%20%D1%8D%D1%82%D0%B0%D0%BF.pdf) | [Команда 5-4. 2 аттестация](https://github.com/TP-Jobsy/jobsy-docs/blob/main/checklist/%D0%A7%D0%B5%D0%BA%D0%BB%D0%B8%D1%81%D1%82%202%20%D1%8D%D1%82%D0%B0%D0%BF.pdf)
- [Команда 6-1. 1 аттестация](https://gitlab.usr0.ru/tailoredtastes/tailoredtastes-documentation/-/tree/master/%D0%9A%D1%80%D0%BE%D1%81%D1%81-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0?ref_type=heads) | [Команда 6-1. 2 аттестация](https://gitlab.usr0.ru/tailoredtastes/tailoredtastes-documentation/-/blob/master/%D0%9A%D1%80%D0%BE%D1%81%D1%81-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0/%D0%9A%D1%80%D0%BE%D1%81%D1%81-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0%20%D0%A2%D0%9F%206.1%202%20%D1%8D%D1%82%D0%B0%D0%BF.pdf)
- [Команда 6-2. 1 аттестация](https://github.com/AlexanderLaptev/Taskbench/blob/main/docs/%D0%A7%D0%B5%D0%BA%D0%BB%D0%B8%D1%81%D1%82%201%20%D1%8D%D1%82%D0%B0%D0%BF.pdf) | [Команда 6-2. 2 аттестация](https://github.com/AlexanderLaptev/Taskbench/blob/main/docs/%D0%A7%D0%B5%D0%BA%D0%BB%D0%B8%D1%81%D1%82%202%20%D1%8D%D1%82%D0%B0%D0%BF.pdf)
