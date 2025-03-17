//
//  LaunchScreenView.swift
//  ShoppingList

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("shopping-list")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                Text("Shopping List App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Merve Coskun 101191047")
                    Text("Manya Khullar 101410731")
                    Text("Roda Issa 101408170")
                }
                .font(.headline)
                .padding()
                
                NavigationLink(destination: ShoppingListView()) {
                    Text("Next")
                        .padding()
                        .frame(width: 150)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

