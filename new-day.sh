#!/bin/sh
# Создаёт решение и тесты дня из шаблонов: ./new-day.sh 2024 16
set -eu

if [ $# -ne 2 ]; then
    echo "usage: $0 <year> <day>" >&2
    exit 1
fi

year=$1
day=$(printf "%d" "$2")
dd=$(printf "%02d" "$day")
root=$(cd "$(dirname "$0")" && pwd)

source="$root/Sources/AoC$year/Day$dd.swift"
tests="$root/Tests/AoC${year}Tests/Day${dd}Tests.swift"
input="$root/Inputs/$year/day$dd.txt"

if [ -e "$source" ] || [ -e "$tests" ]; then
    echo "Day $dd for $year already exists" >&2
    exit 1
fi

mkdir -p "$(dirname "$source")" "$(dirname "$tests")" "$(dirname "$input")"

render() {
    sed -e "s/DayXX/Day$dd/g" -e "s/AoCYYYY/AoC$year/g" -e "s/YYYY/$year/g" -e "s/day: D)/day: $day)/g" -e "s|day/D$|day/$day|" "$1"
}

render "$root/Templates/DayXX.swift" > "$source"
render "$root/Templates/DayXXTests.swift" > "$tests"
touch "$input"

echo "Created:"
echo "  ${source#"$root"/}"
echo "  ${tests#"$root"/}"
echo "  ${input#"$root"/} (вставь ввод с https://adventofcode.com/$year/day/$day/input)"

if ! grep -q "$year" "$root/Package.swift"; then
    echo "warning: добавь $year в массив years в Package.swift" >&2
fi
