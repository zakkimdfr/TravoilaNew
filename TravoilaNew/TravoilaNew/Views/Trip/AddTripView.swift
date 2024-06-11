//
//  AddTripView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 05/06/24.
//

import SwiftUI

struct AddTripView: View {
    @StateObject private var formAddTrip = FormAddTripViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView(content: {
            VStack(alignment: .center) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 12.64, height: 21.45)
                        Text("Cancel")
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 35, alignment: .leading)
                .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Plan a new trip")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 20
                    )
                Text("Build an itenerary and map ut your\nupcoming travel plans")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.gray)
                
                FormAddTrip(formAddTrip: formAddTrip)
                
                Button(action: {}) {
                    ColoredButtonView(button: "Start Planning")
                        .disabled(!formAddTrip.formIsValid)
                        .opacity(formAddTrip.formIsValid ? 1.0 : 0.5)
                        .padding(.top, 50)
                }
                Spacer()
            }
        })
    }
}

#Preview {
    AddTripView(isPresented: .constant(false))
}

class FormAddTripViewModel: ObservableObject {
    @Published var destination: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    
    var formIsValid: Bool {
        return !destination.isEmpty && !startDate.isEmpty && !endDate.isEmpty
    }
}

struct FormAddTrip: View {
    @ObservedObject var formAddTrip: FormAddTripViewModel
    @State private var isShowed: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundColor(.secondary)
            
            InputView(text: $formAddTrip.destination,
                      title: "Destination",
                      placeholder: "e.g., Japan, Paris, Indonesia",
                      isSecured: false,
                      isShowed: $isShowed)
        }
        .frame(width: UIScreen.main.bounds.width - 35, height: 62)
        .padding()
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundColor(.secondary)
            
            InputView(text: $formAddTrip.startDate,
                      title: "Start Date",
                      placeholder: "When?",
                      isSecured: false,
                      isShowed: $isShowed)
        }
        .frame(width: UIScreen.main.bounds.width - 35, height: 62)
        .padding()
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundColor(.secondary)
            
            InputView(text: $formAddTrip.endDate,
                      title: "End Date",
                      placeholder: "Until?",
                      isSecured: false,
                      isShowed: $isShowed)
        }
        .frame(width: UIScreen.main.bounds.width - 35, height: 62)
        .padding()
    }
}


