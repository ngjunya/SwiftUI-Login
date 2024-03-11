//
//  login_view.swift
//  swiftUI
//
//  Created by jun ya Ng  on 03/08/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowPassword = false
    // MARK: - Content
    var body: some View {
        VStack(spacing: 16) {
            Image("logo")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .topTrailing)
            Text("Welcome back")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing], 16)
            VStack {
                TextField("Username", text: $email)
                    .padding()
                    .frame(height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                Spacer()
                    .frame(height: 15)
                ZStack(alignment: .trailing) {
                    if isShowPassword {
                        TextField("Password", text: $password)
                            .padding()
                            .frame(height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                    } else {
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                    }
                    Image(systemName: isShowPassword ? "eye" : "eye.slash" )
                        .foregroundColor(.gray)
                        .padding()
                        .onTapGesture {
                            isShowPassword.toggle()
                        }
                }
                Spacer().frame(height: 20)
                Button(action: {
                    viewModel.onViewEvent(event: .onLoginTaped(email: email, password: password))
                }, label: {
                    if viewModel.state.isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                    }
                })
                .frame(height: 50)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .contentShape(Rectangle())
                .background(Color(hex: 0xEB4F38))
                .foregroundColor(.white)
                .cornerRadius(8)
            }.padding()
            Text("Forget Password ?")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 35)
            Text("Or Login with")
            HStack {
                Image("facebook")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 45, height: 45, alignment: .topTrailing)
                Spacer().frame(width: 30)
                Image("google")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 45, height: 45, alignment: .topTrailing)
                Spacer().frame(width: 30)
                Image("apple")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 45, height: 45, alignment: .topTrailing)
            }
        } //: VStack
        .onReceive(viewModel.event) { event in
            switch event {
            case .onError(let message):
                print(message)
            case .onSuccess:
                print("Success")
            }
        }
    } //: body
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
