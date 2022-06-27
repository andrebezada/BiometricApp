//
//  ContentView.swift
//  BiometricApp
//
//  Created by Andre Bezada on 26/06/22.
//

import SwiftUI
import LocalAuthentication


struct ContentView: View {
    
    @State private var auth = false
    
    var body: some View {
        VStack{
            Text(auth ? "Estás autenticado":"Necesitas autenticarte")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
            Button(auth ? "Cerrar" : "Auntenticar"){
                
                if auth {
                    auth = false
                } else {
                    authentication()
                }
                                
            }.buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .accentColor(.orange)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(auth ? Color.green : Color.red)
    }
    
    private func authentication(){
        
        var error: NSError?
        
        let laContext = LAContext()
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics , error: &error){
            
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Get authenticated using Biometric sensor"){ autenticated, error in
                
                if autenticated{
                    auth = true
                }
                
            }
            
        } else {
            auth = true
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
