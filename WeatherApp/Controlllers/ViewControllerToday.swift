//
//  ViewControllerProject.swift
//  WeatherApp
//
//  Created by shio birbichadze on 1/23/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//

import UIKit
import CoreLocation
import SDWebImage

class ViewControllerToday:UIViewController{
    
    
    private var service=CurrentService()
    private var weatherInfo:weather!
    
    @IBOutlet var top:TopView!
    @IBOutlet var bottom:Features!
    @IBOutlet var stack:UIStackView!
    @IBOutlet var refresh:UIBarButtonItem!
    @IBOutlet var info:UIBarButtonItem!
    
    let locationManager=CLLocationManager()
    var currLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnimation()
        setUpLocation()
        
        
        
    }
    
    private func setUpLocation(){
        locationManager.delegate=self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func goToErrorPage(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "todayError")
        navigationController?.setViewControllers([vc!], animated: true)
    }
    
    private func locationDisabledError(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "locationDisabledError")
        navigationController?.setViewControllers([vc!], animated: true)
    }
    
    func setAnimation(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView,at:1)
    
        let indicator = UIActivityIndicatorView()
        let transfrom = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        indicator.transform = transfrom
    
        indicator.style = .gray
    
    
    
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
    
        indicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.insertSubview(indicator, at: 2)
        indicator.startAnimating()
    
        refresh.isEnabled=false
        info.isEnabled=false
    }
    
    
    func loadInfo(){
        if currLocation==nil{
            self.goToErrorPage()
        }
        service.loadWeather(lat: (currLocation?.coordinate.latitude)!, lon: (currLocation?.coordinate.longitude)!, completion: {[weak self] result in
            guard let self=self else{return}
            DispatchQueue.main.async {
                
                switch result{
                case .value(let info):
                    self.show(data: info)
                    
                case .error( _):
                    
                    
                    //go to error page
                    self.goToErrorPage()
                }
            }
        })
        
        
        
    }
    
    private func show(data:weather){
        weatherInfo=data
        DispatchQueue.main.asyncAfter(deadline: . now() + .seconds(2) ){
            
            let icon=data.weather[0].icon
            
            
            let url:URL?
            url=URL(string:"http://openweathermap.org/img/wn/\(icon)@2x.png" )
            
            self.top.image?.sd_setImage(with: url,             placeholderImage: UIImage(named: "error"),
                                       options: SDWebImageOptions.highPriority,
                                       completed: { _, error, _, _ in
                                            if  error != nil{
                                                self.goToErrorPage()
                                            }else{
                                                //success
                                            }
            })
            
            self.top.destination.text=data.name+","+data.sys.country
            self.top.weather.text=String(Int(data.main.temp))+"°C | "+data.weather[0].description
            self.bottom.clouds.info.text=String(data.clouds.all)+" %"
            self.bottom.humidity.info.text=String(data.main.humidity)+" mm"
            self.bottom.pressure.info.text=String(data.main.pressure)+" hPa"
            self.bottom.windSpeed.info.text=String(data.wind.speed)+" km/h"
            self.bottom.windDirection.info.text=self.findDirection(degree: data.wind.deg)
            
            //stop animation
            self.stopAnimation()
        }
    }
    
    func stopAnimation(){
    
        for subview in view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
            
            if subview is UIActivityIndicatorView{
                subview.removeFromSuperview()
            }
        }
        refresh.isEnabled=true
        info.isEnabled=true
    }
    
    private func findDirection(degree:Float)->String{
        var direction=""
        if 348.75 <= degree, degree <= 360  { direction =  "N" }
        else if 0 <= degree,degree <= 11.25 { direction = "N" }
        else if 11.25 < degree, degree <= 33.75 { direction = "NNE" }
        else if 33.75 < degree, degree <= 56.25 { direction = "NE" }
        else if 56.25 < degree, degree <= 78.75 { direction = "ENE" }
        else if 78.75 < degree, degree <= 101.25 { direction = "E" }
        else if 101.25 < degree, degree <= 123.75 { direction = "ESE" }
        else if 123.75 < degree, degree <= 146.25 { direction = "SE" }
        else if 146.25 < degree, degree <= 168.75 { direction = "SSE" }
        else if 168.75 < degree, degree <= 191.25 { direction = "S" }
        else if 191.25 < degree, degree <= 213.75 { direction = "SSW" }
        else if 213.75 < degree, degree <= 236.25 { direction = "SW" }
        else if 236.25 < degree, degree <= 258.75 { direction = "WSW" }
        else if 258.75 < degree, degree <= 281.25 { direction = "W" }
        else if 281.25 < degree, degree <= 303.75 { direction = "WNW" }
        else if 303.75 < degree, degree <= 326.25 { direction = "NW" }
        else if 326.25 < degree, degree < 348.75 { direction = "NNW" }
        return direction
    }
    
    
    
    @IBAction func refreshFunc(){
        setAnimation()
        locationManager.requestLocation()
        loadInfo()
        
    }
    
    
    @IBAction func showDescription(){
        let info = weatherInfo.weather[0].description
        
        let vc = UIActivityViewController(activityItems: [info], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated:true)
    }
}




extension ViewControllerToday: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.goToErrorPage()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty{
            currLocation=locations.first
            locationManager.stopUpdatingLocation()
            loadInfo()
        }else{
            self.goToErrorPage()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()) {
            self.locationDisabledError()
        }else if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
        }else{
            locationManager.requestLocation()
        }
    }
    
    
}


