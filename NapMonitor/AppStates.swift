//
//  AppStates.swift
//  NapMonitor
//
//  Created by Arwin Krishnan on 06/05/2020.
//  Copyright © 2020 Arwin Krishnan. All rights reserved.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var moveToDashboard: Bool = false
}
