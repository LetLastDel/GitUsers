//
//  MainViewModel.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import Foundation
import CoreData

class MainViewModel: ObservableObject {
    private var dataController = DataController(name: "Model")
    @Published var usersList = [User]()
    
    init(){
        fetchData()
        Task{
           await addData()
        }
    }
    func fetchData() {
        let request = NSFetchRequest<User>(entityName: "User")
        do{
            usersList = try dataController.container.viewContext.fetch(request)
        } catch {
            print("Fetch data error \(error.localizedDescription)")
        }
    }
    func addData() async {
        do {
            let userList = try await NetworkService.shared.getUs(user: "", repos: "") as [UserListModel]
            
            DispatchQueue.main.async {
                let context = self.dataController.container.viewContext
                
                for user in userList {
                    if !self.usersList.contains(where: { $0.id == user.id }) {
                        let newUser = User(context: context)
                        newUser.id = Int64(user.id)
                        newUser.avatar = user.avatarUrl
                        newUser.login = user.login
                        newUser.url = user.url
                        self.usersList.append(newUser)
                    } else {
                        if let bdUser = self.usersList.first(where: { $0.id == user.id }) {
                            self.updUser(user: bdUser, userModel: user)
                            print("In coreData")}
                    }
                    self.save()
                    self.fetchData()
                }
            }
        } catch {
            print("Data save error \(error.localizedDescription)")
        }
    }
    func updUser(user: User,  userModel: UserListModel) {
        var needsUpdate = false
        if user.avatar != userModel.avatarUrl {
            user.avatar = userModel.avatarUrl
            needsUpdate = true
        }
        if user.login != userModel.login {
            user.login = userModel.login
            needsUpdate = true
        }
        if user.url != userModel.url {
            user.url = userModel.url
            needsUpdate = true
        }
        if needsUpdate {
            print("updated \(String(describing: user.login))")
            save()
        }
    }
    func save(){
        try? dataController.container.viewContext.save()
    }
}
