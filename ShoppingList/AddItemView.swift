import SwiftUI

struct AddItemView: View {
    @Binding var items: [ShoppingItem]
    @Environment(\.presentationMode) var presentationMode

    let categories = ["Fruits", "Vegetables", "Snacks", "Drinks"]

    @State private var name: String = ""
    @State private var selectedCategory: String = "Fruits"
    @State private var price: String = ""
    @FocusState private var isNameFieldFocused: Bool

    let taxRate: Double = 0.13

    var body: some View {
        VStack {
            TextField("Item name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .focused($isNameFieldFocused) // Make sure text field gets focus

            Picker("Select Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add") {
                if let priceValue = Double(price) {
                    let newItem = ShoppingItem(name: name, category: selectedCategory, price: priceValue, tax: taxRate)
                    items.append(newItem)
                    saveItems()
                    clearFields()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("Add Item")
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Slight delay to ensure view is fully loaded
                isNameFieldFocused = true
            }
        }
    }

    func clearFields() {
        name = ""
        price = ""
    }

    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "shoppingItems")
        }
    }
}


