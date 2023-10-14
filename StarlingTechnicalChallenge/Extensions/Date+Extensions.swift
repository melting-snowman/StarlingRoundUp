//
//  Date+Extensions.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

extension Date {
    
    static private let dateFormatter = DateFormatter()
    
    func dateFormattedForNetworkCall() -> String {
        Self.dateFormatter.dateFormat = "YYYY-MM-dd"
        return Self.dateFormatter.string(from: self)
    }
    
}
