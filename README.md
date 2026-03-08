A lightweight utility for Logitech MX Master users.
Enables side-button navigation (back/forward) in Safari and Finder without the need for Logitech drivers.

Tested on macOS 26.3.1


Steps

1. Compile the code
   
2. Copy the binary to /usr/local/bin
   
3. Creat a plist file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.mousetools</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/name_of_your_binary</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
```

Copy the file to ~/Library/LaunchAgents/

4. Run command: launchctl load ~/Library/LaunchAgents/your_plist_file_name.plist
