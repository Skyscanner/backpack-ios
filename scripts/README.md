# Backpack iOS Scripts Overview

This document explains the purpose and usage of each script and folder in the `scripts/` directory of the Backpack iOS project. These scripts automate design token generation tasks.

## Gulp Scripts

Contains Node.js scripts for generating and managing design tokens and icons.

Gulp scripts are usually run as part of a larger build process. If any individual script fails (for example, due to a missing file or an error in the code), the whole process will stop immediately. This means you must fix the error before the scripts can finish running and generate the required files. This helps catch problems early and ensures that all generated code is up to date and correct.

## Script Robustness & Breaking Changes

Scripts in this directory are designed to work with the current project structure and expected file formats. If new files, tokens, or formats are introduced, or if existing files are significantly changed, some scripts may break or produce unexpected results. When making such changes, always review and update relevant scripts to ensure compatibility. Test scripts after structural or token updates to catch issues early.

- **autoMirrorIconNames.js**: Handles automatic mirroring of icon names for RTL support.
- **borderWidths.js**: Generates border width design tokens.
- **colours.js**: Generates color tokens for use in components.
- **durations.js**: Generates animation duration tokens.
- **dynamicColours.js**: Handles dynamic color tokens for light/dark mode.
- **fonts.js**: Generates font and typography tokens.
- **iconNames.js**: Generates icon name mappings.
- **internalColours.js**: Handles internal color tokens not exposed to consumers.
- **radii.js**: Generates corner radius tokens.
- **shadows.js**: Generates shadow/elevation tokens.
- **spacings.js**: Generates spacing tokens (padding, margin, etc.).

### gulp/generation/

Scripts for generating platform-specific code from design tokens.

- **iconSvgs.js**: Generates SVG assets for icons.
- **objc.js**: Generates Objective-C code for UIKit components.
- **swiftui.js**: Generates SwiftUI code for design tokens and icons.

#### gulp/generation/swiftui/
- **icons.js**: Generates SwiftUI icon components from SVGs and token definitions.

#### gulp/generation/uikit/
- **icons.js**: Generates UIKit icon components from SVGs and token definitions.

### gulp/utils/

Utility scripts used by the main gulp scripts.

- **formatUtils.js**: Functions for formatting code and token output.
- **legibleName.js**: Converts token and icon names to human-readable formats.

## Usage

- Most scripts are run via npm/yarn scripts or directly from the command line.
- Design token scripts are typically run as part of the build or when updating tokens from design.
- CI and lint scripts are run automatically in pull requests and merges.
- Screenshot and documentation scripts are used when updating docs or visual assets.

## Contribution

- Before running scripts, ensure you have the required dependencies installed (Node.js, npm, Swift, etc.).
- Refer to `/CONTRIBUTING.md` for setup and workflow details.
- When adding new scripts, update this document to describe their purpose and usage.

## Common Problems & Troubleshooting

### Script Breaks or Fails to Generate Output
- **Possible Cause:** A new variable, token, or file format has been introduced that the script does not recognize.
- **How to Fix:**
  - Review the script for hardcoded variable or token lists. Add the new variable or token where appropriate.
  - If the script uses legible names (e.g., for icons or tokens), ensure the new variable is included in the legible name mapping (see `gulp/utils/legibleName.js`).
  - After updating, re-run the script and verify the output is as expected.
  - If the script still fails, check for errors in the console output for clues about missing or misnamed fields.
