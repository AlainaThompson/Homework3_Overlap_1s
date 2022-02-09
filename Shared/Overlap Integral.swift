//
//  Overlap Integral.swift
//  Overlap Integral 1s Orbitals
//
//  Created by Alaina Thompson on 2/4/22.
//
import Darwin
import SwiftUI

class OverlapInt: NSObject,ObservableObject {
  
    let e = Darwin.M_E
    var atomicSpacing = 0.0
    var a = 0.529177
    var n = 0.0
    @Published var S = 0.0
    @Published var SText = ""
    @Published var RString = "0.0"
    @Published var enableButton = true
    
    



  
    
    
    
    
    func initWithOverlap(R: Double) async -> Bool {
            // a and R are in angstroms
            atomicSpacing = R
                
                let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                    
            
                
                    taskGroup.addTask { let _ = await self.calculateS(R: self.atomicSpacing)}
                    
            }
                
                await setButtonEnable(state: true)
                                                     
           
            

            return true
            
        }
    
    
    
    
    func calculateS(R: Double) async -> Double {
        
    
        //          - R /  a                   2
        //                  o         R       R
        // S(R)  =   e       (1 +   ---- +  -----)
        //                           a         2
        //                            o     3 a
        //
        n = R/a
        let exp = pow(e, -n)
        let frac1 = n
        let frac2 = pow(n, 2)/3
                
        let calculatedS = exp*(1 + frac1 + frac2)
        let newSText = String(format: "%7.5f", calculatedS)
        
        await updateS(STextString: newSText)
        await newSValue(SValue: calculatedS)
               
        return calculatedS
               
    }
    
    
    
    
    
    
    
    
    @MainActor func setButtonEnable(state: Bool){
               
               
               if state {
                   
                   Task.init {
                       await MainActor.run {
                           
                           
                           self.enableButton = true
                       }
                   }
                   
                   
                       
               }
               else{
                   
                   Task.init {
                       await MainActor.run {
                           
                           
                           self.enableButton = false
                       }
                   }
                       
               }
               
           }
           
          
           @MainActor func updateS(STextString: String){
               
               SText = STextString
               
           }
           
           @MainActor func newSValue(SValue: Double){
               
               self.S = SValue
               
           }
           

    
    
    
    
    
    
}
