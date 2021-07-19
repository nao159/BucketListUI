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
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDtailts = false
    @State private var showingEditScreen = false
    
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
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = "Example location"
                        newLocation.coordinate = self.centerCoordinate
                        locations.append(newLocation)
                        
                        selectedPlace = newLocation
                        showingEditScreen.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }).padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding([.trailing, .bottom])
                }
            }
        }
        .alert(isPresented: $showingPlaceDtailts) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                showingEditScreen.toggle()
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if selectedPlace != nil {
                EditView(placemark: selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData(){
        
        let fileName = getDocumentDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            
            let data = try Data(contentsOf: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            
            print("Unable to load saved data")
        }
    }
    
    func saveData() {
        
        do {
            
            let fileName = getDocumentDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
        } catch {
            
            print("unable to save data")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
