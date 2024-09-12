//
//  LocationManager.swift
//  EventExplorer
//
//  Created by L S on 18/05/2024.
//

import CoreLocation
import Combine

import CoreLocation
import Combine

/*class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var locationAuthorizationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthorizationStatus = CLLocationManager.authorizationStatus()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }
}*/





