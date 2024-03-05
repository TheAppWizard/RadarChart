//
//  ContentView.swift
//  RadarChartSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 03/03/24.
//

import SwiftUI


struct ContentView : View {
      var body: some View {
        FinalView()
    }
}


#Preview {
    ContentView()
}





















struct FinalView: View {
    @State private var fireValue: Double = 3
    @State private var waterValue: Double = 2
    @State private var earthValue: Double = 2
    @State private var airValue: Double = 3
    @State private var lightValue: Double = 2
    @State private var darkValue: Double = 3
    
    let labels: [String] = 
    ["Fire", "Water", "Earth", "Wind", "Light", "Dark"]
    let maxValues: [Double] = [3, 3, 3, 3 , 3, 3]
    let designInterval: Double = 50
    let shapeColor: Color = .orange
    
    var data: [Double] {
        [fireValue, waterValue, earthValue, airValue, lightValue, darkValue]
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(1).edgesIgnoringSafeArea(.all)
            
            Image("wizard")
                .resizable()
                .frame(width: 400)
                .offset(x: 200)
                .opacity(0.1)
            
            ScrollView{
                VStack{
                    HStack{
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(height: 1)
                        Text("STATS")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(height: 1)
                        
                    }.padding()
                    
                    
                    HStack{
                        Image("wizard")
                            .resizable()
                            .frame(width: 150,height: 200)
                        
                        
                    
                        VStack{
                            HStack{
                                Text("The Mage")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            
                            Spacer()
                                .frame(height: 10)
                            
                            HStack{
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut tincidunt congue enim in molestie.")
                                    .font(.system(size: 15))
                                    .foregroundStyle(.white).opacity(0.5)
                                Spacer()
                            }
                            
                            Spacer()
                               
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(height: 1)
                                
                            Spacer()
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer().frame(height: 50)
                    
                    
                    RadarChart(data: data, labels: labels, maxValues: maxValues, designInterval: designInterval, shapeColor: shapeColor)
                        .frame(height: 250)
                    
                    Spacer()
                    
                    VStack {
                        
                        ForEach(0..<labels.count) { index in
                            
                            HStack{
                                Text(labels[index])
                                    .foregroundColor(.white)
                                    .font(.title3)
                                Spacer()
                            }
                            Slider(value: binding(forIndex: index), in: 0...maxValues[index])
                                .accentColor(shapeColor)
                           
                        }
                    }.padding(20)
                  
                    
                }.padding(20)
            }
        }
    }
    
    private func binding(forIndex index: Int) -> Binding<Double> {
        switch index {
        case 0:
            return $fireValue
        case 1:
            return $waterValue
        case 2:
            return $earthValue
        case 3:
            return $airValue
        case 4:
            return $lightValue
        case 5:
            return $darkValue
        default:
            fatalError("Index out of range")
        }
    }
}





