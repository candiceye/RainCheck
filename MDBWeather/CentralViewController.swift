//
//  CentralViewController.swift
//  MDBWeather
//
//  Created by Candice Ye on 10/14/16.
//  Copyright © 2016 Candice Ye. All rights reserved.
//

import UIKit
import Alamofire

class CentralViewController: UIViewController {

    // ALAMOFIRE VARIABLES - - - - -
    var locationURL = "https://api.darksky.net/forecast/639a5ac270e86e62a1d82629fa128e19/37.8267,-122.4233"
    
    var temperature: Double?
    var precipProbability: Double?
    var currentlySummary: String?
    var minutelySummary: String?
    // - - - - - - - - - - - - - - -

    
    // STATIC VARIABLES - - - - - -
    var backgroundImage: UIImageView!
    var logoImage: UIImageView!
    var credit: UIButton!
    
    var location: UILabel!
    var currentTemp: UILabel!
    
    var rainChance: UILabel!
    var rainDetails: UILabel!
    
    var weatherDescription: UILabel!
    // - - - - - - - - - - - - - - -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamo(url: locationURL)
        setUpCentral()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    // ALAMOFIRE - - - - - - - - - -
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData: response.data!)
        })
        
    }
    func parseData(JSONData : Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String: AnyObject]
            
            if let currently = readableJSON["currently"] as? [String: AnyObject]
            {
                temperature = currently["temperature"] as! Double
                precipProbability = currently["precipProbability"] as! Double
                currentlySummary = currently["summary"] as! String
            }
            
            if let minutely = readableJSON["minutely"] as? [String: AnyObject]
            {
                minutelySummary = minutely["summary"] as! String
            }
            
        }
        catch {
            print(error)
        }
        
    }
    
    // - - - - - - - - - - - - - - -

 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // ACTIONS / FUNCTIONS - - - - - - -
    
    
    func setUpCentral() {
        
        // LOGO BACKGROUND
        backgroundImage = UIImageView(image: #imageLiteral(resourceName: "goodBackground"))
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(backgroundImage)
        
        // LOGO IMAGE
        logoImage = UIImageView(image: #imageLiteral(resourceName: "rainCheckLogo3"))
        logoImage.frame = CGRect(x: view.frame.width/8, y: 30, width: 0.75*(view.frame.width), height: view.frame.height/5)
        logoImage.layer.masksToBounds = true
        logoImage.contentMode = .scaleAspectFit
        logoImage.layer.cornerRadius = 10
        self.view.addSubview(logoImage)
        
        // CREDIT
        credit = UIButton()
        credit.frame = CGRect(x: view.frame.width/4, y: 40+view.frame.height/5, width: view.frame.width/2, height: 22)
        credit.setTitle("Powered by DarkSky", for: .normal)
        credit.setTitleColor(UIColor.white, for: .normal)
        credit.addTarget(self, action:#selector(urlMaker), for: .touchUpInside)
        self.view.addSubview(credit)
        
        //LOCATION 
        location = UILabel()
        location.frame = CGRect(x: view.frame.width*0.1, y: view.frame.height/3 - 10, width: view.frame.width*0.8, height: view.frame.height/8)
        location.text = "Berkeley, California"
        location.textColor = UIColor.white
        location.font = UIFont(name: "Avenir", size: 35)
        location.textAlignment = .center
        self.view.addSubview(location)
        
        //CURRENT TEMPERATURE
        currentTemp = UILabel()
        currentTemp.frame = CGRect(x: view.frame.width*0.25, y: view.frame.height/3 , width: view.frame.width*0.5, height: view.frame.height/3)
        currentTemp.text = "\(temperature)°"
        currentTemp.textColor = UIColor.white
        currentTemp.font = UIFont(name: "Avenir", size: 100)
        currentTemp.textAlignment = .center
        self.view.addSubview(currentTemp)
        
        // RAIN CHANCE
        rainChance = UILabel()
        rainChance.frame = CGRect(x: view.frame.width*0.1, y: view.frame.height/2 + 10, width: view.frame.width*0.8, height: view.frame.height/8)
        rainChance.text = "Chance of rain: \(precipProbability)%"
        rainChance.textColor = UIColor.white
        rainChance.font = UIFont(name: "Avenir", size: 20)
        rainChance.textAlignment = .center
        self.view.addSubview(rainChance)
        
        // RAIN DETAILS
        rainDetails = UILabel()
        rainDetails.frame = CGRect(x: view.frame.width*0.1, y: view.frame.height/2 + 35, width: view.frame.width*0.8, height: view.frame.height/8)
        rainDetails.text = minutelySummary
        rainDetails.textColor = UIColor.white
        rainDetails.font = UIFont(name: "Avenir", size: 20)
        rainDetails.lineBreakMode = NSLineBreakMode.byWordWrapping
        rainDetails.textAlignment = .center
        self.view.addSubview(rainDetails)
        
        // DESCRIPTION
        weatherDescription = UILabel()
        weatherDescription.frame = CGRect(x: (view.frame.width)*0.1, y: view.frame.height*(2/3) - 30, width: view.frame.width*0.8, height: (view.frame.height/3))
        weatherDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        weatherDescription.numberOfLines = 0
        weatherDescription.textColor = UIColor.white
        weatherDescription.font = UIFont(name: "Avenir", size: 17)
        weatherDescription.textAlignment = .center
        weatherDescription.text = "\(currentlySummary)"
        self.view.addSubview(weatherDescription)
        
    }
 
    
    // HYPERLINK
    func urlMaker(sender: UIButton) {
        let url = URL(string: "https://darksky.net/poweredby/")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
    // - - - - - - - - - - - - - - - - -

}




