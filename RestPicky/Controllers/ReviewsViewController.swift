//
//  ReviewsViewController.swift
//  RestPicky
//
//  Created by user145117 on 11/1/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBAction func reviewsButton(_ sender: Any) {
        print("reviewsButton pressed")
        let zomatoKey = "081453715063534cc2ddc273bb5ded39"
        let centerLatitude = 19.06558, centerLongitude = 72.86215
        let urlString = "https://developers.zomato.com/api/v2.1/search?&lat=\(centerLatitude)&lon=\(centerLongitude)";
        let url = NSURL(string: urlString)
        
        if url != nil {
            let request = NSMutableURLRequest(url: url! as URL)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(zomatoKey, forHTTPHeaderField: "user_key")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
                if error == nil {
                    let httpResponse = response as! HTTPURLResponse!
                    print(httpResponse?.statusCode)
                    if httpResponse?.statusCode == 200 {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                if let restaurants = json["restaurants"] as? [NSDictionary] {
                                    for rest in restaurants {
                                        var searchResult = [String:AnyObject?]()
                                        let restaurant = rest["restaurant"] as! NSDictionary
                                        print(restaurant["id"] as? NSString)
                                        print(restaurant["average_cost_for_two"] as? NSNumber)
                                        print(restaurant["cuisines"] as? String)
                                        print(restaurant["url"] as? String)
                                        print(restaurant["thumb"] as? String)
                                        if let location = restaurant["location"] as? NSDictionary {
                                            print(location["address"] as? String)
                                            print(location["city"] as? String)
                                            print((location["latitude"] as? NSString)?.doubleValue)
                                            print((location["longitude"] as? NSString)?.doubleValue)
                                        }
                                        print(restaurant["menu_url"] as? String)
                                        print(restaurant["name"] as? String )
                                        print(restaurant["phone_numbers"] as? String)
                                        if let user_rating = restaurant["user_rating"] as? NSDictionary {
                                            print(user_rating["aggregate_rating"] as? NSString)
                                            print(user_rating["rating_color"] as? String)
                                        
                                        }
                                    }
                                }
                            }
                            
                        } catch {
                            print("ERROR: ", error)
                        }
                    }
                }
            })
            
            task.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
