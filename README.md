# Week 04. "DB for Testers" (Slurm Навыкум "Build Containers!")

## Задача

Наши тестировщики прониклись идеями контейнеризации и активно начинают использовать Docker в своих тестах (ручных, автоматизированных и т.д.)

Им очень нравится идея, что они могут просто взять контейнер PostgreSQL, закинуть туда БД и запускать тестируемые приложения с нужными данными

Но вот проблема, они работают следующим образом:
1. Поднимают чистый контейнер
2. Инициализируют его данными (закидывая в `docker-entrypoint-initdb.d` конечно же)
3. Запускают серию тестов

После этого им снова нужен чистый контейнер с теми же данными (т.е. приходится повторять шаги 1-2)

Иногда эти шаги достаточно длительные &ndash; см. пример в `docker-entrypoint-initdb.d`

Поэтому они очень просят сделать им образ уже сразу с инициализированным PostgreSQL, где в базе уже будут готовые данные (мы, конечно, понимаем, что это можно сделать и через `docker commit`, но давайте попробуем обойтись `docker build`, раз уж наш Навыкм про сборку контейнеров)

Название базы и её владельца (и пароль, конечно же) нужно передавать через аргументы при сборке образа

### Что нужно сделать

Соберите образ с инициализированной БД, используя данные из `docker-entrypoint-initdb.d` (для этого, конечно же, нужно написать `Dockerfile`)

В GitHub Actions при сборке через аргументы передавайте следующие данные:
1. Имя БД &ndash; `db` (`ARG DBNAME`)
2. Имя пользователя &ndash; `app` (`ARG DBUSER`)
3. Пароль пользователя &ndash; `pass` (`ARG DBPASS`)

Никаких доп.настроек не нужно

В собранном образе должен запускаться PostgreSQL на порту 5432 с инициализированной базой

### Требования

1. Всё должно быть оформлено в виде публичного репозитория на GitHub
2. Вся сборка образов должна проходить через GitHub Actions
3. Образ должен выкладываться в GitHub Container Registry (GHCR)
