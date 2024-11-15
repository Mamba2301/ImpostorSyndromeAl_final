import SwiftUI

// Struttura del pensiero (Thought)
struct Thought: Identifiable {
    var id = UUID()
    var text: String
    var date: Date
}


struct ContentView: View {
    @State private var currentDate = Date()
    @State private var showPopover: Bool = false
    @State private var input: String = ""
    @State private var navigateToMainView: Bool = false
    @State private var thoughts: [Thought] = []
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

    private var filteredThoughts: [Thought] {
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: currentDate))!
        let endOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth)!.addingTimeInterval(-1)
        
        return thoughts.filter { thought in
            thought.date >= startOfMonth && thought.date <= endOfMonth
        }
        .filter { thought in
            searchText.isEmpty || thought.text.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Barra di ricerca
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
                .padding(.top, 10)
                
                
                VStack {
                    Spacer()
                    Text("Start reframing\n your first thoughts!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                }
                
                List {
                    ForEach(filteredThoughts) { thought in
                        VStack(alignment: .leading) {
                            Text("\(currentMonthName) \(currentYear)")
                                .font(.headline)
                            Text(thought.text)
                            Divider()
                            HStack {
                                Text("\(currentMonthName) \(currentYear)")
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "ellipsis")
                                }
                            }
                        }
                    }
                }

                Spacer()
                
                
                HStack {
                    Button(action: {
                        showPopover.toggle()
                    }) {
                        Label("Add Thoughts", systemImage: "plus.circle.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.pink)
                    }
                    .popover(isPresented: $showPopover) {
                        PopOverView(
                            input: $input,
                            arrayInput: $thoughts, 
                            showPopover: $showPopover,
                            navigateToMainView: $navigateToMainView
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
            }
            .padding(.top, 2)
            .navigationTitle("Reflecta")
            .navigationDestination(isPresented: $navigateToMainView) {
                MainView(
                    input: $input,
                    arrayInput: $thoughts
                )
            }
        }
    }
}

#Preview {
    ContentView()
}

