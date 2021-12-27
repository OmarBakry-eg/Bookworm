//
//  Data Controller.swift
//  Bookworm
//
//  Created by Omar Bakry on 26/12/2021.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
