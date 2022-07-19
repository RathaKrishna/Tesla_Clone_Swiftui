//
//  LocationView.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI


struct CarLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}



let carLocation = [CarLocation(latitude: 19.017616, longitude: 72.856165)]

struct LocationView: View {
    @Environment(\.presentationMode) var presentation
    
    @StateObject var locationManager = LocationManager()

    
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.017615, longitude: 72.856164), span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006))
    
    @State var tracking : MapUserTrackingMode = .follow
    
    var body: some View {
        ZStack{
            //MARK: -Show Map
            Map(coordinateRegion: $locationManager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking,  annotationItems: locationManager.carPin) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    CarPin()
                }
            }
            
            //MARK: -Top Gradient
            Color.mapBackground
                .allowsHitTesting(false)
            
            //MARK: - Bottom view
            if let locationM = locationManager.location {
               
                Text("Your location: \(locationM.latitude), \(locationM.longitude)")
                    .font(.title)
                    .foregroundColor(Color.red)
            }
            LocationBottomView()
            
            //MARK: - Navigation buttons
            VStack {
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        GeneralButton(icon: "chevron.left")}
                    Spacer()
                    Button(action: {
                        locationManager.requestLocation()
                    }){
                        
                        GeneralButton(icon: "scope")
                            .background(Color("Blue").opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }.padding()
                Spacer()
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.background)
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}


struct LocationBottomView: View {
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment:.leading, spacing: 10){
                Text("Location")
                    .font(.title)
                    .fontWeight(.semibold)
                Divider()
                    .background(Color.white)
                    .opacity(0.4)
                Label("Postmaster, Anna Nagar S.O , Chennai", systemImage: "location.fill")
                    .font(.system(.subheadline))
                    .opacity(0.6)
                Text("Summon")
                    .font(.system(.title3))
                    .fontWeight(.semibold)
                    .padding(.top)
                Text("Press and hold controls to move vehicle")
                    .font(.system(.subheadline))
                    .opacity(0.6)
                    .padding(.bottom)
                LocationButton(text: "Go to Target")
                HStack{
                    LocationButton(icon: "arrow.up")
                    LocationButton(icon: "arrow.down")
                }
            }
            .padding()
            .frame(maxWidth:.infinity)
            .background(Color.background)
            .foregroundColor(Color.white)
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.017615, longitude: 72.856164), span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006))
    @Published var carPin: [CarLocation] = carLocation
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
//        manager.startUpdatingLocation()
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
                
                DispatchQueue.main.async {
                    self.location = location.coordinate
                    self.region = MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    )
                    self.carPin = [CarLocation(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!)]
                }

    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
