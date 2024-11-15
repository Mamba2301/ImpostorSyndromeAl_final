import SwiftUI

struct PopOverView: View {
    @State private var rotateImage = false
    @State private var showSaveMode = false
    @Binding var input: String
    @Binding var arrayInput: [Thought]
    @Binding var showPopover: Bool
    @Binding var navigateToMainView: Bool
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let day = formatter.string(from: Date())
        
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: Date())
        
        return "\(day) \(month)"
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(formattedDate)
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                Spacer()
                
                Button("Cancel") {
                    showPopover.toggle()
                }
                .foregroundStyle(Color.red)
                .padding(.trailing)
            }
            .padding(.top)
            
            Divider()
            
            ZStack {
                if !showSaveMode {
                    Image("Image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.top, -8)
                        .rotationEffect(.degrees(rotateImage ? -15 : 15))
                        .offset(x: rotateImage ? 20 : -20)
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                            value: rotateImage
                        )
                        .onAppear {
                            rotateImage.toggle()
                        }
                }
                
                if showSaveMode {
                    Image("Image2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.top, -8)
                        .rotationEffect(.degrees(rotateImage ? -15 : 15))
                        .offset(x: rotateImage ? 20 : -20)
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                            value: rotateImage
                        )
                        .onAppear {
                            rotateImage.toggle()
                        }
                }
            }
            
            Text("WHAT'S ON YOUR MIND?")
                .bold()
                .font(.title)
                .padding(.top, 20)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $input)
                    .autocapitalization(.none)  // Disabilita la capitalizzazione automatica
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.pink, lineWidth: 2)
                    )
                    .foregroundColor(.secondary)
                    .frame(width: 300, height: 200)
                
                if input.isEmpty {
                    Text("Type here...")
                        .foregroundColor(.secondary)
                        .padding(.top, 25)
                        .padding(.leading, 20)
                }
            }
            
            Spacer()
            
            if !showSaveMode {
                Button(action: {
                    if !input.isEmpty {
                        showSaveMode = true
                    }
                }) {
                    Text("Reframe")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.pink)
                .foregroundStyle(Color.white)
                .bold()
                .disabled(input.isEmpty)
            }
            else {
                VStack {
                    Button(action: {
                        if !input.isEmpty {
                            let newThought = Thought(text: input, date: Date())
                            arrayInput.append(newThought)
                            input = ""
                            navigateToMainView = true
                            showPopover.toggle()
                        }
                    }) {
                        Text("Save")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                    .tint(.pink)
                    .foregroundStyle(Color.white)
                    .bold()
                    .disabled(input.isEmpty)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct PopOverView_Previews: PreviewProvider {
    @State static var input: String = ""
    @State static var arrayInput: [Thought] = []
    @State static var showPopover: Bool = true
    @State static var navigateToMainView: Bool = false
    
    static var previews: some View {
        PopOverView(
            input: $input,
            arrayInput: $arrayInput,
            showPopover: $showPopover,
            navigateToMainView: $navigateToMainView
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

