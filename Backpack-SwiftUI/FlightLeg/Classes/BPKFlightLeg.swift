import SwiftUI
import Backpack_Common

struct BPKFlightLeg: View {
    // Constants
    public static let highlightBackgroundColor = BPKColor.statusDangerFillColor
    public static let highlightForegroundColor = BPKColor.textOnLightColor

    private let airlineLogoSize: CGFloat = 24.0

    private let departureArrivalTime: String
    private let nextDayArrival: String?
    private let flightDescription: AttributedString
    private let stopsInfo: String
    private let highlightStopsInfo: Bool
    private let duration: String
    private let operatedBy: String?
    private let warning: String?
    private let carrierLogo: () -> UIImage?

    public init(
        departureArrivalTime: String,
        nextDayArrival: String? = "",
        flightDescription: AttributedString,
        stopsInfo: String,
        highlightStopsInfo: Bool,
        duration: String,
        operatedBy: String? = "",
        warning: String? = "",
        carrierLogo: @escaping () -> UIImage?
    ) {
        self.departureArrivalTime = departureArrivalTime
        self.nextDayArrival = nextDayArrival
        self.flightDescription = flightDescription
        self.stopsInfo = stopsInfo
        self.highlightStopsInfo = highlightStopsInfo
        self.duration = duration
        self.operatedBy = operatedBy
        self.warning = warning
        self.carrierLogo = carrierLogo
    }

    var body: some View {
        BPKDynamicStack(horizontalAlignment: .leading, verticalAlignment: .top, spacing: .base) {
            if let carrierLogo = carrierLogo() {
                Image(uiImage: carrierLogo)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: airlineLogoSize, height: airlineLogoSize)
                    .background(BPKColor.textOnDarkColor)
                    .cornerRadius(BPKCornerRadius.xs.value)
            }
            createFlightInfo()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            createDurationInfo()
        }
    }

    @ViewBuilder
    private func createFlightInfo() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(departureArrivalTimeAttributedText() + nextDayAttributedText())
                .foregroundColor(.textPrimaryColor)
                .lineLimit(nil)
                .accessibilityElement(children: .combine)

            Text(flightDescription)
                .font(style: BPKFontStyle.caption)
                .foregroundColor(.textSecondaryColor)
                .lineLimit(nil)

            if let operatedBy = operatedBy {
                BPKText(operatedBy, style: .caption)
                    .foregroundColor(.textSecondaryColor)
                    .lineLimit(nil)
            }

            if let warning = warning {
                BPKText(warning, style: .label3)
                    .foregroundColor(.textErrorColor)
                    .lineLimit(nil)
            }
        }
    }

    @ViewBuilder
    private func createDurationInfo() -> some View {
        VStack(alignment: .trailing, spacing: .sm) {
            BPKText(stopsInfo, style: .label3)
                .foregroundColor(highlightStopsInfo ? .textErrorColor : .textPrimaryColor)

            BPKText(duration, style: .caption)
                .foregroundColor(.textSecondaryColor)
        }
    }

    private func departureArrivalTimeAttributedText() -> AttributedString {
        var str = AttributedString(departureArrivalTime)
        str.font = BPKFontStyle.heading5.font

        return str
    }

    private func nextDayAttributedText() -> AttributedString {
        var str = AttributedString(nextDayArrival ?? "")
        str.font = BPKFontStyle.caption.font
        str.baselineOffset = 4

        return str
    }
}

struct BPKFlightLeg_Previews: PreviewProvider {
    static func descriptionString() -> AttributedString {
        var attributedString = AttributedString("LHR")
        attributedString.backgroundColor = Color(BPKFlightLeg.highlightBackgroundColor)
        attributedString.foregroundColor =
            Color(BPKFlightLeg.highlightForegroundColor)

        return attributedString + " - SIN, SwissAir"
    }

    static var previews: some View {
        VStack {
            BPKFlightLeg(
                departureArrivalTime: "19:51 - 22:45",
                flightDescription: "LHR - SIN, SwissAir",
                stopsInfo: "Direct",
                highlightStopsInfo: false,
                duration: "2h 00m",
                carrierLogo: { UIImage(systemName: "airplane") }
            )
            
            BPKFlightLeg(
                departureArrivalTime: "19:51 - 22:45",
                nextDayArrival: "+1",
                flightDescription: descriptionString(),
                stopsInfo: "Direct",
                highlightStopsInfo: false,
                duration: "2h 00m",
                operatedBy: "Operated by British Airways",
                warning: "Change airports in London",
                carrierLogo: { UIImage(systemName: "airplane") }
            )
        }
        .padding()
        .previewDisplayName("Default")
    }
}
