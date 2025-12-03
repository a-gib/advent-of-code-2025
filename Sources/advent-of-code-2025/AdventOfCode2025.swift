//
//  AdventOfCode2025.swift
//  advent-of-code-2025
//
//  Created by a-gib on 2025-12-03.
//

struct Days {
    /// Registry for all daily challenges to be executed. Comment out as needed.
    static let all: [DailyChallenge] = [
        Day01()
    ]
}

@main
struct AdventOfCode2025 {
    static func main() {
        Days.all.forEach { $0.execute() }
    }
}

protocol DailyChallenge: Sendable {
    var day: Int { get }
    func part1() -> String
    func part2() -> String
}

extension DailyChallenge {
    func execute() {
        print("""
            === Day \(day) ===
            Part 1: \(part1())
            Part 2: \(part2())
            
            """)
    }
}
