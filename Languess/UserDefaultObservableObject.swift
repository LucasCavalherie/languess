//
//  UserDefaultObservableObject.swift
//  Languess
//
//  Created by Lucas Cavalherie on 03/08/23.
//

import Combine
import Foundation

class RecordController {
    static let shared = RecordController()
    
    private(set) var record: CurrentValueSubject<Int, Never>
    
    private init() {
        record = CurrentValueSubject(
            (UserDefaults.standard.value(forKey: "highScore") != nil) ? UserDefaults.standard.value(forKey: "highScore") as! Int : 0
        )
    }
    
    static func updateRecord(newRecord : Int) {
        if newRecord > shared.record.value  { shared.record.value = newRecord}
    }
}
