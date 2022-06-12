//
//  CalendarItem.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/12.
//

import Foundation

final class CalendarItem: Hashable {
    let day: Int
    
    init(day: Int) {
        self.day = day
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: CalendarItem, rhs: CalendarItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}

enum CalendarSection: String, CaseIterable {
    case calendar = "달력"
}
