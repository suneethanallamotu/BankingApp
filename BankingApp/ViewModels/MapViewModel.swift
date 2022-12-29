//
//  MapViewModel.swift
//  BankingApp
//
//  Created by Suneetha Nallamotu on 12/6/22.
//


import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    static let defaultSpan =  MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManger: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManger = CLLocationManager()
            //locationManger?.desiredAccuracy = kCLLocationAccuracyBest
            locationManger!.delegate = self
        } else {
            print("show an alert letting them know to turn on location services.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManger = locationManger else { return }
        
        switch locationManger.authorizationStatus {
            
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted")
        case .denied:
            print("you have denied this app location permission. please go to settings to change.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManger.location!.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break;
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
