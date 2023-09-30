//
//  Date.swift
//  AlcoTracker
//
//  Created by Владимир on 23.09.2023.
//

import Foundation

extension Date {
    var startDate: Date {
        dateTruncated([.second, .hour, .minute]) ?? Date()
    }

    var endDate: Date {
        (
            dateTruncated([.second, .hour, .minute]) ?? Date()

        ).date.addingTimeInterval(1.days.timeInterval)
    }
}
