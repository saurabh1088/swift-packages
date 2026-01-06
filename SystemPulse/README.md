## SystemPulse

SystemPulse is a Swift Package that provides a starting point for building an executable Swift command‑line tool.

### Getting Started

- **1. Initialize the project**

  Open your Terminal and run the following commands to create your project structure:

  ```bash
  mkdir SystemPulse
  cd SystemPulse
  swift package init --type executable
  ```

- **2. Fetch dependencies**

  From the project directory (where `Package.swift` is located), run:

  ```bash
  swift package resolve
  ```

- **3. Build the project**

  ```bash
  swift build
  ```

- **4. Run the project**

  ```bash
  swift run
  ```

- **5. Run tests (optional)**

  ```bash
  swift test
  ```


