//
//  OnboardingModel.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import Foundation
import SwiftUI

struct Onboard: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var desc: String
}

let OnboardData: [Onboard] = [
    Onboard(image: "1", title: "PERSONAL TRIP ASSISTANT", desc: "Help Managing Your Travel Expenses"),
    Onboard(image: "2", title: "SPLIT THE BILL", desc: "Share the Bills with Your Travelmate"),
    Onboard(image: "3", title: "TRAVEL AND CHILL!", desc: "Travel More, Worry Less")
]
