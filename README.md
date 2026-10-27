# Advent of Code

Решения [Advent of Code](https://adventofcode.com) на Swift. Каждый день — это тесты: пример из условия и настоящий ввод.

## Структура

```
Sources/
  AoCKit/        общий тулкит: input(year:day:), Point, Grid, ...
  AoC2024/       решения года: Day16.swift, ...
Tests/
  AoCKitTests/
  AoC2024Tests/  Day16Tests.swift, ...
Inputs/          2024/day16.txt, ... (в .gitignore)
Templates/       шаблоны для new-day.sh
```

## Новый день

```sh
./new-day.sh 2024 16
```

Скрипт создаёт `Sources/AoC2024/Day16.swift`, `Tests/AoC2024Tests/Day16Tests.swift` и пустой `Inputs/2024/day16.txt`.

1. Вставь пример из условия в `example` и ожидаемый ответ в `part1Example`.
2. Вставь свой ввод в `Inputs/2024/day16.txt`.
3. Запусти `part1()` с `== 0`: в ошибке будет видно `(day.part1() → 1234) == 0`.
4. Сдай ответ и впиши его в тест, тогда он станет регрессионным.

Новый год: добавить его в `years` в `Package.swift` (и в схему Xcode, чтобы его тесты были в ⌘U).

## Запуск

Xcode: открыть `Package.swift`, кликнуть ромбик у теста или нажать ⌘U. Схема `advent-of-code-Package` запускает тесты в Release.

Терминал:

```sh
swift test -c release --filter AoC2024Tests.Day16Tests
swift test -c release --filter "AoC2024Tests.Day16Tests/part2()"
```

Без `-c release` решения на сетках и строках работают в 10–100 раз медленнее.

## Ввод

Ввод личный, и автор AoC просит его не публиковать, поэтому `Inputs/` не коммитится.
