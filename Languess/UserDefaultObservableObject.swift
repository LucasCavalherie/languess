//
//  UserDefaultObservableObject.swift
//  Languess
//
//  Created by Lucas Cavalherie on 03/08/23.
//

import Combine

class RecordController {
    static let shared = RecordController()
    
    private(set) var record: CurrentValueSubject<Int, Never>
    
    private init() {
        record = CurrentValueSubject(0)
    }
    
    static func updateRecord(newRecord : Int) {
        if newRecord > shared.record.value  { shared.record.value = newRecord}
    }
}
