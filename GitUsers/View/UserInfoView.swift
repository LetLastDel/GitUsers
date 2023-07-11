//
//  UserInfoView.swift
//  GitUsers
//
//  Created by A.Stelmakh on 7.07.2023.
//

import SwiftUI
import UIKit

struct UserInfoView: View {
    @StateObject var viewModel: UserInfoViewModel
    @State var image: UIImage = UIImage(systemName: "person")!

    
    var body: some View {
        VStack{
            if !viewModel.user.getUser.isEmpty {
                ForEach(viewModel.user.getUser) { ig in
                    VStack{
                        HStack{
                            Image(uiImage: UIImage(data: viewModel.user.imageData!) ?? image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 110)
                                .cornerRadius(10)
                            Spacer()
                            VStack(alignment: .trailing,spacing: 10){
                                Text("Git login: \(ig.logi ?? "")")
                                    .bold()
                                Text("Name: \(ig.name ?? "User not add name")")
                                Text("Email: \(ig.email ?? "User not add email")")
                                Text("City: \(ig.location ?? "User not add city")")
                            }
                        }
                        .padding(.trailing, 8)
                        .frame(maxWidth: .infinity)
                        .background(Color("userCol"))
                        .cornerRadius(10)
                        .shadow(color: .green, radius: 1, x: 0, y: 0)
                    }
                }
                .padding()
                Text("Repositories:")
                VStack{
                    List {
                        ForEach(Array(viewModel.user.getUser ), id: \.self) { repos in
                            ForEach(repos.getRepod) { userRep in
                                VStack(alignment: .leading){
                                    Text(userRep.name ?? "")
                                        .bold()
                                    Text("Description: \(userRep.descripti ?? "No description")")
                                    Text("Language: \(userRep.language ?? "Language is not selected")")
                                    Text("Git URL: \(userRep.url ?? "")")
                                }
                            }
                            .listRowSeparatorTint(Color.green)
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)

                    }
                    .background(Color("userCol"))
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .shadow(color: .green, radius: 1, x: 0, y: 0)
                    .padding()
                }
            } else {
                ProgressView()
            }
        }
        .onChange(of: viewModel.reload, perform: { V in
            Task{
                await viewModel.getUserInfo(user: viewModel.user)
            }
        })
        .foregroundColor(.white)
        .background(Color("gitColor"))
    }
}

//struct UserInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInfoView()
//    }
//}
