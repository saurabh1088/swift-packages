//
//  CPUSensor.swift
//  SystemPulse
//
//  Created by Saurabh Verma on 08/01/26.
//

import Foundation

struct CPUSensor {
    static func fetch() throws -> CPUMetrics {
        // 1. Run 'top' in logging mode (-l 1) with 0 processes (-n 0) for speed
        let rawOutput = try ShellExecutor.run(launchPath: "/usr/bin/top", arguments: ["-l", "1", "-n", "0"])
        
        // 2. Regex to find the CPU usage line
        // Pattern: Matches decimals followed by % for user, sys, and idle
        let pattern = "CPU usage: ([0-9.]+)% user, ([0-9.]+)% sys, ([0-9.]+)% idle"
        let regex = try NSRegularExpression(pattern: pattern)
        
        let nsRange = NSRange(rawOutput.startIndex..., in: rawOutput)
        
        if let match = regex.firstMatch(in: rawOutput, options: [], range: nsRange) {
            // Extract the three capture groups
            let userStr = extract(group: 1, from: rawOutput, match: match)
            let sysStr = extract(group: 2, from: rawOutput, match: match)
            let idleStr = extract(group: 3, from: rawOutput, match: match)
            
            return CPUMetrics(
                user: Double(userStr) ?? 0.0,
                system: Double(sysStr) ?? 0.0,
                idle: Double(idleStr) ?? 0.0
            )
        }
        
        throw ShellError.outputParsingFailed
    }
    
    // Helper to extract regex groups cleanly
    private static func extract(group: Int, from text: String, match: NSTextCheckingResult) -> String {
        guard let range = Range(match.range(at: group), in: text) else { return "0.0" }
        return String(text[range])
    }
}
