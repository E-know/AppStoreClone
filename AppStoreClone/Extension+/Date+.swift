//
//  Date+.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation

extension Date {
    static func fromISO8601String(_ iso8601String: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: iso8601String)
    }
    
    func toPassedString() -> String {
        let calendar = Calendar.current
        let now = Date()
        let koreanTimeZone = TimeZone(identifier: "Asia/Seoul") ?? .current

        let currentDate = calendar.date(byAdding: .second, value: koreanTimeZone.secondsFromGMT(for: now), to: now) ?? now
        let targetDate = calendar.date(byAdding: .second, value: koreanTimeZone.secondsFromGMT(for: self), to: self) ?? self

        let components = calendar.dateComponents([.day, .weekOfYear, .month, .year], from: targetDate, to: currentDate)

        if calendar.isDateInToday(targetDate) {
            return "오늘"
        } else if let day = components.day, day < 7 {
            return "\(day)일 전"
        } else if let week = components.weekOfYear, week < 5 {
            return "\(week)주 전"
        } else if let month = components.month, month < 12 {
            return "\(month)개월 전"
        } else if let year = components.year {
            return "\(year)년 전"
        } else {
            return "오래 전"
        }
    }
}
