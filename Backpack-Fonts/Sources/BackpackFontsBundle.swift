import Foundation

public enum BackpackFontsBundle {
    /// Bundle containing the optional Backpack font resources.
    public static var bundle: Bundle {
        #if SWIFT_PACKAGE
        return .module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }
}

private final class BundleToken {}
