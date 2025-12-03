//
//  Day01.swift
//  advent-of-code-2025
//
//  Created by a-gib on 2025-12-03.
//

import Foundation

struct Day01: DailyChallenge {
    var day: Int = 1
    
    func part1() -> String {
        let input = input(from: "Day01-Input")
        var dialValue = 50
        var zeroCount = Int()
        
        let instructionStrings = input.lines.map(String.init)
        
        var instructions: [Instruction] = []
        for string in instructionStrings {
            guard let instruction = Instruction.fromString(string) else {
                print("Found invalid instruction string that will be skipped: \(string)")
                continue
            }
            instructions.append(instruction)
        }
        
        for instruction in instructions {
            dialValue.modify(using: instruction)
            if dialValue == 0 {
                zeroCount += 1
            }
        }
        
        return String(zeroCount)
    }
    
    func part2() -> String {
        let input = input(from: "Day01-Input")
        var dialValue = 50
        var zeroClickedCount = Int()
        
        let instructionStrings = input.lines.map(String.init)
        
        var instructions: [Instruction] = []
        for string in instructionStrings {
            guard let instruction = Instruction.fromString(string) else {
                print("Found invalid instruction string that will be skipped: \(string)")
                continue
            }
            instructions.append(instruction)
        }
        
        for instruction in instructions {
            zeroClickedCount += dialValue.modify(using: instruction)
        }
        
        return String(zeroClickedCount)
    }
    
    struct Instruction {
        enum Direction {
            case left, right
        }
        
        let direction: Direction
        let distance: Int
        
        static func fromString(_ string: String) -> Instruction? {
            guard string.first == "R" || string.first == "L" else {
                return nil
            }
            
            let direction = string.first == "R" ? Direction.right : Direction.left
            let distanceString = string.dropFirst(1)
            
            guard let distance = Int(distanceString) else {
                return nil
            }
            
            return Instruction(direction: direction, distance: distance)
        }
    }
}

extension Int {
    @discardableResult mutating func modify(using instruction: Day01.Instruction) -> Int {
        let dialNumberCount: Int = 100

        var zeroClickCount = Int()
        
        if instruction.direction == .right {
            let newValue = self + instruction.distance
            zeroClickCount = newValue / dialNumberCount
        }
        
        if instruction.direction == .left {
            if self == 0 {
                zeroClickCount = instruction.distance / dialNumberCount
            } else if instruction.distance >= self {
                zeroClickCount = (instruction.distance - self) / dialNumberCount + 1
            } else {
                zeroClickCount = 0
            }
        }

        let movement = instruction.direction == .right ? instruction.distance : -instruction.distance
        self = ((self + movement) % dialNumberCount + dialNumberCount) % dialNumberCount

        return zeroClickCount
    }
}

extension StringProtocol {
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
}
