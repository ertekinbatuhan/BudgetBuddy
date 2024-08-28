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
        .init(string: "Hoş Geldiniz", attributes: [.foregroundColor: UIColor.label])
    }
    
   
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        .init(string: Bundle.main.displayName ?? "BütçeDostu", attributes: [
            .foregroundColor: UIColor.systemBlue
        ])
    }

    static func setUpFeatures() -> Array<UIOnboardingFeature> {
           return .init([
               .init(icon: UIImage(systemName: "dollarsign.circle")!,
                     title: "Gelir ve Gider Takibi",
                     description: "Tüm finansal hareketlerinizi takip edin ve kontrol altında tutun."),
               .init(icon: UIImage(systemName: "chart.bar.fill")!,
                     title: "Kategorilere Göre Analiz",
                     description: "Harcamalarınızı kategorilere göre analiz edin ve bütçenizi optimize edin."),
               .init(icon: UIImage(systemName: "chart.pie.fill")!,
                     title: "Grafikler ile Görselleştirin",
                     description: "Finansal durumunuzu grafiklerle görselleştirerek daha iyi anlayın.")
           ])
       }

       static func setUpNotice() -> UIOnboardingTextViewConfiguration {
           return .init(icon: UIImage(systemName: "info.circle.fill")!,
                        text: "Bu uygulama, kişisel finans yönetiminizi daha kolay hale getirmek için tasarlandı.",
                        linkTitle: "Sorularınız için",
                        link: "https://ertekinbatuhan.wordpress.com",
                        tint: UIColor.systemBlue)
       }


    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "Devam Et",
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

