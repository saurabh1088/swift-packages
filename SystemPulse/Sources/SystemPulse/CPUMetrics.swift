//
//  CPUMetrics.swift
//  SystemPulse
//
//  Created by Saurabh Verma on 08/01/26.
//

import Foundation

struct CPUMetrics {
    let user: Double
    let system: Double
    let idle: Double
    
    var totalUsage: Double {
        return user + system
    }
}
