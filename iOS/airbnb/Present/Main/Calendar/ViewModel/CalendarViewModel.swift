//
//  CalendarViewModel.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/09.
//

import Foundation

final class CalendarViewModel {
    static let weeks = ["일", "월", "화", "수", "목", "금", "토"]
    
    private let today = Date() // 오늘의 날짜
    private var dateOfToday = Date() // 날짜를 계산하는 기준 날짜
    private let dateComponents = DateComponents()
    private let dateStringOfToday: String? = nil
    private var totalDates = [String]() // dates를 담는 배열
    private var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    private var weekdayStarting = 0 // 시작일
    private let calendarManager = CalendarManager()
    
    func previousMonth() {
        dateOfToday = calendarManager.minusMonth(date: dateOfToday)
        self.calculateMonth()
    }
    
    func nextMonth() {
        dateOfToday = calendarManager.plusMonth(date: dateOfToday)
        self.calculateMonth()
    }
    
    // 월별 날짜를 계산하고 뷰에 표시
    func calculateMonth() {
        let firstDayOfMonth = calendarManager.firstOfMonth(date: dateOfToday) // 첫째날의 전 일.. 예를 들면 7월 1일 이전인 6월 30일 나옴.
        let firstWeekday = calendarManager.weekDay(date: firstDayOfMonth) // 해당 월에서 첫번째로 시작하는 요일
        
        daysCountInMonth = calendarManager.calendar.range(of: .day, in: .month, for: firstDayOfMonth)!.count
        weekdayStarting = 1 - firstWeekday
        
        self.totalDates.removeAll()
        
        for day in weekdayStarting...daysCountInMonth {
            if day < 1 {
                self.totalDates.append("")
            } else {
                self.totalDates.append(String(day))
            }
        }
    }
}
