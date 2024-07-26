//
//  CoinViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 26.07.2024.
//

import Foundation
import Alamofire

class CoinViewModel : ObservableObject{
    
    @Published var coin = [Coin]()
    
    init() {
        fetchCoins()
    }
    var topEarners: [Coin] {
            coin.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 > $1.priceChangePercentage24HInCurrency ?? 0 })
        }
        
    func fetchCoins(){
        
        AF.request("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en",method: .get).responseDecodable(of: [Coin].self) { response in
            
            switch response.result {
            case .success(let coin):
               
                DispatchQueue.main.async{
                    self.coin = coin
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
