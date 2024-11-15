import SwiftUI

struct MainView: View {
    @State private var currentDate = Date()
    @State private var showPopover: Bool = false
    @Binding var input: String
    @Binding var arrayInput: [Thought]  
    @State private var searchText: String = ""
    
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
    
    private var filteredArrayInput: [Thought] {
        if searchText.isEmpty {
            return arrayInput
        } else {
            return arrayInput.filter { $0.text.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search Thoughts", text: $searchText)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 16)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay(
                            HStack {
                                Spacer()
                                if !searchText.isEmpty {
                                    Button(action: {
                                        searchText = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.trailing, 8)
                                }
                            }
                        )
                }
                .padding(.top, 10)
                
                
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
                    
                    ForEach(filteredArrayInput) { thought in
                        VStack(alignment: .leading) {
                            
                            Text("\(currentMonthName) \(currentYear)")
                                .font(.headline)
                            
                            
                            Text(thought.text)
                                .padding(.vertical, 5)
                            
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
            
            .padding(.top,2)
            .navigationTitle("Reflecta")
        }
    
    }
}

