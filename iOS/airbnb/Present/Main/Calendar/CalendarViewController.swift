//
//  CalendarViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/08.
//

import UIKit

final class CalendarViewController: UIViewController {

    var coordinator: CalendarFlow?
    
    private let viewModel: CalendarViewModel = CalendarViewModel()
    
    private var weekdayListCollectionView: UICollectionView! = nil
    private var calendarCollectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.navigationItem.title = "숙소 찾기"
        
        bind()
    }
    
    private func bind() {
    }
}
