//
//  UserCellViewModel.swift
//  GitUsers
//
//  Created by A.Stelmakh on 10.07.2023.
//

import Foundation

class UserCellViewModel: ObservableObject {
    
    func addImage(user: User, data: Data) {
        user.imageData = data
        do {
            try user.managedObjectContext?.save()
            print("DataImage add \(String(describing: user.login))")
        } catch {
            print("DataImage add error: \(error.localizedDescription)")
        }
    }
}

