//
//  Date+extension.swift
//  Hacker Client
//
//  Created by Admin on 7/19/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit

extension Date{
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    func offset(from time: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: time)
        
        if years(from: date) > 0 {
            let year = years(from: date)
            if year == 1 {
                return "1 year ago"
            }
            return "\(year) years ago"
        }
        
        if months(from: date) > 0 {
            let month = months(from: date)
            if month == 1 {
                return "1 month ago"
            }
            return "\(month) months ago"
        }
        
        if weeks(from: date) > 0 {
            let week = weeks(from: date)
            if week == 1 {
                return "1 week ago"
            }
            return "\(week) weeks ago"
        }
        
        if days(from: date) > 0 {
            let day = days(from: date)
            if day == 1 {
                return "1 day ago"
            }
            return "\(day) days ago"
        }
        
        if hours(from: date) > 0 {
            let hour = hours(from: date)
            if hour == 1 {
                return "1 hour ago"
            }
            return "\(hour) hours ago"
        }
        
        if minutes(from: date) > 0 {
            let minute = minutes(from: date)
            if minute == 1 {
                return " minute ago"
            }
            return "\(minute) minutes ago"
        }
        
        if seconds(from: date) > 0 {
            let second = seconds(from: date)
            if second == 1{
                return "1 second ago"
            }
            return "\(second) seconds ago"
        }
        return ""
    }
}
