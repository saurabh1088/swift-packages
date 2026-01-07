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
        
        do {
            let disk = try DiskSensor.fetch()
            
            // 🎨 Presentation Layer: Add some color!
            let color = disk.percentageUsed > 80 ? "🔴" : "🟢"
            print("\(color) Disk Usage: \(disk.percentageUsed)%")
            
        } catch {
            print("❌ Error fetching disk metrics: \(error)")
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

