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
        
        if watch {
            print("Monitoring mode enabled... (Press Ctrl+C to stop)")
            // We will implement the loop here later
        } else {
            print("Fetching snapshot...")
            // We will implement the data fetch here later
        }
    }
}
