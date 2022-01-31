//
//  DataController.swift
//  Bookworm
//
//  Created by Michael Wolf on 1/30/22.
//

import CoreData
import SwiftUI

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
