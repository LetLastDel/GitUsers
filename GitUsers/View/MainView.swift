//
//  MainView.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var isDragging = false

    var body: some View {
            VStack{
                HStack{
                    Text("Git Users")
                        .font(.title).bold()
                        .foregroundColor(.white)
                    Button {
                        Task{
                            await viewModel.addData()
                        }
                        viewModel.fetchData()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                    }
                }
                List{
                    ForEach(viewModel.usersList, id: \.id) { user in
                        NavigationLink {
                            UserInfoView(viewModel: UserInfoViewModel(user: user))
                        } label: {
                            UserCell(user: user)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .listRowBackground(Color.clear)
                    
                }.listStyle(.plain)
                
            }
        .background(Color("gitColor"))
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
