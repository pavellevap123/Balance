//
//  BalanceChartView .swift
//  Balance
//
//  Created by Pavel Paddubotski on 03/05/2025.
//

import Charts
import SwiftUI

struct BalanceChartView : View {
    private enum Constants {
        static let containerHeight: CGFloat = 200
        static let chartYOffset: CGFloat = 35
        static let chartHeight: CGFloat = 140
        static let topPadding: CGFloat = 25
        static let pointSize: CGFloat = 7
        static let strokeSize: CGFloat = 9
        static let annotationOffsetY: CGFloat = -5
        static let annotationCornerRadius: CGFloat = 4
        static let backgroundCornerRadius: CGFloat = 20
        static let periodButtonCornerRadius: CGFloat = 8
        static let periodButtonWidth: CGFloat = 42
        static let periodButtonHeight: CGFloat = 26
        static let annotationPadding: CGFloat = 4
        static let annotationStrokeWidth: CGFloat = 3
        static let verticalSpacing: CGFloat = 16
        static let chartYScaleMax: Double = 300
        static let chartYScaleStep: Double = 100
        static let periodButtonSpacing: CGFloat = 10
        static let animation: Animation = .easeInOut
    }
    
    @Namespace private var animation
    @Binding var selectedPeriod: String
    let periods: [String]
    let dataPoints: [DataPoint]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.backgroundCornerRadius)
                .fill(Color(.systemGray2))
                .frame(height: Constants.containerHeight)
                .offset(y: Constants.chartYOffset)
            
            VStack(spacing: Constants.verticalSpacing) {
                Chart {
                    ForEach(dataPoints) { point in
                        LineMark(
                            x: .value("Period", point.period),
                            y: .value("Value", point.value)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(.white)
                        
                        if point == dataPoints.last {
                            PointMark(
                                x: .value("Period", point.period),
                                y: .value("Value", point.value)
                            )
                            .symbol {
                                Circle()
                                    .fill(.white)
                                    .frame(width: Constants.pointSize, height: Constants.pointSize)
                                    .overlay(
                                        Circle()
                                            .stroke(.red, lineWidth: Constants.annotationStrokeWidth)
                                            .frame(width: Constants.strokeSize, height: Constants.strokeSize)
                                    )
                            }
                            .annotation {
                                Text("$\(Int(point.value))")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(Constants.annotationPadding)
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: Constants.annotationCornerRadius))
                                    .offset(y: Constants.annotationOffsetY)
                            }
                        }
                    }
                }
                .frame(height: Constants.chartHeight)
                .padding(.top, Constants.topPadding)
                .chartYScale(domain: 0...Constants.chartYScaleMax)
                .chartYAxis {
                    AxisMarks(position: .leading, values: Array(stride(from: 0, through: Constants.chartYScaleMax, by: Constants.chartYScaleStep))) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                            .foregroundStyle(.white)
                    }
                }
                .chartXAxis(.hidden)
                
                
                HStack(spacing: Constants.periodButtonSpacing) {
                    ForEach(periods, id: \.self) { period in
                        ZStack {
                            if selectedPeriod == period {
                                RoundedRectangle(cornerRadius: Constants.periodButtonCornerRadius)
                                    .fill(.gray)
                                    .matchedGeometryEffect(id: "background", in: animation)
                            }
                            Text(period)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .frame(width: Constants.periodButtonWidth, height: Constants.periodButtonHeight)
                        .onTapGesture {
                            selectedPeriod = period
                        }
                    }
                }
                .animation(Constants.animation, value: selectedPeriod)
            }
            .padding()
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: Constants.backgroundCornerRadius))
        }
    }
}
