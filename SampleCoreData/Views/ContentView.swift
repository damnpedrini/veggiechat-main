import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("\(Int(totalCaloriesToday())) KCal (Today)")
                        .foregroundColor(.gray)
                        .padding([.horizontal])
                    List {
                        ForEach(food) { food in
                            NavigationLink(destination: EditFoodView(food: food)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(food.name!)
                                            .bold()
            
                                        Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                                    }
                                    Spacer()
                                    Text(calcTimeSince(date: food.date!))
                                        .foregroundColor(.gray)
                                        .italic()
                                }
                            }
                        }
                        .onDelete(perform: deleteFood)
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("iCalories")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddView.toggle()
                        } label: {
                            Label("Add food", systemImage: "plus.circle")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddFoodView()
                }
            }
            .navigationViewStyle(.stack) 
            .tabItem {
                Label("iCalories", systemImage: "heart.fill")
            }
            .tag(0)
            
            ChatView()
                .tabItem {
                    Label("VeggieChat", systemImage: "leaf.fill")
                }
                .tag(1)
            
            NavigationView {
                AccountView()
            }
            .tabItem {
                Label("Account", systemImage: "person")
            }
            .tag(2)
        }
        .edgesIgnoringSafeArea(.all)
        .accentColor(.green)
    }
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }
                .forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        print("Calories today: \(caloriesToday)")
        return caloriesToday
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
