//
//  Fight.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 23/07/23.
//

import UIKit
import UserNotifications

class FightItem: NSObject, Codable {
    
    var opponent: WrestlerItem?
    var dueDate = Date()
    var local: WrestlerItem
    var itemID = -1
    
    init(opponent: WrestlerItem?, date: Date, local: WrestlerItem) {
        self.opponent = opponent
        self.dueDate = date
        self.local = local
        super.init()
        itemID = DataModel.nextChecklistsItemID()
    }
    
    func scheduleNotification() {
        removeNotification()
        
        if dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = "Pelea"
            content.sound = .default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("Scheduled: \(request) for itemID: \(itemID)")
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    deinit {
        removeNotification()
    }
}
