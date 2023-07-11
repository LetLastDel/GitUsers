//
//  UserInfoViewModel.swift
//  GitUsers
//
//  Created by A.Stelmakh on 7.07.2023.
//

import Foundation
import CoreData
import UIKit

class UserInfoViewModel: ObservableObject {
    @Published var user: User
    @Published var reload = false

    private var dataController = DataController(name: "Model")
    
    init(user: User){
        self.user = user
            Task{
                await getUserInfo(user: user)
            }
    }
    func getRepos(user: User, userInfo: UserInfo) async {
        guard let userM = user.login else { return }
        do {
            let fetchRepos = try await NetworkService.shared.getUs(user: userM, repos: "repos") as [ReposModel]
            print("Recieve repos")
            DispatchQueue.main.async {
                    if let context = userInfo.managedObjectContext {
                        let _ = fetchRepos.map { reposModel in
                            let repos = Repos(context: context)
                            repos.id = Int64(reposModel.id ?? 0)
                            repos.archieved = reposModel.archived ?? false
                            repos.descripti = reposModel.description ?? ""
                            repos.language = reposModel.language ?? ""
                            repos.name = reposModel.name ?? ""
                            repos.url = reposModel.url ?? ""
                            userInfo.addToReposit(repos)
                        }
                        do {
                            try context.save()
                                self.reload.toggle()
                            print("Repos saved")
                        } catch {
                            print("Repos save error: \(error.localizedDescription)")
                        }
                    }
            }
        } catch {
            print("Repos recieve error: \(error.localizedDescription)")
        }
    }

    func getUserInfo(user: User) async {
        guard let userUrl = user.login else { return }
        do{
            let fetchUser = try await NetworkService.shared.getUs(user: userUrl, repos: "") as [UserInfoModel]
            print("Recieve userInfo")
            DispatchQueue.main.async {
                if user.getUser.isEmpty{
                    if let context = user.managedObjectContext {
                        let userInfo = UserInfo(context: context)
                        let _ = fetchUser.map { UserInfoModel in
                            userInfo.ava = UserInfoModel.avatarUrl
                            userInfo.company = UserInfoModel.company
                            userInfo.email = UserInfoModel.email
                            userInfo.location = UserInfoModel.location
                            userInfo.name = UserInfoModel.name
                            userInfo.id = UUID()
                            userInfo.logi = UserInfoModel.login
                            userInfo.repos = UserInfoModel.reposUrl
                            user.addToUserinfo(userInfo)
                            do {
                                try context.save()
                                print("UserInfo Saved")
                                Task{
                                   await self.getRepos(user: user, userInfo: userInfo)
                                }
                            } catch {
                                print("UserInfo not saved: \(error.localizedDescription)")
                            }
                        }
                    }
                } else {
                    self.cgangeDB(user: user)
                }
            }
        } catch {
            print("Failed to recieve userInfo: \(error.localizedDescription)")
        }
    }
    func cgangeDB(user: User) {
        guard let userInfo = user.getUser.first else { return }
        userInfo.ava = userInfo.ava
        userInfo.company = userInfo.company
        userInfo.email = userInfo.email
        userInfo.location = userInfo.location
        userInfo.name = userInfo.name
        userInfo.id = userInfo.id
        userInfo.logi = userInfo.logi
        userInfo.repos = userInfo.repos
        do {
            try userInfo.managedObjectContext?.save()
            print("DB changed")
        } catch {
            print("DB change error: \(error.localizedDescription)")
        }
    }
}

