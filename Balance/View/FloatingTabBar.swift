//
//  FloatingTabBar.swift
//  Balance
//
//  Created by Pavel Paddubotski on 03/05/2025.
//

import SwiftUI

enum Tab: Int, CaseIterable {
    case home, stats, profile

    var icon: String {
        switch self {
        case .home: return "house"
        case .stats: return "chart.bar"
        case .profile: return "person"
        }
    }

    var title: String? {
        switch self {
        case .home: return "Home"
        case .stats: return "Stats"
        case .profile: return "Profile"
        }
    }
}

struct FloatingTabBar: View {
    private enum Constants {
        static let indicatorWidth: CGFloat = 100
        static let indicatorHeight: CGFloat = 55
        static let tabSpacing: CGFloat = 6
        static let tabPadding: CGFloat = 12
        static let barPadding: CGFloat = 6
        static let animationResponse: Double = 0.4
        static let animationDamping: Double = 0.75
    }
    
    @Binding var selectedTab: Tab
    @Namespace private var animation


    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation(.spring(response: Constants.animationResponse, dampingFraction: Constants.animationDamping)) {
                        selectedTab = tab
                    }
                }) {
                    ZStack {
                        if selectedTab == tab {
                            Capsule()
                                .fill(Color.white)
                                .matchedGeometryEffect(id: "tabIndicator", in: animation)
                                .frame(width: Constants.indicatorWidth, height: Constants.indicatorHeight)
                        }
                        HStack(spacing: Constants.tabSpacing) {
                            Image(systemName: tab.icon)
                                .foregroundColor(selectedTab == tab ? .black : .white)
                            if let title = tab.title, selectedTab == tab {
                                Text(title)
                                    .foregroundColor(.black)
                                    .font(.caption)
                            }
                        }
                        .padding(.horizontal, selectedTab == tab ? Constants.tabPadding : 0)
                        .frame(height: Constants.indicatorHeight)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(Constants.barPadding)
        .background(Color.black)
        .clipShape(Capsule())
    }
}
