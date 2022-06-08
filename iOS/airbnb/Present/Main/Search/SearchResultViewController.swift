//
//  SearchResultViewController.swift
//  airbnb
//
//  Created by 안상희 on 2022/06/06.
//

import MapKit
import UIKit

protocol SearchResultDelegate: AnyObject {
    func getCompleterResult(completerResults: [MKLocalSearchCompletion]?)
}

final class SearchResultViewController: UIViewController, SearchRecommendationDelegate {

    private var coordinator: SearchFlow?
    private var delegate: SearchResultDelegate?
    
    private var searchResultTableView: UITableView! = nil
    private lazy var dataSource: SearchResultTableViewDataSource = SearchResultTableViewDataSource(delegate: delegate)
    
    var searchCompleter: MKLocalSearchCompleter? // 검색 도와주는 변수
    var searchRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world) // 검색 지역 범위를 결정하는 변수
    var completerResults: [MKLocalSearchCompletion]? // 검색 결과를 담는 변수
    private var searchText: String = ""
    
    private var places: MKMapItem? { // tableView에서 선택한 Location의 정보를 담는 변수
        didSet {
            searchResultTableView.reloadData()
        }
    }
    
    private var localSearch: MKLocalSearch? { // tableView에서 선택한 Location의 정보를 가져오는 변수
        willSet {
            // Clear the results and cancel the currently running local search befor staring a new search.
            places = nil
            localSearch?.cancel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        configureTableView()
        
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
        // 검색할 유형 (.address: 지도, .pointOfInterest: 건물과 같은 특정 지점 검색, .query: 모든 결과 검색)
        searchCompleter?.resultTypes = .address
        searchCompleter?.region = searchRegion
        
        delegate = dataSource
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        searchCompleter = nil
    }
    
    private func configureTableView() {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.register(SearchResultTableViewCell.self,
                           forCellReuseIdentifier: String(describing: SearchResultTableViewCell.self))
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        searchResultTableView = tableView
    }
    
    func searchBarTextDidChange(string: String, coordinator: SearchFlow?) {
        searchText = string
        searchCompleter?.queryFragment = searchText
        self.coordinator = coordinator
    }
}

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = completerResults?[indexPath.item] // 검색 결과 배열 (completerResults) 중 선택한 값
        
        guard let selectedResult = selectedResult else { return }
        
        let searchRequest = MKLocalSearch.Request(completion: selectedResult) // 지도에서 특정 지점을 검색할 때 사용하는 매개변수
        let search = MKLocalSearch(request: searchRequest) // searchRequest로 구성된 search object를 초기화하고 반환
        search.start { response, error in // 검색을 시작하고, 결과를 completionHandler에 전달
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placeMark = response?.mapItems[0].placemark else { return }
            
            let latitude = placeMark.coordinate.latitude
            let longitude = placeMark.coordinate.longitude
            
            print("latitude \(latitude), longitude \(longitude)") // 서버에게 전달할 데이터
        }
        
        coordinator?.coordinateToCalendarViewController()
    }
}

extension SearchResultViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completerResults = completer.results
        
        delegate?.getCompleterResult(completerResults: completerResults)
        searchResultTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription).")
            print("The query fragment is: \"\(completer.queryFragment)\"")
        }
    }
}
