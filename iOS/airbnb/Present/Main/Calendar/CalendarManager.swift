//
//  CalendarManager.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/12.
//

import Foundation

class CalendarManager {
    let calendar = Calendar.current
    
    // 한 달 뒤
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    // 한 달 전
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    // Month
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        return dateFormatter.string(from: date)
    }
    
    // Year
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    // 한 달에 총 몇 일까지 있는지
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        
        return range.count
    }
    
    // Day
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        
        return components.day!
    }
    
    // 월의 첫번째 날짜 출력
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        
        return calendar.date(from: components)!
    }
    
    // input: 1 Jan 2021, result: 5(Friday (6) - 1)
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        print("*** weekday \(components.weekday! - 1)")
        return components.weekday! - 1
    }
}
