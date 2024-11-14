//
//  File.swift
//  ImpostorSyndromeAl
//
//  Created by Alessandra Di Rosa on 13/11/24.
//
import SwiftUI

// PopOverView
struct PopOverView: View {
    @Binding var showPopover: Bool
    @Binding var input: String
    @Binding var navigateToMainView: Bool
    
    
    @State private var rotateImage = false
    
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let day = formatter.string(from: Date())
        
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: Date())
        
        return "\(day) \(month)"
    }
    
    var body: some View {
        NavigationStack {
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
                
                
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding(.top, 10)
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
                
                Text("WHAT'S ON YOUR MIND?")
                    .bold()
                    .font(.title)
                    .padding(.top, 20)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $input)
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
                
                Button("Reframe") {
                    showPopover.toggle()
                    navigateToMainView = true
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.pink)
                .foregroundStyle(Color.white)
                .bold()
                .disabled(input.isEmpty)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PopOverView_Previews: PreviewProvider {
    static var previews: some View {
        
        PopOverView(showPopover: .constant(true), input: .constant(""), navigateToMainView: .constant(false))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


