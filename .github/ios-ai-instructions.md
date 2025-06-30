# Backpack iOS Component Standards

Below are the standards and best practices for developing components in the Backpack iOS library. These standards ensure that all components are accessible, well-designed, thoroughly tested, and properly documented. Following these guidelines will help maintain consistency across the design system and provide the best experience for developers and end users.

## Technology Stack & Architecture

### SwiftUI First Approach
- SwiftUI is the standard for all new component development in Backpack iOS
- New components should be developed using SwiftUI and located in Backpack-SwiftUI/
- UIKit components should be maintained for backward compatibility, but new development should prioritize SwiftUI implementations
- Only update UIKit components when absolutely necessary - encourage users to migrate to SwiftUI

### Project Structure
Components should follow the established folder structure:

Backpack-SwiftUI/
├── ComponentName/
│   ├── Classes/
│   │   ├── BPKComponentName.swift
│   │   ├── BPKComponentName+Style.swift (if applicable)
│   │   └── Supporting files...
│   ├── README.md
│   └── Tests/ (if component-specific tests exist)

## Accessibility Standards

Accessibility is fundamental to all Backpack components. Components must be usable by everyone, following WCAG 2.2 AA guidelines.

### Requirements

1. **VoiceOver Support**
   - All components must work properly with VoiceOver
   - Interactive elements must have appropriate accessibility labels
   - State changes must be announced to screen readers
   - Use accessibilityElement(), accessibilityLabel(), accessibilityHint(), and accessibilityValue() appropriately

2. **Keyboard Navigation & Focus Management**
   - All interactive components must be keyboard accessible
   - Focus states must be clearly visible and follow system conventions
   - Tab order must be logical and follow visual layout
   - Use focusable() and accessibilityFocused() when needed

3. **Touch Target Size**
   - Interactive elements must have a minimum touch target size of 44pt × 44pt (following Apple's HIG)
   - Ensure sufficient spacing between interactive elements

4. **Color Contrast & Visual Accessibility**
   - Text must have a contrast ratio of at least 4.5:1 against its background
   - UI controls must have a contrast ratio of at least 3:1
   - Components must work properly in both light and dark modes
   - Support high contrast accessibility settings

5. **Dynamic Type Support**
   - Components must support Dynamic Type scaling
   - Text should scale appropriately with user's font size preferences
   - Layouts must adapt gracefully to larger text sizes
   - Use BPKFont.enableDynamicType flag and sizeCategory(.large) when needed

6. **State Communication**
   - Error states must be communicated both visually and programmatically
   - Loading states must be properly indicated and announced
   - Selection states must be clearly visible and accessible

## API Design Principles

SwiftUI components should follow established patterns and conventions for consistency and ease of use.

### Requirements

1. **SwiftUI Best Practices**
   - Follow SwiftUI naming conventions and patterns
   - Use View protocol for all components
   - Implement proper state management with @State, @ObservedObject, etc.
   - Use ViewModifier for reusable styling behaviors
   - Provide view builder closures for customizable content when appropriate

2. **Backpack Conventions**
   - All components must start with BPK prefix (e.g., BPKBadge, BPKButton)
   - Use associated types and enums for configuration (e.g., BPKBadge.Style)
   - Style modifiers should return the same type (e.g., func badgeStyle(_ style: BPKBadge.Style) -> BPKBadge)
   - Follow the existing patterns established in other components

3. **Parameter Design**
   - Required parameters should come first in initializers
   - Optional parameters should have sensible defaults
   - Use clear, descriptive parameter names
   - Group related parameters logically

4. **Consistency**
   - Similar components should have similar APIs
   - Use consistent naming across components (e.g., style, size, variant)
   - Follow established patterns for colors, spacing, and typography

5. **Flexibility & Customization**
   - Provide style variants through enums (e.g., .normal, .strong, .success)
   - Allow customization through modifiers rather than constructor parameters
   - Support both simple and advanced use cases

## Design Token Integration

Proper use of design tokens ensures consistency and supports theming across the design system.

### Requirements

1. **Color Tokens**
   - Use BPKColor tokens exclusively (never hardcoded colors)
   - Support both light and dark mode automatically
   - Common tokens: .textPrimaryColor, .corePrimaryColor, .surfaceDefaultColor, etc.
   - Apply colors using .foregroundColor() and .background() modifiers

2. **Spacing Tokens**
   - Use BPKSpacing tokens for all spacing (padding, margins, gaps)
   - Common tokens: .sm, .md, .lg, .xl, .base
   - Apply using .padding() modifiers

3. **Typography Tokens**
   - Use BPKFontStyle for all text styling
   - Common styles: .bodyDefault, .heading1, .footnote, .caption
   - Apply through BPKText component or .font(style:) modifier

4. **Corner Radius & Elevation**
   - Use design tokens for corner radius (.xs, .sm, .md)
   - Apply using .clipShape() or .cornerRadius() modifiers
   - Use appropriate shadow/elevation tokens when needed

## Component Implementation Standards

### Code Structure

1. **Component Organization**

Example structure:
public struct BPKComponentName: View {
    // MARK: - Properties
    private let title: String
    private let icon: BPKIcon?
    private var style: BPKComponentName.Style = .normal
    
    // MARK: - Initialization
    public init(_ title: String, icon: BPKIcon? = nil) {
        self.title = title
        self.icon = icon
    }
    
    // MARK: - Body
    public var body: some View {
        // Implementation
    }
    
    // MARK: - Modifiers
    public func componentStyle(_ style: BPKComponentName.Style) -> BPKComponentName {
        var result = self
        result.style = style
        return result
    }
}

2. **Style Enums**

Example style enum:
public extension BPKComponentName {
    enum Style {
        case normal, strong, success, warning, destructive
        
        var backgroundColor: BPKColor {
            switch self {
            case .normal: return .surfaceDefaultColor
            case .strong: return .surfaceHighlightColor
            // ... etc
            }
        }
    }
}

3. **Accessibility Implementation**

Example accessibility setup:
.accessibilityElement()
.accessibilityLabel(title)
.accessibilityHint("Double tap to perform action")
.if(!BPKFont.enableDynamicType, transform: {
    $0.sizeCategory(.large)
})

### Design Implementation Requirements

1. **Pixel-Perfect Design**
   - Components must match Figma specifications exactly
   - Use proper spacing, typography, and color tokens
   - Implement all design states (default, hover, active, disabled, etc.)

2. **Theme Support**
   - Full support for light and dark modes
   - Proper token usage for automatic theme adaptation
   - Test thoroughly in both themes

3. **RTL Support**
   - Components must work correctly in Right-to-Left languages
   - Use appropriate layout modifiers
   - Test with RTL locales

4. **Responsive Design**
   - Components should adapt to different screen sizes
   - Support iPhone, iPad, and various orientations
   - Handle Dynamic Type scaling gracefully

## Testing Requirements

Comprehensive testing ensures components work correctly and continue to work as the codebase evolves.

### Requirements

1. **Snapshot Tests**
   - Create snapshot tests for all visual states and variations
   - Test both light and dark themes
   - Test RTL layouts
   - Test Dynamic Type scaling
   - Use the specified CI device for consistency
   - Place tests in appropriate test targets

2. **Unit Tests**
   - Test component logic and state management
   - Test accessibility features
   - Test API behavior and edge cases
   - Aim for high test coverage (at least 80%)

3. **Accessibility Tests**
   - Include specific accessibility snapshot tests
   - Test VoiceOver behavior
   - Verify Dynamic Type support

Example accessibility test:
func test_accessibility() {
    let component = BPKComponentName("Test")
    assertA11ySnapshot(component)
}

## Documentation Standards

Comprehensive documentation ensures proper component adoption and usage.

### Requirements

1. **Code Documentation**
   - Use Swift DocC comments for all public APIs
   - Include parameter descriptions and return value documentation
   - Provide usage examples in documentation

Example documentation:
/// A view that displays one line of text with an optional icon
/// By default the style of BPKBadge is set to `.normal`
///
/// Use `badgeStyle(_ style: BPKBadge.Style)` to change the style of the badge

2. **README Files**
   - Each component must have a comprehensive README
   - Include component description and purpose
   - Show usage examples with code snippets
   - Document all available styles and configurations
   - Include screenshots of different states

3. **Example Implementation**
   - Add component to the Example app
   - Create comprehensive story showing all variants
   - Include interactive examples where appropriate
   - Add to appropriate Groups in ComponentCellsProvider

4. **Screenshots**
   - Include up-to-date screenshots in documentation
   - Show both light and dark mode variants
   - Demonstrate different states and configurations
   - Update screenshots when visual changes occur

## Development Workflow

### Component Development Process

1. **Design Review**
   - Ensure Figma designs are complete and approved
   - Verify all states and variants are defined
   - Confirm accessibility requirements

2. **Implementation**
   - Follow established code patterns and conventions
   - Implement all design variants and states
   - Add proper accessibility support
   - Use appropriate design tokens

3. **Testing**
   - Write comprehensive unit tests
   - Create snapshot tests for all visual states
   - Test accessibility features
   - Verify theme and RTL support

4. **Documentation**
   - Write comprehensive code documentation
   - Create detailed README
   - Add to Example app with stories
   - Take screenshots for documentation

5. **Review**
   - Code review focusing on API design and implementation
   - Accessibility review
   - Design review for pixel-perfect implementation
   - Testing review for coverage and quality

### Experimental Components

For components under experimentation:

1. **Marking Experimental**
   - Use Swift DocC comments to mark experimental features

Example experimental marking:
/// - Experiment: This property is experimental and subject to change. Use with caution

2. **Documentation**
   - Create README but don't publish to skyscanner.design until stable
   - Clearly mark experimental status in documentation

3. **Cleanup**
   - Remove experimental code within 2 weeks of experiment completion
   - Either stabilize and publish or remove entirely

## String Resources & Text Content

### Requirements

1. **Consumer-Provided Text**
   - Consumers should provide text-related values via API parameters
   - Avoid hardcoded strings in components
   - Examples: content descriptions, labels, placeholder text, button titles

2. **Accessibility Text**
   - Accessibility labels and hints should be provided by consumers
   - Components can provide default accessibility behavior but allow customization
   - Use descriptive, meaningful accessibility labels

3. **Localization Support**
   - Components should support localized text through parameter injection
   - Use LocalizedStringKey when appropriate for system-provided text
   - Stories and examples can use hardcoded strings for demonstration

## Component Checklist

Before submitting a new component or significant changes:

- [ ] Component follows SwiftUI best practices and Backpack conventions
- [ ] All accessibility requirements are met (VoiceOver, Dynamic Type, keyboard navigation)
- [ ] Proper design token usage (colors, spacing, typography)
- [ ] Pixel-perfect implementation matching Figma designs
- [ ] Full theme support (light/dark mode)
- [ ] RTL layout support
- [ ] Comprehensive unit tests with good coverage
- [ ] Snapshot tests for all visual states and themes
- [ ] Accessibility-specific tests
- [ ] Complete code documentation with DocC comments
- [ ] Comprehensive README with examples and screenshots
- [ ] Component added to Example app with stories
- [ ] Screenshots updated for documentation
- [ ] Code review completed
- [ ] Accessibility review completed

## Contribution Guidelines

Before contributing, ensure you're familiar with the project setup and contribution process outlined in `/CONTRIBUTING.md`. This includes:

- Setting up the development environment with fullsetup script
- Understanding the build and test processes
- Following the established code review process
- Using proper git workflow and commit messages
- Running snapshot tests on appropriate CI devices
- Taking screenshots for documentation updates

## Getting Help

When in doubt:
- Review existing components for established patterns
- Check the CONTRIBUTING.md for detailed setup and process information
- Refer to Apple's Human Interface Guidelines for iOS conventions
- Follow SwiftUI best practices and documentation
- Ensure compliance with WCAG 2.2 AA accessibility standards
- Look at BPKBadge and BPKText as reference implementations

## Key Differences from Android

- Use SwiftUI View protocol instead of Composable functions
- Follow iOS accessibility patterns (VoiceOver vs TalkBack)
- Use BPK prefixed tokens and components
- Follow Apple's 44pt minimum touch target (vs Android's 48dp)
- Use Swift/SwiftUI naming conventions
- Implement proper Dynamic Type support
- Support iOS-specific features like Control Center integration where relevant

Remember: The goal is to create components that are beautiful, accessible, and easy to use while maintaining consistency across the entire Backpack design system and following iOS platform conventions.
