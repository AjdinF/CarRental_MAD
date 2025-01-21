import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var isAdmin: Bool = false
    @State private var isUser: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Enter your E-Mail", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal)

                SecureField("Enter your Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                if showError {
                    Text("Invalid Credentials")
                        .foregroundColor(.red)
                }
                
                NavigationLink(destination: AdminCarListView(), isActive: $isAdmin) {
                    EmptyView()
                }
                
                NavigationLink(destination: UserCarListView(currentUser: email), isActive: $isUser) {
                    EmptyView()
                }

                Button("Submit") {
                    login()
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding()
        }
    }

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            showError = true
            return
        }

        showError = false

        if email == "admin" && password == "admin" {
            isAdmin = true
        } else if email == "user1" && password == "user1" {
            isUser = true
        } else if email == "user2" && password == "user2" {
            isUser = true
        } else {
            showError = true
        }
    }
}
