//
//  ContentView.swift
//  CustomGrid
//
//  Created by Christopher on 2021-06-19.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

struct ContentView: View {
    
    let items = [
        Item(title: "Home", image: "home"),
        Item(title: "Money", image: "money"),
        Item(title: "Bank", image: "bank"),
        Item(title: "Vacation", image: "vacation"),
        Item(title: "User", image: "user"),
        Item(title: "Charts", image: "charts"),
        Item(title: "Support", image: "support"),
    ]
    
    let spacing: CGFloat = 10
    @State private var numberOfColumns = 3
    
    var body: some View {
        
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
                
        ScrollView {
            
            headerView

            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(items) { item in
                    Button(action: {}) {
                        ItemView(item: item)
                    }
                    .buttonStyle(ItemButtonStyle(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
            .offset(y: -50)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
    
    var headerView: some View {
        VStack {
            Image("avatar")
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .onTapGesture {
                    numberOfColumns = numberOfColumns % 3 + 1
                }
            Text("Christopher Lundqvist")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .medium, design: .rounded))
            
            Text("To be the best, you've gotta beat the best")
                .foregroundColor(Color.white.opacity(0.8))
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(Color.purple)
    }
}

struct ItemButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        GeometryReader { reader in
            
            let fontSize = min(reader.size.width * 0.2, 28)
            let imageWidth: CGFloat = min(50, reader.size.width * 0.6)
            
            VStack(spacing: 5) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth)
                
                Text(item.title)
                    .font(.system(size: fontSize, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height: 150)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
