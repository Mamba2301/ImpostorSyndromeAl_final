//
//  MainView.swift
//  ImpostorSyndromeAl
//
//  Created by Alessandra Di Rosa on 13/11/24.
//



import SwiftUI


struct MainView: View {
    @State private var currentDate = Date()
    @State private var showPopover: Bool = false
    @Binding var input: String
    @Binding var arrayInput: [String]
    
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
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: currentDate)
    }
    
    var body: some View {
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
            
            List {
                ForEach(arrayInput, id: \.self) { thought in
                    VStack(alignment: .leading) {
                        Text("\(currentMonthName) \(currentYear)")
                            .font(.headline)
                        Text(thought)
                        Divider()
                        HStack {
                            Text("\(currentMonthName) \(currentYear)")
                            Spacer()
                            Button("", systemImage: "ellipsis") {
                                
                        }
                    }
                }
            }
        }
        
        Spacer()
        
        HStack {
            Button("Add Thoughts", systemImage: "plus.circle.fill") {
                showPopover.toggle()
            }
            .foregroundStyle(.pink)
            .font(.system(size: 20))
            .popover(isPresented: $showPopover) {
                PopOverView(
                    input: $input,
                    arrayInput: $arrayInput,
                    showPopover: $showPopover,
                    navigateToMainView: .constant(true)
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 40)
        .navigationBarBackButtonHidden(true)
    }
        .padding(.top, 20)
}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(input: .constant(""), arrayInput: .constant([]))
    }
}
