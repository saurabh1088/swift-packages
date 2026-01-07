//
//  DiskSensor.swift
//  SystemPulse
//
//  Created by Saurabh Verma on 07/01/26.
//

import Foundation

struct DiskMetrics {
    let percentageUsed: Int
    let availableGB: String
}

struct DiskSensor {
    static func fetch() throws -> DiskMetrics {
        // 1. Get raw data
        let rawOutput = try ShellExecutor.run(launchPath: "/bin/df", arguments: ["-h", "/"])
        
        // 2. Parse data using Regex
        // We look for a number followed by a '%' sign
        let regex = try NSRegularExpression(pattern: "(\\d+)%")
        let range = NSRange(rawOutput.startIndex..., in: rawOutput)
        
        if let match = regex.firstMatch(in: rawOutput, options: [], range: range) {
            if let percentRange = Range(match.range(at: 1), in: rawOutput),
               let percentInt = Int(rawOutput[percentRange]) {
                
                // For now, let's keep it simple and just return the percentage
                return DiskMetrics(percentageUsed: percentInt, availableGB: "Unknown")
            }
        }
        
        throw ShellError.outputParsingFailed
    }
}
