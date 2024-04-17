import SwiftUI

struct ChatView: View {
    @State private var messages: [Message] = []
    @State private var newMessage: String = ""
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages, id: \.id) { message in
                            if message.isUser {
                                HStack {
                                    Spacer()
                                    Text(message.text)
                                        .padding(8)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            } else {
                                HStack {
                                    Text(message.text)
                                        .padding(8)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .transition(.slide)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                HStack {
                    TextField("What are you going to eat today?", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: sendMessage) {
                        Text("Send")
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationBarTitle("VeggieChat")
            .navigationBarItems(trailing:
                Button(action: {
                    showingAddView.toggle()
                }) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.green)
                }
            )
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
    }
    
    private func sendMessage() {
        if !newMessage.isEmpty {
            // Display user's message
            messages.append(Message(text: newMessage, isUser: true))
            
            // Clear input field
            newMessage = ""
            
            // Add a typing animation (delayed message)
            messages.append(Message(text: "...", isUser: false))
            
            // Simulate typing delay (adjust as needed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                messages.removeLast() // Remove the typing animation
                let recipe = getRandomRecipe()
                messages.append(Message(text: recipe, isUser: false))
                
                // Hide keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    private func getRandomRecipe() -> String {
        let recipes = [
            "Vegan Lentil Soup\n\nIngredients:\n- 1 cup red lentils\n- 1 onion, chopped\n- 2 carrots, diced\n- 3 cloves garlic, minced\n- 4 cups vegetable broth\n- 1 tsp cumin\n- Salt and pepper to taste\n\nInstructions:\n1. Rinse lentils and set aside.\n2. Sauté onion, carrots, and garlic in a pot until softened.\n3. Add lentils, vegetable broth, cumin, salt, and pepper. Bring to a boil.\n4. Reduce heat, cover, and simmer for 20-25 minutes.\n5. Serve hot with crusty bread.\n\nApproximate Calories: 250",
            "Quinoa Salad with Avocado\n\nIngredients:\n- 1 cup cooked quinoa\n- 1 ripe avocado, diced\n- 1 cucumber, chopped\n- 1 red bell pepper, diced\n- Handful of fresh cilantro, chopped\n- Juice of 1 lemon\n- Salt and pepper to taste\n\nInstructions:\n1. Mix all ingredients in a bowl.\n2. Drizzle with lemon juice and season with salt and pepper.\n3. Chill in the refrigerator for 30 minutes before serving.\n\nApproximate Calories: 300",
            "Chickpea and Spinach Curry\n\nIngredients:\n- 1 can chickpeas, drained and rinsed\n- 1 onion, chopped\n- 2 cloves garlic, minced\n- 1 tsp curry powder\n- 1 tsp ground cumin\n- 1 tsp ground coriander\n- 1 can coconut milk\n- 2 cups fresh spinach\n- Salt and pepper to taste\n\nInstructions:\n1. Sauté onion and garlic in a pan until fragrant.\n2. Add chickpeas, curry powder, cumin, and coriander. Stir well.\n3. Pour in coconut milk and simmer for 10 minutes.\n4. Add spinach and cook until wilted.\n5. Season with salt and pepper.\n6. Serve over rice or with naan bread.\n\nApproximate Calories: 400"
        ]
        
        return recipes.randomElement() ?? "No recipe found."
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
