//
//  Date+Extensions.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 1/9/23.
//

import Foundation
extension Date {
    var displayFormat: String {
        self.formatted(.iso8601)
    }
}

//extension Date {
//    var displayFormat: String {
//        //self.formatted(date: .numeric, time: .omitted)
//        self.formatted(
//            .dateTime
//                .year() //2023
//                .month(.twoDigits)
//                .day(.twoDigits)
//                .hour(.conversationalDefaultDigits(amPM: .omitted))
//                .minute(.twoDigits)
//
//        )
//    }
//}
