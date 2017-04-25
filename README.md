# mifid_ii_inspec_profile
MiFID II Inspec Profile

## Controls
Currently there is only 2 controls exist. Please don't forget these controls are written in a very hacky way for a DEMO.

1. File integrity check within multiple-servers
2. Encryption-at-rest check

## How to run
Point github repository within your inspec profile, or download the repo as a ZIP file and import it into your Chef Compliance Server.

## What does the controls do in detail ?

#### integrity-01
Chef Compliance server must have a redis server running locally in order to run this control properly. Redis server is being used for keeping accumulated data from all multiple targets. Currently the target count is set to `3`, and this must be changed from the code if required.

It checks `*.data` files in `/important/files` directory at target host, take an SHA256Sum and compare with the same files in other targets.

A new library is needed for this control to show it better on the output.

#### encryption-01
This control will check `*.gpg` files in `/important/files` directory at target host for any GPG-based encryption.

## Example output
```
Profile: MiFID II Sample Compliance Checks (mifidii-compliance)
Version: 0.1.0
Target:  local://

  ✔  encryption-01: Check if the files are encrypted with at least 2048 bit keys
     ✔  encryption encrypted should eq true
     ✔  encryption key_bits should >= 2048
     ✔  encryption encrypted should eq true
     ✔  encryption key_bits should >= 2048
     ✔  encryption encrypted should eq true
     ✔  encryption key_bits should >= 2048
  ✔  integrity-01: Check for integrity of important files if they are replicated correctly
     ✔  true should eq true
     ✔  1 should be <= 3
     ✔  File ./test/a.data should be file
     ✔  File ./test/b.data should be file

Profile Summary: 2 successful, 0 failures, 0 skipped
Test Summary: 10 successful, 0 failures, 0 skipped
```
