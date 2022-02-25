//
//  Integration .swift
//  Overlap Integral 1s Orbitals
//
//  Created by Alaina Thompson on 2/24/22.
//

import Darwin
import SwiftUI

class Integration: NSObject,ObservableObject {
    
    let e = Darwin.M_E
    var atomicSpacing = 1.0
    //a = bohr radius (angstroms)
    var a = 0.529177
    var n = 0.0
    var r_a = 0.0
    var r_b = 0.0
    var sum = 0.0
    // h = stepsize
    var h = 0.001
    var point = 0.0
    var rightPoint = 0.0
    var midPoint = 0.0
    var x_pos = 0.0
    @Published var I = 0.0
    @Published var IText = ""
    @Published var RString = "0.0"
    @Published var enableButton = true
    
    
    
    
    
    
    
    func initWithIntegration(r_a: Double, r_b: Double) async -> Bool {
           
                
                let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                    
            
                
                    taskGroup.addTask { let _ = await self.psi(r_a: self.r_a, r_b: self.r_b)}
                    taskGroup.addTask { let _ = await self.integrate(r_a: self.r_a, r_b: self.r_b)}
            }
                
                await setButtonEnable(state: true)
                                                     
           
            

            return true
            
        }
    
    

    
    
    
    
    
    
    
    
    
    func psi(r_a: Double, r_b: Double) -> Double {
        
        return pow(e, -r_a/a)*pow(e, -r_b/a)
        
    }
    
    func integrate(r_a: Double, r_b: Double) -> Double {
        
        while rightPoint < atomicSpacing {
        
        
            rightPoint += point + h
            midPoint = point + h/2
            x_pos = psi(r_a: midPoint, r_b: midPoint)
            sum += x_pos*h
        
            point += point + h
        
        }
        I = 2*Double.pi*Double.pi*sum
        return sum
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
           
          
    
    
    
}
