//
//  ContentView.swift
//  Shared
//
//  Created by Alaina Thompson on 2/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var SModel = OverlapInt()
    @ObservedObject private var IModel = Integration()
    @State var RString = "1.0"

    
    var body: some View {
        
        
        VStack{
                  Text("Atomic Spacing [Å]")
                      .padding(.top,25)
                      .padding(.bottom, 0)
                  TextField("Enter R value [Å]", text: $RString, onCommit: {Task.init {await self.calculateOverlapInt()}})
                      .padding(.horizontal)
                      .frame(width: 100)
                      .padding(.top, 0)
                      .padding(.bottom, 30)
                  
                  
                
                  
                  
                  
                  HStack {
                      VStack{
                  Text("Overlap Integral")
                      .padding(.bottom, 0)
                  TextField("", text: $SModel.SText)
                      .padding(.horizontal)
                      .frame(width: 100)
                      .padding(.top, 0)
                      .padding(.bottom,30)
                  
                        
                          
                          
              }
              VStack{
                  Text("Overlap Integral")
                      .padding(.bottom, 0)
                  Text("\(SModel.S, specifier: "%.2f")")
                      .padding(.horizontal)
                      .frame(width: 100)
                      .padding(.top, 0)
                      .padding(.bottom,30)
             VStack{
                    Text("Integrated")
                        .padding(.bottom, 0)
                    Text("\(IModel.I, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                     
                  }
                  
                  
                  }
                  
                  }
                    
                  
                  Button("Calculate", action: {Task.init { await self.calculateOverlapInt() }})
                      .padding(.bottom)
                      .padding()
                      .disabled(SModel.enableButton == false)
                      
                  
                  
              }
              
    }
              
          func calculateOverlapInt() async {
              
              SModel.setButtonEnable(state: false)
              
              let _ : Bool = await SModel.initWithOverlap(R: Double(RString)!)
              
          }
        
        
        
        
        
        
        
        
        


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    }


}
