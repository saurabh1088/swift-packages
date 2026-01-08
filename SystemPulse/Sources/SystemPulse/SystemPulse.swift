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
        if watch {
            print("Monitoring mode enabled... (Press Ctrl+C to stop)")
            // Live Watch Mode
            while true {
                // 1. Clear the screen and move cursor to top-left
                // \u{001B}[2J clears the screen, \u{001B}[H moves cursor to home
                print("\u{001B}[2J\u{001B}[H")
                
                print("⚡️ System Pulse: Monitoring (Press Ctrl+C to exit)")
                print("----------------------------------------------")
                
                try displaySnapshot()
                
                // 2. Wait for 2 seconds before the next update
                Thread.sleep(forTimeInterval: 2.0)
            }
        } else {
            print("Fetching snapshot...")
            // Snapshot Mode
            print("⚡️ System Pulse: Snapshot")
            print("-------------------------")
            try displaySnapshot()
        }
    }
    
    // Refactored display logic into its own function
    func displaySnapshot() throws {
        // Disk
        if let disk = try? DiskSensor.fetch() {
            let icon = disk.percentageUsed > 80 ? "🔴" : "🟢"
            print("\(icon) Disk Usage: \(disk.percentageUsed)%")
        }

        // CPU
        if let cpu = try? CPUSensor.fetch() {
            let usage = cpu.totalUsage
            let icon = usage > 70 ? "🔥" : "💻"
            print("\(icon) CPU Load:   \(String(format: "%.1f", usage))% (User: \(cpu.user)%, Sys: \(cpu.system)%)")
        }
    }
}

