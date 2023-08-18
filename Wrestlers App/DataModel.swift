//
//  DataModel.swift
//  Wrestlers App
//
//  Created by Benjamin Jaramillo on 16/08/23.
//

import UIKit

class DataModel {
    var Wrestlers  = [WrestlerItem]()
    
    // Mark:- Data Saving
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Wrestlers.plist")
    }
    
    var indexOfSelectedWrestler: Int {
        get {
            return UserDefaults.standard.integer(forKey: "WrestlerIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "WrestlerIndex")
        }
    }
    
    func registerDefaults() {
        let dictionary = [
            "WrestlerIndex": -1,
            "FirstTime": true
        ] as [String: Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            let wrestler1 = WrestlerItem(name: "La Parka", imageName: "laparka", description: "El mejor de México")
            Wrestlers .append(wrestler1)
            
            let wrestler2 = WrestlerItem(name: "Kemonito", imageName: "kemonito", description: "Kemonito es lo bonito")
            Wrestlers .append(wrestler2)
            
            indexOfSelectedWrestler = 0
            
            userDefaults.set(false, forKey: "FirstTime")
        }
    }
    
    func saveWrestlers() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(Wrestlers)
            try data.write(to: dataFilePath(), options: .atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }
    
    func loadWrestlers() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                Wrestlers = try decoder.decode([WrestlerItem].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }

    init() {
        loadWrestlers() 
        registerDefaults()
        handleFirstTime()
    }
    
    class func nextChecklistsItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "FightItemID")
        userDefaults.set(itemID + 1, forKey: "FightItemID")
        return itemID
    }
    
}
