import SwiftUI

extension BPKNavigationView {
    struct Appearance {
        let backgroundColor: BPKColor
        let foregroundColor: BPKColor
        let lineColor: BPKColor
    }
    
    public enum Style {
        case `default`(_ displayMode: NavigationBarItem.TitleDisplayMode = .automatic)
        case transparent(_ displayMode: NavigationBarItem.TitleDisplayMode = .automatic)
        case surfaceContrast
        
        var navBarAppearance: UINavigationBarAppearance {
            switch self {
            case .`default`: defaultNavBarAppearance
            case .transparent: transparentNavBarAppearance
            case .surfaceContrast: surfaceContrastNavBarAppearance
            }
        }
        
        var foregroundColor: BPKColor {
            switch self {
            case .default: .textPrimaryColor
            case .transparent: .textOnDarkColor
            case .surfaceContrast: .textOnDarkColor
            }
        }
        
        var displayMode: NavigationBarItem.TitleDisplayMode {
            switch self {
            case .default(let displayMode): displayMode
            case .transparent: .large
            case .surfaceContrast: .inline
            }
        }
        
        private var defaultNavBarAppearance: UINavigationBarAppearance {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = BPKColor.canvasColor.value
            appearance.shadowColor = BPKColor.lineColor.value
            
            appearance.titleTextAttributes = [.foregroundColor: foregroundColor.value]
            appearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor.value]
            return appearance
        }
        
        private var surfaceContrastNavBarAppearance: UINavigationBarAppearance {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = BPKColor.surfaceContrastColor.value
            appearance.shadowColor = BPKColor.lineOnDarkColor.value
            
            appearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor.value]
            appearance.titleTextAttributes = [.foregroundColor: foregroundColor.value]
            return appearance
        }
        
        private var transparentNavBarAppearance: UINavigationBarAppearance {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = nil
            appearance.shadowColor = nil
            
            appearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor.value]
            appearance.titleTextAttributes = [.foregroundColor: foregroundColor.value]
            return appearance
        }
    }
}
