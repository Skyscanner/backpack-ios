# Plan: Fix Non-Modular Header Issue for SPM and CocoaPods

## Problem Summary

After SPM Objective-C support was added (commit `ec800798`), clients using Backpack via SPM encounter this error during Xcode archiving:

```
include of non-modular header inside framework module 'Backpack.Backpack'
```

### Root Cause

The source Objective-C headers in `Backpack/*/Classes/*.h` use angle-bracket imports like `#import <Backpack/BPKLabel.h>`. These imports:
- Work in **CocoaPods** because the podspec configures `HEADER_SEARCH_PATHS` to resolve them
- **Fail in SPM** because SPM uses a different module system where these headers are exposed via `SPMObjCHeaders/` shims, but the underlying source headers still try to import using `<Backpack/...>` syntax which doesn't resolve correctly

### Affected Files (18 headers with angle-bracket imports)

```
Backpack/Button/Classes/BPKButton.h              → #import <Backpack/BPKLabel.h>
Backpack/Dialog/Classes/BPKDialogButtonAction.h  → #import <Backpack/Button.h>
Backpack/Dialog/Classes/BPKDialogView.h          → #import <Backpack/FlareView.h>
Backpack/Icon/Classes/BPKIcon.h                  → #import <Backpack/BPKIconNames.h>, BPKLargeIconNames.h, BPKSmallIconNames.h
Backpack/Icon/Classes/BPKIconView.h              → #import <Backpack/BPKIconNames.h>
Backpack/Icon/Classes/BPKLargeIconView.h         → #import <Backpack/BPKLargeIconNames.h>
Backpack/Icon/Classes/BPKSmallIconView.h         → #import <Backpack/BPKSmallIconNames.h>
Backpack/Icon/Classes/Icon.h                     → #import <Backpack/BPKIconNames.h>, BPKLargeIconNames.h, BPKSmallIconNames.h
Backpack/Label/Classes/BPKTextDefinition.h       → #import <Backpack/Font.h>
Backpack/Map/Classes/BPKMapAnnotation.h          → #import <Backpack/Icon.h>
Backpack/Map/Classes/BPKMapAnnotationViewCalloutFlareView.h → #import <Backpack/FlareView.h>
Backpack/NavigationBar/Classes/BPKNavigationBarButton.h    → #import <Backpack/Button.h>
Backpack/ProgressBar/Classes/BPKProgressBar.h    → #import <Backpack/Font.h>
Backpack/TappableLinkLabel/Classes/BPKTappableLinkLabel.h → #import <Backpack/Font.h>
```

---

## Solution Overview

### Step 1: Fix Source Headers (Convert angle-bracket to relative imports)

Change all `#import <Backpack/...>` to relative path imports that work in both SPM and CocoaPods.

**Strategy**: Use relative imports like `#import "BPKLabel.h"` or `#import "../Label/Classes/BPKLabel.h"` depending on the header location.

Since the headers are in different component directories, we need to update them to use relative imports that work with the header search paths already configured in both SPM and CocoaPods.

### Step 2: Update Package.swift Header Search Paths (if needed)

Ensure all necessary header search paths are configured so relative imports resolve correctly.

### Step 3: Add CI Validation for Non-Modular Headers

Add two levels of archive validation:

1. **Simulated Archive (all PRs)**: Build with `BUILD_LIBRARY_FOR_DISTRIBUTION=YES` and `ENABLE_TESTABILITY=NO`
2. **Full Archive (triggered by tag)**: Complete `xcodebuild archive` when PR contains `[full-archive]` tag

### Step 4: Add Local Validation Script

Create a script to validate headers locally before pushing.

---

## Implementation Details

### Part 1: Fix Header Imports

For each affected header, change from:
```objc
#import <Backpack/BPKLabel.h>
```
to:
```objc
#import "BPKLabel.h"
```

The header search paths in `Package.swift` (lines 226-252) already include paths like:
- `.headerSearchPath("Label/Classes")`
- `.headerSearchPath("Button/Classes")`
- `.headerSearchPath("SPMObjCHeaders/Backpack")`

For CocoaPods, the `HEADER_SEARCH_PATHS` in `Backpack.podspec` line 44-46 already configures `${PODS_TARGET_SRCROOT}/Backpack`.

**Files to modify:**

| File | Change |
|------|--------|
| `Backpack/Button/Classes/BPKButton.h` | `<Backpack/BPKLabel.h>` → `"BPKLabel.h"` |
| `Backpack/Dialog/Classes/BPKDialogButtonAction.h` | `<Backpack/Button.h>` → `"Button.h"` |
| `Backpack/Dialog/Classes/BPKDialogView.h` | `<Backpack/FlareView.h>` → `"FlareView.h"` |
| `Backpack/Icon/Classes/BPKIcon.h` | `<Backpack/BPK*IconNames.h>` → `"BPK*IconNames.h"` |
| `Backpack/Icon/Classes/BPKIconView.h` | `<Backpack/BPKIconNames.h>` → `"BPKIconNames.h"` |
| `Backpack/Icon/Classes/BPKLargeIconView.h` | `<Backpack/BPKLargeIconNames.h>` → `"BPKLargeIconNames.h"` |
| `Backpack/Icon/Classes/BPKSmallIconView.h` | `<Backpack/BPKSmallIconNames.h>` → `"BPKSmallIconNames.h"` |
| `Backpack/Icon/Classes/Icon.h` | `<Backpack/BPK*IconNames.h>` → `"BPK*IconNames.h"` |
| `Backpack/Label/Classes/BPKTextDefinition.h` | `<Backpack/Font.h>` → `"Font.h"` |
| `Backpack/Map/Classes/BPKMapAnnotation.h` | `<Backpack/Icon.h>` → `"Icon.h"` |
| `Backpack/Map/Classes/BPKMapAnnotationViewCalloutFlareView.h` | `<Backpack/FlareView.h>` → `"FlareView.h"` |
| `Backpack/NavigationBar/Classes/BPKNavigationBarButton.h` | `<Backpack/Button.h>` → `"Button.h"` |
| `Backpack/ProgressBar/Classes/BPKProgressBar.h` | `<Backpack/Font.h>` → `"Font.h"` |
| `Backpack/TappableLinkLabel/Classes/BPKTappableLinkLabel.h` | `<Backpack/Font.h>` → `"Font.h"` |

### Part 2: Update Package.swift Header Search Paths

Add any missing header search paths to ensure all relative imports resolve. Current paths in `Package.swift`:
- Already has most paths, but may need to add:
  - `.headerSearchPath("FlareView/Classes")` (for FlareView.h imports)
  - `.headerSearchPath("Map/Classes")` (for Map classes)
  - `.headerSearchPath("Toast/Classes")` (for Toast classes)

### Part 3: Add CI Archive Validation

#### 3.1 Create new workflow file: `.github/workflows/_archive-validation.yml`

```yaml
name: _archive-validation

on:
  workflow_call:
    inputs:
      full_archive:
        description: 'Run full archive build'
        required: false
        default: false
        type: boolean

defaults:
  run:
    shell: bash -l {0}

jobs:
  archive-validation:
    name: Archive Validation
    runs-on: macos-14
    steps:
      - name: Checkout code
        uses: actions/checkout@v5

      - name: Setup SwiftPM workspace
        uses: ./.github/actions/spm-setup

      - name: Select Xcode 16
        run: sudo xcode-select --switch /Applications/Xcode_16.2.app

      # Simulated archive build (always runs)
      - name: SPM Build with Distribution Settings
        env:
          SPM_DESTINATION: platform=iOS Simulator,name=iPhone SE (3rd generation),OS=17.5
        run: |
          set -eo pipefail
          xcodebuild \
            -workspace .swiftpm/xcode/package.xcworkspace \
            -scheme Backpack-Package \
            -destination "$SPM_DESTINATION" \
            -derivedDataPath .derivedData \
            -skipPackagePluginValidation \
            -skipMacroValidation \
            BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
            ENABLE_TESTABILITY=NO \
            build 2>&1 | tee build.log

          # Check for non-modular header errors
          if grep -q "non-modular header" build.log; then
            echo "::error::Non-modular header issue detected!"
            grep "non-modular header" build.log
            exit 1
          fi

      # Full archive build (only when requested)
      - name: Full Archive Build (SPM)
        if: ${{ inputs.full_archive }}
        run: |
          set -eo pipefail
          xcodebuild \
            -workspace .swiftpm/xcode/package.xcworkspace \
            -scheme Backpack-Package \
            -destination "generic/platform=iOS" \
            -derivedDataPath .derivedData \
            -skipPackagePluginValidation \
            -skipMacroValidation \
            -archivePath ./Backpack-SPM.xcarchive \
            archive 2>&1 | tee archive.log

          if grep -q "non-modular header" archive.log; then
            echo "::error::Non-modular header issue detected in archive!"
            grep "non-modular header" archive.log
            exit 1
          fi

      - name: Clean derived data
        if: always()
        run: rm -rf .derivedData
```

#### 3.2 Update `.github/workflows/_build.yml`

Add the archive validation job after `BuildSwiftPackage`:

```yaml
  ArchiveValidation:
    needs: [Setup]
    uses: ./.github/workflows/_archive-validation.yml
    with:
      full_archive: ${{ contains(github.event.pull_request.title, '[full-archive]') || contains(github.event.pull_request.body, '[full-archive]') }}
```

#### 3.3 Update `.github/workflows/pr.yml` to pass through full_archive flag

Add conditional check for the `[full-archive]` tag in PR title or body.

### Part 4: Add CocoaPods Archive Validation

Add a step to verify CocoaPods archive works:

```yaml
  - name: CocoaPods Archive Validation
    run: |
      cd Example
      xcodebuild \
        -workspace Backpack.xcworkspace \
        -scheme Backpack \
        -destination "generic/platform=iOS" \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        ENABLE_TESTABILITY=NO \
        build 2>&1 | tee cocoapods-build.log

      if grep -q "non-modular header" cocoapods-build.log; then
        echo "::error::Non-modular header issue in CocoaPods!"
        exit 1
      fi
```

### Part 5: Create Local Validation Script

Create `scripts/validate-headers`:

```bash
#!/bin/bash
set -euo pipefail

echo "=== Checking for non-modular header imports ==="

# Check for angle-bracket imports in source headers
ANGLE_IMPORTS=$(grep -r "#import <Backpack/" Backpack/*/Classes/*.h 2>/dev/null || true)

if [ -n "$ANGLE_IMPORTS" ]; then
    echo "ERROR: Found angle-bracket imports that may cause non-modular header issues:"
    echo "$ANGLE_IMPORTS"
    echo ""
    echo "Please change these to relative imports (e.g., #import \"BPKLabel.h\")"
    exit 1
fi

echo "=== Building SPM with distribution settings ==="
xcodebuild \
    -workspace .swiftpm/xcode/package.xcworkspace \
    -scheme Backpack-Package \
    -destination "platform=iOS Simulator,name=iPhone SE (3rd generation),OS=18.6" \
    -derivedDataPath .derivedData \
    -skipPackagePluginValidation \
    -skipMacroValidation \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    ENABLE_TESTABILITY=NO \
    build 2>&1 | tee /tmp/spm-build.log

if grep -q "non-modular header" /tmp/spm-build.log; then
    echo "ERROR: Non-modular header issue detected in SPM build!"
    grep "non-modular header" /tmp/spm-build.log
    exit 1
fi

echo "=== Building CocoaPods ==="
cd Example
xcodebuild \
    -workspace Backpack.xcworkspace \
    -scheme Backpack \
    -configuration Debug \
    -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone SE (3rd generation),OS=18.6' \
    build 2>&1 | tee /tmp/cocoapods-build.log

if grep -q "non-modular header" /tmp/cocoapods-build.log; then
    echo "ERROR: Non-modular header issue detected in CocoaPods build!"
    grep "non-modular header" /tmp/cocoapods-build.log
    exit 1
fi

echo ""
echo "=== All header validations passed! ==="
```

---

## Verification Commands (Feedback Loop)

After each change, run these commands to verify both SPM and CocoaPods work:

### SPM Build
```bash
xcodebuild \
    -workspace .swiftpm/xcode/package.xcworkspace \
    -scheme Backpack-Package \
    -destination "platform=iOS Simulator,name=iPhone SE (3rd generation),OS=18.6" \
    -derivedDataPath .derivedData \
    -skipPackagePluginValidation \
    -skipMacroValidation \
    build
```

### CocoaPods Build
```bash
cd Example && bundle exec pod install && cd ..
xcodebuild \
    -workspace Example/Backpack.xcworkspace \
    -scheme Backpack \
    -configuration Debug \
    -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone SE (3rd generation),OS=18.6' \
    build
```

### SPM with Distribution (Archive Simulation)
```bash
xcodebuild \
    -workspace .swiftpm/xcode/package.xcworkspace \
    -scheme Backpack-Package \
    -destination "platform=iOS Simulator,name=iPhone SE (3rd generation),OS=18.6" \
    -derivedDataPath .derivedData \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    ENABLE_TESTABILITY=NO \
    build
```

---

## Implementation Order

1. **First**: Fix all source headers (Part 1) - convert angle-bracket to relative imports
2. **Second**: Run SPM and CocoaPods builds to verify fixes work
3. **Third**: Update Package.swift header search paths if any imports fail (Part 2)
4. **Fourth**: Create archive validation workflow (Part 3)
5. **Fifth**: Create local validation script (Part 5)
6. **Sixth**: Test the complete CI pipeline

---

## Files to Create/Modify

### New Files
- `.github/workflows/_archive-validation.yml` - Archive validation workflow
- `scripts/validate-headers` - Local validation script

### Modified Files
- `Backpack/Button/Classes/BPKButton.h`
- `Backpack/Dialog/Classes/BPKDialogButtonAction.h`
- `Backpack/Dialog/Classes/BPKDialogView.h`
- `Backpack/Icon/Classes/BPKIcon.h`
- `Backpack/Icon/Classes/BPKIconView.h`
- `Backpack/Icon/Classes/BPKLargeIconView.h`
- `Backpack/Icon/Classes/BPKSmallIconView.h`
- `Backpack/Icon/Classes/Icon.h`
- `Backpack/Label/Classes/BPKTextDefinition.h`
- `Backpack/Map/Classes/BPKMapAnnotation.h`
- `Backpack/Map/Classes/BPKMapAnnotationViewCalloutFlareView.h`
- `Backpack/NavigationBar/Classes/BPKNavigationBarButton.h`
- `Backpack/ProgressBar/Classes/BPKProgressBar.h`
- `Backpack/TappableLinkLabel/Classes/BPKTappableLinkLabel.h`
- `Package.swift` (potentially, for header search paths)
- `.github/workflows/_build.yml` (add archive validation job)

---

## Success Criteria

1. Both `SPM build` and `CocoaPods build` commands succeed
2. `SPM build with BUILD_LIBRARY_FOR_DISTRIBUTION=YES` succeeds without "non-modular header" errors
3. No regression in existing functionality
4. CI catches any future introduction of angle-bracket `<Backpack/...>` imports
5. Local validation script provides quick feedback before pushing
