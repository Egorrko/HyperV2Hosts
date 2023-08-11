# HyperV2Hosts

HyperV2Hosts is a PowerShell script that fetches IP addresses of active Hyper-V VMs and updates your hosts file with VM names and their IPs.

## Prerequisites

- Windows operating system with PowerShell
- Administrator privileges

## Usage

1. Clone or download this repository.

2. Open PowerShell with administrative privileges.

3. Navigate to the cloned/downloaded directory:
```powershell
cd path/to/HyperV2Hosts
```

4. Run the script:
```powershell
.\hyperV2hosts.ps1
```

5. Check your hosts file at `%SystemRoot%\System32\drivers\etc\hosts` to see the updated entries.

## Notes
- Make sure to run the script with appropriate permissions.
- The script adds entries in the hosts file using the format `IP VMName # [HYPERV2HOSTS]`.
- If IP does not show up, one might have to install linux-azure on the guest (https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-ubuntu-virtual-machines-on-hyper-v).
- You can also add this script to task scheduler.
---
Inspired by [hyperv2hosts](https://github.com/aaalgo/hyperv2hosts)

Written almost completely using [ChatGPT](https://chat.openai.com). *This README.md too :)*
