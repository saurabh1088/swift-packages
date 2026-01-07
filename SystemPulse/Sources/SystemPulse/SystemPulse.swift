// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

@main
struct SystemPulse: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A lightweight system monitoring tool for macOS.",
        version: "1.0.0"
    )

    @Flag(name: .shortAndLong, help: "Show live updates every 2 seconds.")
    var watch = false

    func run() throws {
        print("⚡️ System Pulse Active")
        
        let task = Process()
        let pipe = Pipe()

        task.standardOutput = pipe
        task.arguments = ["-h", "/"]
        task.executableURL = URL(fileURLWithPath: "/bin/df")

        try task.run()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            print("****************************************************************************")
            print(output)
        }
        
        if watch {
            print("Monitoring mode enabled... (Press Ctrl+C to stop)")
            // TODO: Implement
        } else {
            print("Fetching snapshot...")
            // TODO: Implement
        }
    }
}
