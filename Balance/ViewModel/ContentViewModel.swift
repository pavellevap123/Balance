//
//  ContentViewModel.swift
//  Balance
//
//  Created by Pavel Paddubotski on 04/05/2025.
//

import Combine
import Foundation

struct DataPoint: Identifiable, Equatable {
    let id = UUID()
    let period: String
    let value: Double
}

final class ContentViewModel: ObservableObject {
    private enum Constants {
        static let defaultPeriod = "1D"
        static let periods = ["1D", "5D", "1M", "3M", "6M", "1Y"]
        static let dailyRange = 1...15
        static let dailyValueRange = 40.0...220.0
        static let fiveDayRange = 1...15
        static let fiveDayValueRange = 40.0...220.0
        static let monthlyRange = 1...30
        static let monthlyValueRange = 60.0...240.0
        static let threeMonthRange = 1...12
        static let threeMonthValueRange = 70.0...260.0
        static let sixMonthRange = 1...16
        static let sixMonthValueRange = 100.0...300.0
        static let yearRange = 1...22
        static let yearValueRange = 80.0...260.0
        static let recipients = ["Human0", "Human1", "Human2", "Human3", "Human4", "Human5"]
    }

    @Published var selectedPeriod: String = Constants.defaultPeriod

    let periods: [String] = Constants.periods

    let allData: [String: [DataPoint]] = [
        "1D": Constants.dailyRange.map { DataPoint(period: "\($0)", value: Double.random(in: Constants.dailyValueRange)) },
        "5D": Constants.fiveDayRange.map { DataPoint(period: "\($0)", value: Double.random(in: Constants.fiveDayValueRange)) },
        "1M": Constants.monthlyRange.map { DataPoint(period: "\($0)", value: Double.random(in: Constants.monthlyValueRange)) },
        "3M": Constants.threeMonthRange.map { DataPoint(period: "\($0)", value: Double.random(in: Constants.threeMonthValueRange)) },
        "6M": Constants.sixMonthRange.map { DataPoint(period: "\($0)", value: Double.random(in: Constants.sixMonthValueRange)) },
        "1Y": Constants.yearRange.map { DataPoint(period: "\($0)", value: Double.random(in: Constants.yearValueRange)) }
    ]

    var filteredData: [DataPoint] {
        allData[selectedPeriod, default: []]
    }

    let recipients: [String] = Constants.recipients
}
