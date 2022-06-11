//
//  CalendarViewModel.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/09.
//

import Foundation

final class CalendarViewModel {
    static let weeks = ["일", "월", "화", "수", "목", "금", "토"]
    
    let today = Date() // 오늘의 날짜
    let dateOfToday = Date() // 날짜를 계산하는 기준 날짜
    let dateComponents = DateComponents()
    let dateStringOfToday: String? = nil
    let totalDates = [String]() // dates를 담는 배열
    let daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    let weekdayStarting = 0 // 시작일
    
    
}
