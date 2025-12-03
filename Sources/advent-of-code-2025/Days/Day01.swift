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
        "Hello"
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
    mutating func modify(using instruction: Day01.Instruction) {
        let dialNumberCount: Int = 100
        
        let movement = instruction.direction == .right
            ? self + instruction.distance
            : self - instruction.distance
        
        // Remainders take the sign of the dividend. Since it can be negative, add the dial count and take the remainder again to ensure we always get the positive counterpart
        self = (movement % dialNumberCount + dialNumberCount) % dialNumberCount
    }
}

extension StringProtocol {
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
}
