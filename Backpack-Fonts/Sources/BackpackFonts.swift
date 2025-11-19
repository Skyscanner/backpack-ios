import Foundation

/// Helper type for accessing the Backpack fonts bundle when using SwiftPM.
public enum BackpackFontsBundle {
  /// Returns the bundle that contains the Backpack font resources.
  public static var bundle: Bundle {
#if SWIFT_PACKAGE && !SWIFT_MODULE_RESOURCE_BUNDLE_UNAVAILABLE
    return Bundle.module
#elseif canImport(ObjectiveC)
    return Bundle(for: BundleFinder.self)
#else
    // Fallback for non-ObjC platforms where Bundle(for:) is unavailable.
    return .main
#endif
  }

#if canImport(ObjectiveC)
  private final class BundleFinder {}
#endif
}
