//
//  UserCell.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import SwiftUI

struct UserCell: View {
    var user: User
    
    @StateObject var viewModel = UserCellViewModel()
    @State var image: UIImage = UIImage(systemName: "person")!
    
    var body: some View {
        HStack{
            Image(uiImage: UIImage(data: user.imageData ?? Data()) ?? image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80)
                .cornerRadius(15)
            Spacer()
            Text(user.login ?? "Error")
                .font(.title).bold()
                .foregroundColor(.white)
        }
        .onAppear{
            Task{
                let img = try await NetworkService.shared.downloadImageData(url: user.avatar ?? "")
                DispatchQueue.main.async {
                    viewModel.addImage(user: user, data: img)
                }
            }
        }
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(Color("userCol"))
        .cornerRadius(20)
        .shadow(color: .green, radius: 1, x: 0, y: 0)
    }
}

//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell()
//    }
//}
