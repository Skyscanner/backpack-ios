# Backpack Fonts — Assets

The Skyscanner Relative font files (`SkyscannerRelativeiOS-*.ttf`) are
**proprietary and deliberately not committed** to this public repository. They
live in the private `Skyscanner/bpk-fonts` repo and are pulled into this
directory by `../Scripts/download-relative-fonts.rb` (gated on
`BPK_USE_RELATIVE=1`). The Example app runs that script in a pre-build phase;
outside Skyscanner-internal setups the fonts are simply absent.

This README is committed so the directory itself exists in every checkout.
That matters for SwiftPM: `Package.swift` declares `.process("Assets")` on the
`Backpack_Fonts` target, and git does not track empty directories — without a
committed file here, every remote SPM checkout would be missing the directory
and emit `Invalid Resource 'Assets': File not found` on every build of the
package. Directory resources are globbed at build time, so fonts downloaded
after dependency resolution are still picked up on the next build.

Consumers without access to the private fonts should ship the font files in
their own app bundle and register them via `UIAppFonts`; Backpack resolves
fonts purely by PostScript name (see `BPKFontDefinition`), so nothing in
Backpack itself needs the files.
