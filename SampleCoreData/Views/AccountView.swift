import SwiftUI

struct AccountView: View {
    @State var vegetarianMode: Bool = false
    @State var notificationToggle: Bool = false
    @State var locationUsage: Bool = false
    @State var username: String = "James"
    @State var selectedCurrency: Int = 0
    @State var currencyArray: [String] = ["$ US Dollar", "£ GBP", "€ Euro"]
    
    var body: some View {
        GeometryReader { g in
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
                    Section(header: Text("Personal Information")) {
                        NavigationLink(destination: ProfileView()) {
                            Text("Profile Information")
                        }
                    }
                    
                    Section(footer: Text("Allow push notifications to get latest travel and equipment deals")) {
                        Toggle(isOn: self.$locationUsage) {
                            Text("Location Usage")
                        }
                        Toggle(isOn: self.$vegetarianMode) {
                            Text("Vegetarian Mode")
                        }
                        Toggle(isOn: self.$notificationToggle) {
                            Text("Notifications")
                        }
                    }
                }
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .navigationBarTitle("Account")
            }
        }
    }
}
