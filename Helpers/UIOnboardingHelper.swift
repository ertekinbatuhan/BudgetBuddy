//
//  UIOnboardingHelper.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 20.08.2024.
//

import UIKit
import UIOnboarding

struct UIOnboardingHelper {
   
    static func setUpIcon() -> UIImage {
        return Bundle.main.appIcon ?? .init(named: "onboarding-icon")!
    }

    static func setUpFirstTitleLine() -> NSMutableAttributedString {
        let welcomeText = NSLocalizedString("WELCOME_TEXT", comment: "Welcome message")
        return .init(string: welcomeText, attributes: [.foregroundColor: UIColor.label])
    }
    
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        let appName = Bundle.main.displayName ?? NSLocalizedString("APP_NAME", comment: "App name fallback")
        return .init(string: appName, attributes: [.foregroundColor: UIColor.systemBlue])
    }

    static func setUpFeatures() -> [UIOnboardingFeature] {
        return .init([
            .init(icon: UIImage(systemName: "dollarsign.circle")!,
                  title: NSLocalizedString("FEATURE_INCOME_EXPENSE_TRACKING_TITLE", comment: "Title for income and expense tracking feature"),
                  description: NSLocalizedString("FEATURE_INCOME_EXPENSE_TRACKING_DESCRIPTION", comment: "Description for income and expense tracking feature")),
            .init(icon: UIImage(systemName: "chart.bar.fill")!,
                  title: NSLocalizedString("FEATURE_CATEGORY_ANALYSIS_TITLE", comment: "Title for category analysis feature"),
                  description: NSLocalizedString("FEATURE_CATEGORY_ANALYSIS_DESCRIPTION", comment: "Description for category analysis feature")),
            .init(icon: UIImage(systemName: "chart.pie.fill")!,
                  title: NSLocalizedString("FEATURE_GRAPH_VISUALIZATION_TITLE", comment: "Title for graph visualization feature"),
                  description: NSLocalizedString("FEATURE_GRAPH_VISUALIZATION_DESCRIPTION", comment: "Description for graph visualization feature"))
        ])
    }

    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        return .init(icon: UIImage(systemName: "info.circle.fill")!,
                     text: NSLocalizedString("NOTICE_TEXT", comment: "Notice text"),
                     linkTitle: NSLocalizedString("NOTICE_LINK_TITLE", comment: "Link title for notice"),
                     link: "https://ertekinbatuhan.wordpress.com",
                     tint: UIColor.systemBlue)
    }

    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: NSLocalizedString("CONTINUE_BUTTON_TITLE", comment: "Title for continue button"),
                     titleColor: .white,
                     backgroundColor: UIColor.systemBlue)
    }
}

extension UIOnboardingViewConfiguration {
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setUpIcon(),
                     firstTitleLine: UIOnboardingHelper.setUpFirstTitleLine(),
                     secondTitleLine: UIOnboardingHelper.setUpSecondTitleLine(),
                     features: UIOnboardingHelper.setUpFeatures(),
                     textViewConfiguration: UIOnboardingHelper.setUpNotice(),
                     buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}
