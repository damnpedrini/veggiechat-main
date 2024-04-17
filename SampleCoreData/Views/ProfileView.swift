import SwiftUI

struct ProfileView: View {
    @State private var username: String = "Pedrini"
    @State private var email: String = "Pedrini@example.com"
    @State private var selectedCurrencyIndex: Int = 0

    var body: some View {
        GeometryReader { geo in
            VStack {
                Image("ProfileImage")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
                Text("Pedrini")
                    .font(.system(size: 20))

                Form {
                    Section(header: Text("PERSONAL INFORMATION")) {
                        TextField("Nome de Usuário", text: $username)
                        TextField("Email", text: $email)
                            }
                        
                    }
                }
            }
        }
    }

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
