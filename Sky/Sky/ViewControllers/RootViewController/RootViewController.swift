//
//  RootViewController.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/27.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    //MARK: Properties
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        
        return manager
    }()
    
    private var currentLocation: CLLocation? {
        didSet {
            fetchCity()
            fetchWeather()
        }
    }
    
    var currentWeatherViewController: CurrentWeatherViewController!
    private let segueCurrentWeather = "SegueCurrentWeather"

    //MARK: UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActiveNotification()
    }
    
    
    //MARK: Main Function
    @objc func applicationDidBecomeActive(notification: Notification) {
        print("Ask for user location")
        requestLocation()
    }
    
    //MARK: Segue Performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
            destination.viewModel = CurrentWeatherViewModel()
            currentWeatherViewController = destination
        default:
            break
        }
    }
    
    //MARK: Functional methods
    private func setupActiveNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RootViewController.applicationDidBecomeActive(notification:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    private func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //Fetch the city name through CLGeocoder
    private func fetchCity() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) {
            placemarks, error in
            if let error = error {
                dump(error)
            } else if let city = placemarks?.first?.locality {
                //Todo: Nofity CurrentWeatherViewController
                let location = Location(name: city, latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                self.currentWeatherViewController.viewModel?.location = location
            }
        }
    }
    
    //Fetch the weather data
    private func fetchWeather() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        let lattitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lattitude, longitude: longitude, completion: { response, error in
            if let error = error {
                dump(error)
            } else if let response = response {
                //Todo: Notify CurrentWeatherViewController
                self.currentWeatherViewController.viewModel?.weather = response
            }
        })
    }

}


extension RootViewController: CLLocationManagerDelegate {
    
    //Read current Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.delegate = nil
            
            manager.stopUpdatingLocation()
        }
    }
    
    //When the permissions change, we only re-request the location when .authorizedWhenInUse
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    //When the positioning error occurs, we simply dump the error out.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        print("Open locations")
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        print("Open Settings")
    }
}
