//
//  DataController.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    
    var container: NSPersistentContainer
    
    init(name: String){
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Load error \(error.localizedDescription)")
            }
        }
    }
}

