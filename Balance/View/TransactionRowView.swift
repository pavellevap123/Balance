//
//  TransactionRowView.swift
//  Balance
//
//  Created by Pavel Paddubotski on 04/05/2025.
//

import SwiftUI

struct TransactionRowView: View {
    private enum Constants {
        static let transactionIconSize: CGFloat = 45
        static let cornerRadius: CGFloat = 8
        static let subtitleFont: Font = .caption
        static let subtitleColor: Color = .gray
        static let amountPositiveColor: Color = .black
        static let amountNegativeColor: Color = .gray
        static let backgroundColor: Color = .black
        static let foregroundColor: Color = .white
    }
    
    let icon: String
    let title: String
    let subtitle: String
    let amount: String
    let isPositive: Bool

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: Constants.transactionIconSize, height: Constants.transactionIconSize)
                .background(Constants.backgroundColor)
                .foregroundColor(Constants.foregroundColor)
                .cornerRadius(Constants.cornerRadius)
            VStack(alignment: .leading) {
                Text(title)
                Spacer()
                Text(subtitle)
                    .font(Constants.subtitleFont)
                    .foregroundColor(Constants.subtitleColor)
            }
            Spacer()
            Text("\(amount)")
                .foregroundColor(isPositive ? Constants.amountPositiveColor : Constants.amountNegativeColor)
        }
    }
}
