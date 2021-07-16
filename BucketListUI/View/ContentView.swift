//
//  ContentView.swift
//  BucketListUI
//
//  Created by Максим Нуждин on 12.07.2021.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDtailts = false
    
    var body: some View {
        ZStack {
            MapView(centralCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDeatils: $showingPlaceDtailts, annotations: locations).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Circle()
                .fill(Color.blue)
                .opacity(0.4)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.title = "Example location"
                        newLocation.coordinate = self.centerCoordinate
                        locations.append(newLocation)
                    }, label: {
                        Image(systemName: "plus")
                    }).padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showingPlaceDtailts) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
