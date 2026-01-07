//
//  ShellExecutor.swift
//  SystemPulse
//
//  Created by Saurabh Verma on 07/01/26.
//

import Foundation

enum ShellError: Error {
    case commandFailed(String)
    case outputParsingFailed
}

struct ShellExecutor {
    /// Runs a system command and returns the raw string output
    static func run(launchPath: String, arguments: [String]) throws -> String {
        let task = Process()
        let pipe = Pipe()

        task.executableURL = URL(fileURLWithPath: launchPath)
        task.arguments = arguments
        task.standardOutput = pipe
        task.standardError = pipe // Capture errors too

        try task.run()
        task.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else {
            throw ShellError.outputParsingFailed
        }

        if task.terminationStatus != 0 {
            throw ShellError.commandFailed(output)
        }

        return output
    }
}
