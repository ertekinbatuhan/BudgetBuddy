//
//  TestBannerView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 15.08.2024.
//

import SwiftUI
import GoogleMobileAds

struct BannerView: UIViewControllerRepresentable {
    
    let bannerView = GADBannerView(adSize: GADAdSizeBanner)
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        let viewController = UIViewController()
        bannerView.adUnitID = ""
        bannerView.rootViewController = viewController
        viewController.view.addSubview(bannerView)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        bannerView.load(GADRequest())
    }
}

#Preview {
    BannerView()
}
