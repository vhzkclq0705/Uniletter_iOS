//
//  SearchViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/20.
//

import Foundation

class SearchViewModel {
    
    var events = [Event]()
    var pageNum = 0
    var isLast = false
    
    var searchContent = "" {
        willSet { removeEvents() }
    }

    var categoty = 0 {
        willSet { removeEvents() }
    }
    
    var eventStatus = true {
        willSet { removeEvents() }
    }
    
    let eventStatusList = ["전체", "진행중"]
    
    let categoryList = ["전체", "동아리/소모임", "학생회", "간식나눔", "대회/공모전", "스터디", "구인", "기타"]
    
    var numOfEvents: Int {
        return events.count
    }
    
    func eventAtIndex(index: Int) -> Event {
        return events[index]
    }
    
    private func removeEvents() {
        events.removeAll()
        pageNum = 0
        isLast = false
    }
    
    func fetchEvent(completion: @escaping() -> Void) {
        API.searchEvent(content: self.searchContent, pageNum: pageNum) { result in
            if !result.isEmpty {
                self.events += result
                self.pageNum += 1
            } else {
                self.isLast = true
            }
            completion()
        }
    }
}

