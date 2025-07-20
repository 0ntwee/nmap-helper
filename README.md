# nmap-helper

## Overview

A robust Bash script designed to streamline Nmap operations through an interactive menu-driven interface. This tool standardizes common scanning procedures while maintaining flexibility for advanced users.

## Key Features

- Preconfigured scan profiles for common use cases
- Flexible target specification (single IP, ranges, file input, domains)
- Automated output naming with timestamp
- Custom scan option passthrough
- Non-invasive mode (no file output)

## Installation

### Requirements
- Nmap (tested with v7.80+)
- Bash 4.0+
- GNU core utilities

### Setup
```bash
git clone https://github.com/0ntwee/nmap-helper.git
cd nmap-automation-tool
chmod +x nmap_scanner.sh
```

## Usage

### Basic Operation
Execute the script with:
```bash
./nmap_scanner.sh
```

Follow the interactive prompts to:
1. Select scan type
2. Specify target(s)
3. Review generated command
4. Execute scan

### Scan Types
| #  | Type                  | Nmap Parameters       | Use Case                     |
|----|-----------------------|-----------------------|------------------------------|
| 1  | Quick Scan            | -T4 -F                | Rapid port discovery         |
| 2  | Comprehensive Scan    | -p- -T4               | Full port enumeration        |
| 3  | UDP Scan              | -sU -T4               | UDP service discovery        |
| 4  | Service Detection     | -A -T4                | OS/service fingerprinting    |
| 5  | Stealth Scan          | -T4                   | Non-persistent scanning      |
| 6  | Vulnerability Probe   | --script=vuln -T4     | CVE detection                |
| 7  | Custom Scan           | User-defined          | Advanced scenarios           |

### Target Specification
- Single IP: `192.168.1.1`
- IP Range: `192.168.1.1-100`
- File Input: Text file with one target per line
- Domain Name: `example.com`

## Output Handling

Scan results are automatically saved using the convention:
`[scan_type]_[YYYYMMDD]_[HHMMSS].txt`

Example: `quick_scan_20230721_143022.txt`

Use option 5 (Stealth Scan) to suppress file output when needed.

## Advanced Configuration

### Environment Variables
Set these before execution to override defaults:

- `NMAP_OPTS`: Additional Nmap flags
- `OUTPUT_DIR`: Alternate save location (default: current directory)

### Customizing Scan Profiles
Edit the `scan_profiles` array in the script to add/modify predefined scans.

## Security Considerations

1. Always obtain proper authorization before scanning
2. Review Nmap's network traffic impact documentation
3. Consider using `--max-rate` for sensitive environments
4. Avoid using `-T5` timing template in production networks


- 1.0.0 (12 June 2025)
  - Initial release
  - Core scanning functionality
  - Interactive menu system
