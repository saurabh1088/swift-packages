# SystemPulse Improvement Tracker

This document tracks all identified improvements from the code review. Check off items as they are implemented.

## Priority: High

### Error Handling & User Feedback

- [ ] **SystemPulse.swift (Lines 46, 52)**: Replace `try?` with proper error handling
  - Currently silently swallows errors when sensors fail
  - Users have no visibility into what went wrong
  - **Action**: Catch and display specific error messages for each sensor failure

- [ ] **CPUSensor.swift & DiskSensor.swift**: Improve error messages
  - Generic `ShellError.outputParsingFailed` doesn't indicate what failed
  - **Action**: Include raw output or more descriptive context in error messages

### Incomplete Data Parsing

- [ ] **DiskSensor.swift (Line 30)**: Parse `availableGB` from `df` output
  - Currently hardcoded to `"Unknown"`
  - **Action**: Extract available/total space from `df` output

- [ ] **CPUSensor.swift**: Add input validation
  - No validation that parsed values are within expected ranges (0-100%)
  - **Action**: Validate and clamp values to expected ranges

## Priority: Medium

### Watch Mode Implementation

- [ ] **SystemPulse.swift (Line 32)**: Replace `Thread.sleep` with async approach
  - Currently blocks main thread
  - **Action**: Use `DispatchSourceTimer` or async/await with cancellation support

- [ ] **SystemPulse.swift**: Add graceful shutdown handling
  - No handling for Ctrl+C (SIGINT) in watch mode
  - **Action**: Implement signal handling for graceful shutdown

- [ ] **SystemPulse.swift**: Make refresh interval configurable
  - Hard-coded 2-second interval
  - **Action**: Add command-line argument for customizable refresh rate

### Code Organization & Architecture

- [ ] **General**: Create protocol abstraction for sensors
  - No common interface for sensors
  - **Action**: Define a `Sensor` protocol that all sensors conform to

- [ ] **ShellExecutor.swift (Line 24)**: Separate stderr handling
  - Standard error merged with standard output
  - **Action**: Handle stderr separately for better debugging

- [ ] **ShellExecutor.swift**: Add timeout support
  - No timeout for long-running commands
  - **Action**: Add timeout parameter to prevent hanging

### Documentation & Maintainability

- [ ] **All files**: Add inline documentation
  - Missing Swift doc comments for public APIs
  - **Action**: Add comprehensive doc comments using `///` syntax

- [ ] **CPUSensor.swift (Line 17)**: Extract regex pattern to constant
  - Magic string in code
  - **Action**: Move regex pattern to a named constant or enum

### Type Safety & Validation

- [ ] **CPUMetrics.swift**: Add validation for CPU metrics
  - No validation that `user + system + idle` equals 100% (or close)
  - **Action**: Add validation or normalization logic

- [ ] **DiskMetrics.swift**: Consider precision for percentage
  - `percentageUsed` is `Int`; may need `Double` for precision
  - **Action**: Evaluate if fractional percentages are needed

## Priority: Low

### Performance & Efficiency

- [ ] **CPUSensor.swift (Line 13)**: Consider alternative CPU metrics sources
  - Running `top` for single snapshot may be inefficient
  - **Action**: Evaluate using `sysctl` or `host_statistics` for CPU metrics

- [ ] **SystemPulse.swift**: Optimize screen clearing in watch mode
  - Clears entire screen; could be more efficient
  - **Action**: Use ANSI escape codes to update specific lines instead

### Testing & Robustness

- [ ] **General**: Add unit tests
  - No test coverage
  - **Action**: Create test suite for all sensor modules

- [ ] **General**: Handle edge cases in regex parsing
  - Regex patterns may break if system output format changes
  - **Action**: Add fallback parsing strategies and handle edge cases

### Configuration & Flexibility

- [ ] **SystemPulse.swift**: Make thresholds configurable
  - Hard-coded thresholds (80% disk, 70% CPU) and icons
  - **Action**: Add command-line arguments for customizable thresholds

### Memory & Resource Management

- [ ] **ShellExecutor.swift**: Explicit resource cleanup
  - Process and Pipe resources managed but no explicit cleanup
  - **Action**: Consider using `defer` for cleanup or resource manager

### Platform Compatibility

- [ ] **General**: Add platform checks or documentation
  - Uses macOS-specific commands (`/usr/bin/top`, `/bin/df`)
  - **Action**: Add platform checks or document macOS-only support

### Output Formatting

- [ ] **SystemPulse.swift**: Add structured output formats
  - Only basic text output
  - **Action**: Add `--format json` option for programmatic use

---

## Implementation Notes

- Items are organized by priority (High → Medium → Low)
- Each item includes the file location, current issue, and suggested action
- Check off items using `[x]` as they are completed
- Add implementation notes below each item if needed

## Last Updated

- Review Date: 2025-01-08
- Total Items: 20
