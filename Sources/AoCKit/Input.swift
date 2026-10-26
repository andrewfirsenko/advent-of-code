import Foundation

package struct MissingInputError: Error, CustomStringConvertible {
    package let year: Int
    package let day: Int
    package let path: String

    package var description: String {
        """
        Нет ввода для \(year) Day \(day).
        Скачай https://adventofcode.com/\(year)/day/\(day)/input
        и сохрани в \(path)
        """
    }
}

/// Корень пакета, вычисляется от расположения этого файла:
/// `<root>/Sources/AoCKit/Input.swift`. Так ввод находится одинаково
/// из Xcode и из `swift test`, без ресурсов и `Bundle.module`.
let packageRoot = URL(filePath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

package func inputURL(year: Int, day: Int) -> URL {
    packageRoot.appending(path: "Inputs/\(year)/day\(String(format: "%02d", day)).txt")
}

/// Ввод задачи из `Inputs/<год>/dayNN.txt` без завершающих переводов строки.
package func input(year: Int, day: Int) throws -> String {
    let url = inputURL(year: year, day: day)
    // Пустой файл (его создаёт new-day.sh) считается отсутствующим вводом.
    guard let text = try? String(contentsOf: url, encoding: .utf8), !text.isEmpty else {
        throw MissingInputError(year: year, day: day, path: url.path(percentEncoded: false))
    }
    return String(text.trimmingSuffix(while: \.isNewline))
}

extension StringProtocol {
    fileprivate func trimmingSuffix(while predicate: (Character) -> Bool) -> SubSequence {
        var end = endIndex
        while end > startIndex, predicate(self[index(before: end)]) {
            end = index(before: end)
        }
        return self[..<end]
    }
}
