/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Backpack

// swiftlint:disable type_body_length
// swiftlint:disable file_length
struct BPKIconsTestsUtils {
    
    static let allSmallIcons = allIcons
        .filter { $0.hasSuffix("-sm") }
        .compactMap { BPKSmallIconName(String($0.dropLast(3))) }
        
    static let allLargeIcons = allIcons
        .filter { !$0.hasSuffix("-sm") }
        .compactMap { BPKLargeIconName($0) }
    
    static let allIcons: [String] = [
        "accessibility-sm",
        "accessibility",
        "account--add-sm",
        "account--add",
        "account--female-sm",
        "account--female",
        "account--id-card-sm",
        "account--id-card",
        "account--name-sm",
        "account--name",
        "account--permit-sm",
        "account--permit",
        "account-circle-sm",
        "account-circle",
        "account-sm",
        "account",
        "add-circle-sm",
        "add-circle",
        "adult-sm",
        "adult",
        "aircon-sm",
        "aircon",
        "aircraft-sm",
        "aircraft",
        "airline--multiple-sm",
        "airline--multiple",
        "airline-sm",
        "airline",
        "airports-sm",
        "airports",
        "alert--active-sm",
        "alert--active",
        "alert--add-sm",
        "alert--add",
        "alert--expired-sm",
        "alert--expired",
        "alert--remove-sm",
        "alert--remove",
        "arrow-down-sm",
        "arrow-down",
        "arrow-left-sm",
        "arrow-left",
        "arrow-right-sm",
        "arrow-right",
        "arrow-up-sm",
        "arrow-up",
        "award-sm",
        "award",
        "baby-carriage-sm",
        "baby-carriage",
        "baggage--add-sm",
        "baggage--add",
        "baggage--remove-sm",
        "baggage--remove",
        "baggage-cabin-add-sm",
        "baggage-cabin-add",
        "baggage-cabin-not-included-sm",
        "baggage-cabin-not-included",
        "baggage-cabin-sm",
        "baggage-cabin",
        "baggage-checked-add-sm",
        "baggage-checked-add",
        "baggage-checked-not-included-sm",
        "baggage-checked-not-included",
        "baggage-checked-sm",
        "baggage-checked",
        "baggage-cross-sm",
        "baggage-cross",
        "baggage-generic-sm",
        "baggage-generic",
        "baggage-sm",
        "baggage-tick-sm",
        "baggage-tick",
        "baggage",
        "bar-sm",
        "bar",
        "beach-sm",
        "beach",
        "beer-sm",
        "beer",
        "breakfast-cross-sm",
        "breakfast-cross",
        "breakfast-tick-sm",
        "breakfast-tick",
        "bus-sm",
        "bus",
        "business-sm",
        "business",
        "cafe-sm",
        "cafe",
        "calendar-sm",
        "calendar",
        "call-back-sm",
        "call-back",
        "camera-sm",
        "camera",
        "camper-van-sm",
        "camper-van",
        "car-door-sm",
        "car-door",
        "car-wash-sm",
        "car-wash",
        "cars-flexible-sm",
        "cars-flexible",
        "cars-sm",
        "cars",
        "center-location-sm",
        "center-location",
        "chart-sm",
        "chart",
        "chauffeur-sm",
        "chauffeur",
        "chevron-down-sm",
        "chevron-down",
        "chevron-left-sm",
        "chevron-left",
        "chevron-right-sm",
        "chevron-right",
        "chevron-up-sm",
        "chevron-up",
        "child-seat-sm",
        "child-seat",
        "child-sm",
        "child",
        "city-center-sm",
        "city-center",
        "city-sm",
        "city",
        "clean-policy-sm",
        "clean-policy",
        "clean-sm",
        "clean",
        "cleaning-medical-sm",
        "cleaning-medical",
        "cloakroom-sm",
        "cloakroom",
        "close-circle-sm",
        "close-circle",
        "close-sm",
        "close",
        "collapse-sm",
        "collapse",
        "content--copy-sm",
        "content--copy",
        "content--event-sm",
        "content--event",
        "content--guides-sm",
        "content--guides",
        "currency-sm",
        "currency",
        "data-sm",
        "data",
        "deals-sm",
        "deals",
        "depart-sm",
        "depart",
        "device-mid-sm",
        "device-mid",
        "device-wide-sm",
        "device-wide",
        "direct-sm",
        "direct",
        "document-csv-sm",
        "document-csv",
        "document-pdf-sm",
        "document-pdf",
        "download-sm",
        "download",
        "duration-sm",
        "duration",
        "eco-leaf-sm",
        "eco-leaf",
        "edit-sm",
        "edit",
        "education-sm",
        "education",
        "electric-sm",
        "electric",
        "end-call-sm",
        "end-call",
        "estimated-sm",
        "estimated",
        "exclamation-circle-sm",
        "exclamation-circle",
        "exclamation-sm",
        "exclamation",
        "expand-sm",
        "expand",
        "explore-sm",
        "explore",
        "face--blank-sm",
        "face--blank",
        "face--happy-sm",
        "face--happy",
        "face--sad-sm",
        "face--sad",
        "face-id-sm",
        "face-id",
        "face-mask-sm",
        "face-mask",
        "family-sm",
        "family",
        "fast-track-sm",
        "fast-track",
        "fast-train-sm",
        "fast-train",
        "filter-sm",
        "filter",
        "fingerprint-sm",
        "fingerprint",
        "flag-sm",
        "flag",
        "flask-sm",
        "flask",
        "flight-flexible-sm",
        "flight-flexible",
        "flight-landing-sm",
        "flight-landing",
        "flight-sm",
        "flight-takeoff-sm",
        "flight-takeoff",
        "flight",
        "food-sm",
        "food",
        "gears-automatic-circle-sm",
        "gears-automatic-circle",
        "gears-automatic-sm",
        "gears-automatic",
        "gears-manual-circle-sm",
        "gears-manual-circle",
        "gears-manual-sm",
        "gears-manual",
        "globe-sm",
        "globe",
        "grid-layout-sm",
        "grid-layout",
        "headset-sm",
        "headset",
        "health-fitness-sm",
        "health-fitness",
        "heart--outline-sm",
        "heart--outline",
        "heart-sm",
        "heart",
        "help-circle-sm",
        "help-circle",
        "help-sm",
        "help",
        "hide-sm",
        "hide",
        "hotel-flexible-sm",
        "hotel-flexible",
        "hotels--disabled-facilities-sm",
        "hotels--disabled-facilities",
        "hotels--jacuzzi-sm",
        "hotels--jacuzzi",
        "hotels--pets-allowed-sm",
        "hotels--pets-allowed",
        "hotels--smoking-sm",
        "hotels--smoking",
        "hotels-sm",
        "hotels",
        "infant-sm",
        "infant",
        "information--language-alert-sm",
        "information--language-alert",
        "information--language-question-sm",
        "information--language-question",
        "information--language-sm",
        "information--language",
        "information-circle-sm",
        "information-circle",
        "information-sm",
        "information",
        "insurance-sm",
        "insurance",
        "key-sm",
        "key",
        "keypad-sm",
        "keypad",
        "landmark-sm",
        "landmark",
        "language-sm",
        "language",
        "legroom--extra-sm",
        "legroom--extra",
        "legroom--normal-sm",
        "legroom--normal",
        "legroom--reduced-sm",
        "legroom--reduced",
        "leisure-sm",
        "leisure",
        "lightning-sm",
        "lightning",
        "list-sm",
        "list",
        "location-sm",
        "location",
        "lock-sm",
        "lock",
        "logout-sm",
        "logout",
        "long-arrow-down-sm",
        "long-arrow-down",
        "long-arrow-left-sm",
        "long-arrow-left",
        "long-arrow-right-sm",
        "long-arrow-right",
        "long-arrow-up-sm",
        "long-arrow-up",
        "lounge-sm",
        "lounge",
        "luggageall-sm",
        "luggageall",
        "mail-sm",
        "mail",
        "map-sm",
        "map",
        "meal-sm",
        "meal",
        "media-sm",
        "media",
        "menu--horizontal-sm",
        "menu--horizontal",
        "menu--vertical-sm",
        "menu--vertical",
        "menu-sm",
        "menu",
        "mileage-sm",
        "mileage",
        "minus-sm",
        "minus",
        "mobile-sm",
        "mobile",
        "money-sm",
        "money",
        "multiple-bookings-sm",
        "multiple-bookings",
        "music-sm",
        "music",
        "mute-sm",
        "mute",
        "native-android--back-sm",
        "native-android--back",
        "native-android--close-sm",
        "native-android--close",
        "native-android--forward-sm",
        "native-android--forward",
        "native-ios-close-sm",
        "native-ios-close",
        "navigation-sm",
        "navigation",
        "new-window-sm",
        "new-window",
        "news-sm",
        "news",
        "night-sm",
        "night",
        "not-allowed-sm",
        "not-allowed",
        "onsen-sm",
        "onsen",
        "origin-sm",
        "origin",
        "paid-sm",
        "paid",
        "paperclip-sm",
        "paperclip",
        "parking-sm",
        "parking",
        "passport-sm",
        "passport",
        "pause-sm",
        "pause",
        "payment-card-sm",
        "payment-card",
        "petrol-sm",
        "petrol",
        "phone-call-sm",
        "phone-call",
        "picture-sm",
        "picture",
        "pin-sm",
        "pin",
        "plane-seat-sm",
        "plane-seat",
        "play-sm",
        "play",
        "plus-sm",
        "plus",
        "policy-sm",
        "policy",
        "powerplug-sm",
        "powerplug",
        "ppe-sm",
        "ppe",
        "price-alerts-sm",
        "price-alerts",
        "price-tag-sm",
        "price-tag",
        "print-sm",
        "print",
        "recent-searches-sm",
        "recent-searches",
        "redo-sm",
        "redo",
        "refresh-sm",
        "refresh",
        "return-sm",
        "return",
        "room-sm",
        "room",
        "scales-sm",
        "scales",
        "search-sm",
        "search",
        "self-service-sm",
        "self-service",
        "send-message-sm",
        "send-message",
        "services-sm",
        "services",
        "settings-sm",
        "settings",
        "share--android-sm",
        "share--android",
        "share--ios-sm",
        "share--ios",
        "share-sm",
        "share",
        "single-booking-sm",
        "single-booking",
        "social-distancing-sm",
        "social-distancing",
        "social-like-sm",
        "social-like",
        "sort-down-sm",
        "sort-down",
        "sort-sm",
        "sort-up-sm",
        "sort-up",
        "sort",
        "speaker-sm",
        "speaker",
        "star-half-sm",
        "star-half",
        "star-outline-sm",
        "star-outline",
        "star-sm",
        "star",
        "stops-sm",
        "stops",
        "swap--horizontal-sm",
        "swap--horizontal",
        "swap--vertical-sm",
        "swap--vertical",
        "swap-sm",
        "swap",
        "taxi-sm",
        "taxi",
        "thumbs-down-sm",
        "thumbs-down",
        "thumbs-up-sm",
        "thumbs-up",
        "tick-circle-sm",
        "tick-circle",
        "tick-sm",
        "tick",
        "ticket-flexible-sm",
        "ticket-flexible",
        "ticket-sm",
        "ticket",
        "time-sm",
        "time",
        "toilets-sm",
        "toilets",
        "train-sm",
        "train",
        "transmission-automatic-sm",
        "transmission-automatic",
        "transmission-manual-sm",
        "transmission-manual",
        "trash-sm",
        "trash",
        "trend--down-sm",
        "trend--down",
        "trend--steady-sm",
        "trend--steady",
        "trend--will-rise-sm",
        "trend--will-rise",
        "trend-sm",
        "trend",
        "trips-sm",
        "trips",
        "undo-sm",
        "undo",
        "unlock-sm",
        "unlock",
        "unmute-sm",
        "unmute",
        "upgrade-sm",
        "upgrade",
        "use-location-sm",
        "use-location",
        "view-sm",
        "view",
        "virus-sm",
        "virus",
        "wallet-sm",
        "wallet",
        "weather--clear-sm",
        "weather--clear",
        "weather--cloudy-sm",
        "weather--cloudy",
        "weather--fog-sm",
        "weather--fog",
        "weather--partly-cloudy-sm",
        "weather--partly-cloudy",
        "weather--rain-sm",
        "weather--rain",
        "weather--snow-sm",
        "weather--snow",
        "weather--thunderstorm-sm",
        "weather--thunderstorm",
        "weather--tornado-sm",
        "weather--tornado",
        "weather--wind-sm",
        "weather--wind",
        "weather-sm",
        "weather",
        "wifi-sm",
        "wifi",
        "window--reduce-sm",
        "window--reduce",
        "window-sm",
        "window",
        "world--amer-sm",
        "world--amer",
        "world--apac-sm",
        "world--apac",
        "world--emea-sm",
        "world--emea"
    ]
}
