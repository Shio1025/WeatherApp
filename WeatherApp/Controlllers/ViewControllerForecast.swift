//
//  ViewControllerForecast.swift
//  WeatherApp
//
//  Created by shio birbichadze on 1/23/22.
//  Copyright © 2022 shio birbichadze. All rights reserved.
//


import UIKit
import CoreLocation
import SDWebImage

class ViewControllerForecast:UIViewController{
    
    
    @IBOutlet var tableView:UITableView!
    
    @IBOutlet var refresh:UIBarButtonItem!
    
    private var service=forecast5Service()
    
    private var f=[forecast]()
    
    private var countInSections=[Int]()
    private var weekDays=[String]()
    
    let locationManager=CLLocationManager()
    var currLocation:CLLocation?
    
    //var group = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        setUpTableView()
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
    
    private func setBackground(){
        let background = UIImage(named: "forecastBackground")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    private func setAnimation(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView,at:2)
        
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
        view.insertSubview(indicator, at: 3)
        indicator.startAnimating()
        refresh.isEnabled=false
        
    }
    
    private func stopAnimation(){
       // group.notify(queue: .main){
            for subview in self.view.subviews {
                if subview is UIVisualEffectView {
                    subview.removeFromSuperview()
                }
                
                if subview is UIActivityIndicatorView{
                    subview.removeFromSuperview()
                }
            }
            self.refresh.isEnabled=true
        //}
        
    }
    
    
    private func setUpTableView(){
        tableView.delegate=self
        tableView.dataSource=self
        tableView.register(UINib(nibName: "Cell",bundle:nil), forCellReuseIdentifier: "Cell")
        tableView.register(Header.self,
                           forHeaderFooterViewReuseIdentifier: "Header")
        tableView.allowsSelection=false
    }
    
    
    private func loadForecast(){
        if currLocation==nil{
            self.goToErrorPage()
        }
        //start animation
        service.loadForecast(lat: (currLocation?.coordinate.latitude)!, lon: (currLocation?.coordinate.longitude)!, completion: {[weak self] result in
            guard let self=self else{return}
            DispatchQueue.main.async {
                
                switch result{
                case .value(let forecast3):
                    self.show(data:forecast3)
                    
                case .error( _):
                    
                    
                    //go to error page
                    self.goToErrorPage()
                }
            }
        })
        
        
    }
    
    private func show(data:[forecast]){
        
        DispatchQueue.main.asyncAfter(deadline: . now() + .seconds(2) ){
            
            self.f=data
            self.fillSectionsInfo()
            
            
            self.tableView.reloadData()
            self.stopAnimation()
        }
    }
    
    
    
    
//    private func downloadImage(for url: String, imageView:UIImageView) {
//        self.group.enter()
//        DispatchQueue.global(qos: .default).async {
//            if let url = NSURL(string: url), let data = NSData(contentsOf: url as URL), let image = UIImage(data: data as Data) {
//
//
//
//
//
//                DispatchQueue.main.sync{
//                    imageView.contentMode =  UIView.ContentMode.scaleAspectFill
//                    imageView.clipsToBounds = true
//                    //stop image animation
//                    imageView.image = image
//                    self.group.leave()
//                }
//            }else{
//                self.goToErrorPage()
//
//            }
//        }
//    }
    
    
    @IBAction func refreshFunc(){
        setAnimation()
        locationManager.requestLocation()
        loadForecast()
       
    }
    
    
    private func fillSectionsInfo(){
        weekDays=[]
        countInSections=[]
        var currentDay=""
        var currentNumInSection=0
        for elem in f{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from:elem.dt_txt)!
        
           
            let tmp = DateFormatter()
            let new=tmp.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
            if !(currentDay==new) && !(currentNumInSection==0){
                countInSections.append(currentNumInSection)
                currentNumInSection=0
            }
            if currentNumInSection==0{
                currentDay=new
                weekDays.append(new)
            }
            currentNumInSection+=1;
        }
        countInSections.append(currentNumInSection)
        
        
        
    }
    
    private func goToErrorPage(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "forecastError")
        navigationController?.setViewControllers([vc!], animated: true)
    }
    
    private func locationDisabledError(){
        let vc = storyboard?.instantiateViewController(withIdentifier : "locationDisabledError")
        navigationController?.setViewControllers([vc!], animated: true)
    }
}



extension ViewControllerForecast:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return weekDays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countInSections[section]
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:"Header") as! Header
        view.title.text = weekDays[section]
        view.contentView.backgroundColor = UIColor.cyan
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let tmp=cell as? Cell{
            tmp.selectionStyle = .none
            
            

            
            var index=0
            if indexPath.section>0{
                for i in 0...indexPath.section-1{
                    index+=countInSections[i]
                }
                tmp.temp?.text!=String(Int(f[index+indexPath.row].main.temp))+"°C"
            }
            //time
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from:f[index+indexPath.row].dt_txt)!
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute ], from: date)
            
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "HH:mm"
            
            tmp.time?.text=dateFormatter2.string(from: calendar.date(from:components)!)
            //
            
            tmp.weather?.text=f[index+indexPath.row].weather[0].description
            
            let icon=f[index+indexPath.row].weather[0].icon
            
            //self.downloadImage(for: "http://openweathermap.org/img/wn/\(icon)@2x.png",imageView: tmp.imageView!)
            
            let url:URL?
            url=URL(string:"http://openweathermap.org/img/wn/\(icon)@2x.png" )
                
            tmp.imageView?.sd_setImage(with: url,             placeholderImage: UIImage(named: "error"),
                options: SDWebImageOptions.highPriority,
                completed: { _, error, _, _ in
                    if  error != nil{
                        self.goToErrorPage()
                    }else{
                        //success
                    }
                })
            
            
        }
        
        return cell
    }
    
    
}



extension ViewControllerForecast: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.goToErrorPage()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty{
            currLocation=locations.last
            locationManager.stopUpdatingLocation()
            loadForecast()
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
