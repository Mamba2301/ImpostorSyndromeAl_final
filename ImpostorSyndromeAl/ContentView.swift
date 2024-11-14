//
//  ContentView.swift
//  ImpostorSyndromeAl
//
//  Created by Alessandra Di Rosa on 13/11/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var currentDate = Date() 
    @State private var showPopover: Bool = false
    @State private var inputText: String = ""
    @State private var navigateToMainView: Bool = false
    
    private var months: [String] {
        let formatter = DateFormatter()
        return formatter.monthSymbols
    }
    
    private var currentMonthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: currentDate)
    }
    
    private var currentYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: currentDate)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.pink)
                    }
                    
                    Text("\(currentMonthName) \(currentYear)")
                        .bold()
                        .font(.title)
                        .frame(width: 250, alignment: .center)
                    
                    Button(action: {
                        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20))
                            .foregroundColor(.pink)
                    }
                }
                
                Spacer()
                
                Text("Start reframing\n your first thoughts!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    Button("Add Thoughts", systemImage: "plus.circle.fill") {
                        showPopover.toggle()
                    }
                    .foregroundStyle(.pink)
                    .font(.system(size: 20))
                    .popover(isPresented: $showPopover) {
                        PopOverView(showPopover: $showPopover, input: $inputText, navigateToMainView: $navigateToMainView)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
            }
            .padding(.top, 20)
            .navigationDestination(isPresented: $navigateToMainView) {
                MainView(input: $inputText)
            }
        }
    }
}
#Preview {
    ContentView()
}
