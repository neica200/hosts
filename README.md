# DNS Host Validation Script

This Bash script validates whether the hostname-to-IP mappings defined in your `/etc/hosts` file match the actual DNS resolution results using a specified DNS server (default: `8.8.8.8` — Google's public DNS).

## Description

The script iterates over each valid (non-commented, non-empty) line in `/etc/hosts`, extracts the IP address and hostname, then verifies whether the hostname resolves correctly to the expected IP using `nslookup`.

## Usage

```bash
chmod +x validate_hosts.sh
./validate_hosts.sh
