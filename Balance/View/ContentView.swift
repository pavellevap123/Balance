//
//  ContentView.swift
//  Balance
//
//  Created by Pavel Paddubotski on 02/05/2025.
//

import SwiftUI

struct ContentView: View {
    private enum Constants {
        static let recipientImageSize: CGFloat = 60
        static let transactionIconSize: CGFloat = 45
        static let tabBarWidth: CGFloat = 240
        static let addButtonSize: CGFloat = 65
    }

    @State private var selectedTab: Tab = .home
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()
            
            VStack(spacing: 20) {
                header
                balanceSection
                BalanceChartView (selectedPeriod: $viewModel.selectedPeriod,
                          periods: viewModel.periods,
                          dataPoints: viewModel.filteredData)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                    .foregroundColor(.black)
                recipientsSection
                transactionsSection
                bottomBar
            }
            .padding(.top)
        }
    }
    
    private var header: some View {
        HStack {
            Text("Welcome, ")
                .font(.title3)
                .bold()
                .foregroundColor(.gray)
            + Text("John!")
                .font(.title3)
                .bold()
            Spacer()
            Button(action: {
                // TODO: Handle notifications tap
            }) {
                Image(systemName: "bell.badge")
                    .foregroundStyle(.red, .black)
            }
        }
        .padding(.horizontal)
    }
    
    private var balanceSection: some View {
        VStack(spacing: 8) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
                .padding(.horizontal)

            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text("$ 13,553.00")
                    .font(.largeTitle).bold()
                Text("Balance")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private var recipientsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recipients").bold()
            HStack {
                let maxVisible = 4
                let nextImageIndex = viewModel.recipients.indices.contains(maxVisible) ? maxVisible : nil
                let visibleRecipients = Array(viewModel.recipients.prefix(maxVisible))
                let extraCount = viewModel.recipients.count - maxVisible
                
                ForEach(visibleRecipients.indices, id: \.self) { index in
                    Spacer()
                    ZStack(alignment: .bottomTrailing) {
                        Image(visibleRecipients[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: Constants.recipientImageSize, height: Constants.recipientImageSize)
                            .clipShape(Circle())
                        
                        Circle()
                            .fill(Color.green)
                            .frame(width: 14, height: 14)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .offset(x: 2, y: 2)
                    }
                    Spacer()
                }
                
                if extraCount > 0 {
                    Spacer()
                    ZStack {
                        if let index = nextImageIndex {
                            Image(viewModel.recipients[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: Constants.recipientImageSize, height: Constants.recipientImageSize)
                                .clipShape(Circle())
                        }

                        Circle()
                            .fill(Color.black.opacity(0.4))
                            .overlay(
                                Text("+\(extraCount)")
                                    .foregroundColor(.white)
                                    .bold()
                            )
                            .frame(width: Constants.recipientImageSize, height: Constants.recipientImageSize)
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding([.horizontal, .bottom])
    }
    
    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transactions history").bold()
            ScrollView(showsIndicators: false) {
                TransactionRowView(icon: "fork.knife", title: "Food", subtitle: "Payment", amount: "- $40.99", isPositive: false)
                TransactionRowView(icon: "building.columns", title: "AI-Bank", subtitle: "Deposit", amount: "+ $460.00", isPositive: true)
            }
        }
        .padding(.horizontal)
    }
    
    private var bottomBar: some View {
        HStack {
            FloatingTabBar(selectedTab: $selectedTab)
                .frame(width: Constants.tabBarWidth)
            Spacer()
            Button(action: {
                // TODO: Handle add button tap
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: Constants.addButtonSize, height: Constants.addButtonSize)
                    .background(Color.black)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
