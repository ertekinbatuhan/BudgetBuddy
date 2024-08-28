//
//  AdCoordinator.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 14.08.2024.
//
//

import Foundation
import GoogleMobileAds

class AdCoordinator: NSObject,GADFullScreenContentDelegate {
    private var ad: GADInterstitialAd?
    
    static let shared = AdCoordinator()
    
    override init() {
        super.init()
        loadAd()
    }
    
    func loadAd() {
        let request = GADRequest()
        request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        GADInterstitialAd.load(
            withAdUnitID: "", request: request
        ) { ad, error in
            if let error = error {
                return print("Failed to load ad with error: \(error.localizedDescription)")
            }
            
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
            
        }
    }
    
    func presentAd() {
        guard let fullScreenAd = ad else {
            return print("Ad wasn't ready")
        }
        
        fullScreenAd.present(fromRootViewController: nil)
    }
    
    // MARK: - GADFullScreenContentDelegate methods
    
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
        loadAd()
        
    }
    
}
