# Quick Reference for Claude Code

Essential reminders for working in this repository.

## Build System Differences

### SPM Packages (This Project)
✅ Files auto-discovered
✅ Just create `.swift` files in `Sources/`
✅ Build with: `swift build` or `xcodebuild`
✅ Managed by: `Package.swift`

### Xcode Projects (Backpack Example)
❌ Files NOT auto-discovered
❌ Must add to `project.pbxproj`
❌ Use Xcode GUI to add files
❌ Managed by: `.xcodeproj/project.pbxproj`

## Testing Build Fixes

### ❌ DON'T:
- Clone to `/tmp` when user has existing repo
- Use only command line when user used Xcode
- Stop at "BUILD SUCCEEDED" without checking errors
- Assume fresh clone behaves same as existing repo
- Ignore xcresult files provided by user
- Manually edit project.pbxproj with text editor

### ✅ DO:
- Test in user's actual repository location
- Use same build tool as user (Xcode GUI vs command line)
- Extract and examine xcresult files FIRST
- Test both clean and incremental builds
- Verify in Xcode GUI even if command line succeeds
- Add files programmatically (`xcodeproj` gem) or via Xcode GUI

## Command Cheat Sheet

### Extract Errors from xcresult
```bash
xcrun xcresulttool get --legacy --path "<path.xcresult>" --format json | \
  python3 -c "import sys, json; data = json.load(sys.stdin); \
  errors = data['actions']['_values'][0]['buildResult']['issues'].get('errorSummaries', {}).get('_values', []); \
  print('\n'.join([f\"{e['documentLocationInCreatingWorkspace']['url']['_value'].split('/')[-1].split('#')[0]}:{e['message']['_value']}\" for e in errors]))"
```

### Build Product (SPM - This Project)
```bash
cd Products/provider__model__runid
swift build
# Or with simulator:
xcodebuild -scheme ProductName \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build
```

### Build Backpack Example (Xcode Project)
```bash
cd /Users/soheilnovinfard/Projects/backpack-ios/Example
bundle exec pod install  # First time only
xcodebuild -workspace Backpack.xcworkspace \
  -scheme "Backpack Native" \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build
```

### Add File to Xcode Project (Programmatic)
```bash
# Install xcodeproj gem (one-time)
gem install xcodeproj

# Add file to project
ruby << 'RUBY'
require 'xcodeproj'
project = Xcodeproj::Project.open('Example/Project.xcodeproj')
target = project.targets.find { |t| t.name == 'TargetName' }
group = project.main_group.find_subpath('Path/To/Group', true)
file_ref = group.new_file('Path/To/NewFile.swift')
target.add_file_references([file_ref])
project.save
RUBY
```

### Clean Derived Data
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/<Project>-*
```

## File Locations

### This Project (SPM)
```
design-to-code-ios-playground/
├── Products/               # Generated products (gitignored)
├── Workspaces/            # Agent workspaces (gitignored)
├── DemoApp/               # Demo app
├── Scripts/               # Build/test scripts
├── .claude/               # Claude documentation
│   ├── testing-protocol.md
│   ├── xcode-project-files.md
│   └── quick-reference.md
└── CLAUDE.md              # Main project guide
```

### Backpack (Xcode Project)
```
backpack-ios/
├── Example/
│   ├── Backpack.xcworkspace
│   ├── Backpack.xcodeproj/
│   │   └── project.pbxproj    # File references here!
│   ├── Backpack/              # Source files
│   └── Podfile                # CocoaPods deps
├── Backpack/                  # UIKit framework
└── Backpack-SwiftUI/          # SwiftUI framework
```

## Common Pitfalls

| Issue | Symptom | Solution |
|-------|---------|----------|
| File not compiling (Xcode) | Created file, doesn't build | Use `xcodeproj` gem or Xcode GUI |
| Type ambiguity | `'Type' is ambiguous` | Use `Module.Type` |
| xcresult ignored | Missed actual errors | Extract errors FIRST |
| Wrong environment | Works in `/tmp`, fails for user | Test in user's repo |
| Command line ≠ Xcode | CLI succeeds, Xcode fails | Test in Xcode GUI |
| Manual pbxproj edit | Project corrupted | Use `xcodeproj` gem instead |

## Environment Paths

### Current User
```
/Users/soheilnovinfard/
├── Projects/
│   ├── design-to-code-ios-playground/  # This project
│   └── backpack-ios/                   # Backpack fork
└── Library/Developer/Xcode/DerivedData/
```

## Key Lessons

1. **Test where user tested** - Same location, same tool, same workflow
2. **Check xcresult first** - Don't assume build output tells full story
3. **Xcode projects ≠ SPM** - Files must be explicitly added
4. **Clean builds hide issues** - Test incremental builds too
5. **Command line ≠ Xcode GUI** - Module resolution differs

## Documentation

- [CLAUDE.md](../CLAUDE.md) - Main project guide
- [testing-protocol.md](./testing-protocol.md) - Build testing methodology
- [xcode-project-files.md](./xcode-project-files.md) - Xcode file management
- [BACKPACK_NATIVE_FIXES.md](../BACKPACK_NATIVE_FIXES.md) - Recent fixes
- [BACKPACK_EXAMPLE_SETUP.md](../BACKPACK_EXAMPLE_SETUP.md) - Setup guide

---

**Last Updated:** 2025-12-15
**Context:** Lessons from Backpack Native build failure analysis
