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
        
        // Disk Section
        do {
            let disk = try DiskSensor.fetch()
            
            // 🎨 Presentation Layer: Add some color!
            let color = disk.percentageUsed > 80 ? "🔴" : "🟢"
            print("\(color) Disk Usage: \(disk.percentageUsed)%")
            
        } catch {
            print("❌ Error fetching disk metrics: \(error)")
        }
        
        // CPU Section
        do {
            let cpu = try CPUSensor.fetch()
            let usage = cpu.totalUsage
            let icon = usage > 70 ? "🔥" : "💻"
            
            // Formatted to 1 decimal place
            let formattedUsage = String(format: "%.1f", usage)
            print("\(icon) CPU: \(formattedUsage)% (User: \(cpu.user)%, Sys: \(cpu.system)%)")
        } catch {
            print("❌ CPU Error: \(error)")
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

