import SwiftUI

struct ShoppingListView: View {
    @State private var items: [ShoppingItem] = []

    let categories = ["Fruits", "Vegetables", "Snacks", "Drinks"]

    var groupedItems: [String: [ShoppingItem]] {
        Dictionary(grouping: items, by: { $0.category })
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(categories, id: \.self) { category in
                        Section(header: Text(category)
                            .font(.headline)
                            .foregroundColor(.brown)) {
                            if let categoryItems = groupedItems[category] {
                                ForEach($items) { $item in
                                    if item.category == category {
                                        HStack {
                                            Button(action: {
                                                togglePurchased(for: item)
                                            }) {
                                                Image(systemName: item.isPurchased ? "checkmark.square.fill" : "square")
                                                    .foregroundColor(item.isPurchased ? .green : .gray)
                                            }
                                            
                                            Text(item.name)
                                                .foregroundColor(.black)
                                                .strikethrough(item.isPurchased, color: .gray)
                                            Spacer()
                                            Text(String(format: "$%.2f", calculateTotalPrice(price: item.price, taxRate: item.tax)))
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Shopping List")
                
                NavigationLink(destination: AddItemView(items: Binding(get: { items }, set: { newItems in
                    items = newItems
                    saveItems()
                }))) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Item")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            loadItems()
        }
    }

    func calculateTotalPrice(price: Double, taxRate: Double) -> Double {
        return price + (price * taxRate)
    }

    func togglePurchased(for item: ShoppingItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isPurchased.toggle()
            
            if items[index].isPurchased {
                let itemId = items[index].id
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    removeItemIfStillPurchased(id: itemId)
                }
            }
        }
    }

    func removeItemIfStillPurchased(id: UUID) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            if items[index].isPurchased { 
                items.remove(at: index)
                saveItems()
            }
        }
    }

    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "shoppingItems")
        }
    }

    func loadItems() {
        if let savedData = UserDefaults.standard.data(forKey: "shoppingItems"),
           let decodedItems = try? JSONDecoder().decode([ShoppingItem].self, from: savedData) {
            items = decodedItems
        }
    }
}



