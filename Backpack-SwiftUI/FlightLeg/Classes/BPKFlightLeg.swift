import SwiftUI
import Backpack_Common

struct BPKFlightLeg: View {
    private let airlineLogoSize: CGFloat = 24.0

    private let departureArrivalTime: String
    private let nextDayArrival: String?
    private let flightDescription: AttributedString
    private let stopsInfo: String
    private let highlightStopsInfo: Bool
    private let duration: String
    private let operatedBy: String?
    private let warning: String?
    @State private var carrierLogo: Image?

    // String-based init
    public init(
        departureArrivalTime: String,
        nextDayArrival: String? = "",
        flightDescription: String,
        stopsInfo: String,
        highlightStopsInfo: Bool,
        duration: String,
        operatedBy: String? = "",
        warning: String? = "",
        carrierLogo: UIImage? = nil
    ) {
        self.departureArrivalTime = departureArrivalTime
        self.nextDayArrival = nextDayArrival
        self.flightDescription = AttributedString(flightDescription)
        self.stopsInfo = stopsInfo
        self.highlightStopsInfo = highlightStopsInfo
        self.duration = duration
        self.operatedBy = operatedBy
        self.warning = warning
        if let carrierLogo = carrierLogo {
            self._carrierLogo = State(initialValue: Image(uiImage: carrierLogo))
        } else {
            self._carrierLogo = State(initialValue: nil)
        }
    }

    // AttributedString-based init
    public init(
        departureArrivalTime: String,
        nextDayArrival: String? = "",
        flightDescription: AttributedString,
        stopsInfo: String,
        highlightStopsInfo: Bool,
        duration: String,
        operatedBy: String? = "",
        warning: String? = "",
        carrierLogo: UIImage? = nil
    ) {
        self.departureArrivalTime = departureArrivalTime
        self.nextDayArrival = nextDayArrival
        self.flightDescription = flightDescription
        self.stopsInfo = stopsInfo
        self.highlightStopsInfo = highlightStopsInfo
        self.duration = duration
        self.operatedBy = operatedBy
        self.warning = warning
        if let carrierLogo = carrierLogo {
            self._carrierLogo = State(initialValue: Image(uiImage: carrierLogo))
        } else {
            self._carrierLogo = State(initialValue: nil)
        }
    }

    var body: some View {
        BPKDynamicStack(horizontalAlignment: .leading, verticalAlignment: .top, spacing: .base) {
            createCarrierLogo()
            createFlightInfo()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            createDurationInfo()
        }
    }

    @ViewBuilder
    private func createCarrierLogo() -> some View {
        VStack(alignment: .leading, spacing: .sm) {
            if let carrierLogo = carrierLogo {
                carrierLogo
                    .aspectRatio(contentMode: .fit)
                    .frame(width: airlineLogoSize, height: airlineLogoSize)
                    .background(BPKColor.textOnDarkColor)
                    .cornerRadius(BPKCornerRadius.xs.value)
            }
        }
        .padding(.top, .sm)
    }

    @ViewBuilder
    private func createFlightInfo() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(departureArrivalTimeAttributedText() + nextDayAttributedText())
                .foregroundColor(.textPrimaryColor)
                .lineLimit(nil)
                .accessibilityElement(children: .combine)

            BPKText(flightDescription, style: .caption)
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
    static var previews: some View {
        VStack {
            BPKFlightLeg(
                departureArrivalTime: "19:51 - 22:45",
                flightDescription: "LHR - SIN, SwissAir", // defaultDescription,
                stopsInfo: "Direct",
                highlightStopsInfo: false,
                duration: "2h 00m",
                carrierLogo: UIImage(systemName: "airplane")
            )
            
            BPKFlightLeg(
                departureArrivalTime: "19:51 - 22:45",
                nextDayArrival: "+1",
                flightDescription: "LHR - SIN, SwissAir", // highlightedDescription,
                stopsInfo: "Direct",
                highlightStopsInfo: false,
                duration: "2h 00m",
                operatedBy: "Operated by British Airways",
                warning: "Change airports in London",
                carrierLogo: UIImage(systemName: "airplane")
            )
        }
        .padding()
        .previewDisplayName("Default")
    }
}
