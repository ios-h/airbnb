//
//  CalendarViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

final class CalendarViewController: UIViewController {

    var coordinator: CalendarFlow?
    
    private var today = Date() // 오늘의 날짜
    private var dateOfToday = Date() // 날짜를 계산하는 기준 날짜
    private var dateComponents = DateComponents()
    private var dateStringOfToday: String?
    private var totalDates = [String]() // dates를 담는 배열
    private var weeks = ["일", "월", "화", "수", "목", "금", "토"]
    private var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    private var weekdayStarting = 0 // 시작일
    
    private var weekdayListCollectionView: UICollectionView! = nil
    private var calendarCollectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.navigationItem.title = "숙소 찾기"
    }
}
