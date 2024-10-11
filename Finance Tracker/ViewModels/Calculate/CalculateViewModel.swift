//
//  CalculateViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 14.08.2024.
//

import Observation
import SwiftUI

@Observable
final class CalculateViewModel {
    
    @ObservationIgnored @AppStorage("calculateCount") var calculateCount = 0
}
