//
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/28.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: WeatherViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self)
    }
    
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    var now: WeatherData? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    var location: Location? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let now = now, let location = location {
            updateWeatherContainer(with: now, at: location)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Cannot load fetch weather/location data from the network."
        }
    }
    
    func updateWeatherContainer(with data: WeatherData, at location: Location) {
        weatherContainerView.isHidden = false
        
        locationLabel.text = location.name
        
        temperatureLabel.text = String(format: "%.1f °C", data.currently.temperature.toCelcius())
        
        weatherIcon.image = weatherIcon(of: data.currently.icon)
        
        humidityLabel.text = String(format: "%.1f", data.currently.humidity)
        
        summaryLabel.text = data.currently.summary
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        dateLabel.text = formatter.string(from: data.currently.time)
        
        
        
    }
}

protocol CurrentWeatherViewControllerDelegate: AnyObject {
    func locationButtonPressed(controller: CurrentWeatherViewController)
    func settingsButtonPressed(controller: CurrentWeatherViewController)
}

