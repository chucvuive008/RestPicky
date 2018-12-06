//
//  RestaurantDetailViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/30/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import MapKit
import Firebase

protocol updateRestaurantsDelegate{
    func updatedRestaurant(restaurant: Restaurant)
}

class RestaurantDetailViewController: UIViewController {
    

    var reviews = 0 //Should be restaurant.reviews
    var myRating = 0 //Should be userrestaurant.raiting
    var restaurant = Restaurant()
    var user = User()
    var users = [User]()
    var ref:DatabaseReference?
    var total = 0.0
    var restaurantMenu = [Menu]()
    var isBookmarked = false
    
    var updateDelegate : updateRestaurantsDelegate?
    // number of rows in table view
    
    // create a cell for each table view row
    
    
    func setRatingImagesByRestaurantRating(image1: UIImageView, image2: UIImageView, image3: UIImageView, image4: UIImageView, image5: UIImageView, review: Review){
        
        let rating = review.rating
        
        image1.image = UIImage(named: "YellowStarIcon")
        image2.image = UIImage(named: "YellowStarIcon")
        image3.image = UIImage(named: "YellowStarIcon")
        image4.image = UIImage(named: "YellowStarIcon")
        image5.image = UIImage(named: "YellowStarIcon")
        
        if rating < 4.5{
            image5.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 3.5{
            image4.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 2.5{
            image3.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 1.5{
            image2.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 0.5{
            image1.image = UIImage(named: "BlankStarIcon")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users = [User]()
        paintStars(raiting: getRestaurnatRaiting())
        numberReviews.setTitle("\(restaurant.review.count) Reviews", for: .normal)
        for review in restaurant.review{
            users.append(User())
            getUserDidReview(userId: review.userId, localUser: users.last!)
        }
    }
    
    
    @IBOutlet weak var myreviewBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        callBtn.layer.cornerRadius = 5
        getDirectionBtn.layer.cornerRadius = 5
        myreviewBtn.layer.cornerRadius = 5
        titleLabel.text = restaurant.name
        Street.text = restaurant.street
        cityStateZip.text = restaurant.city + ", " + restaurant.state + " \(restaurant.zipcode)"
        
        
        for bookmarked in user.bookmarks
        {
            if bookmarked.restaurantId == restaurant.id && bookmarked.mark
            {
                isBookmarked = true
                bookMarkHeart.setImage(UIImage(named: "HeartIcon"), for: [])
                bookMarkLabel.text = "Bookmarked!"
            }
        }
        
        numberReviews.setTitle("\(restaurant.review.count) Reviews", for: .normal)
        paintStars(raiting: getRestaurnatRaiting())
        phoneNumber.setTitle("Call (\(restaurant.phoneNumber))", for: [])
        
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var getDirectionBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBAction func reviewsBtnPress(_ sender: Any) {
        performSegue(withIdentifier: "detailtoreviews", sender: self)
    }
    
    @IBOutlet weak var numberReviews: UIButton!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var phoneNumber: UIButton!
    
    @IBAction func buttonMyRating(_ sender: Any) {
        performSegue(withIdentifier: "restaurantRatingSegue", sender: self)
    }
    
    @IBOutlet weak var bookMarkHeart: UIButton!
    @IBOutlet weak var bookMarkLabel: UILabel!
    
    @IBAction func buttonBookmark(_ sender: Any) {
        
        var wasBookmarked = false
        var bookmarkId = 0
        
        for bookmarked in user.bookmarks
        {
            if bookmarked.restaurantId == restaurant.id
            {
                wasBookmarked = true
                bookmarkId = bookmarked.id
            }
        }
        
        if isBookmarked
        {
            isBookmarked = false
            user.bookmarks[bookmarkId - 1].mark = false
            bookMarkHeart.setImage(UIImage(named: "heart"), for: [])
            bookMarkLabel.text = "Bookmark?"
        }
        else
        {
            isBookmarked = true
            
            if wasBookmarked
            {
                user.bookmarks[bookmarkId - 1].mark = true
            }
            else{
                let newBookmark = Bookmark()
                
                if user.bookmarks.last?.id == nil
                {
                    bookmarkId = 1
                }
                else{
                    bookmarkId = (user.bookmarks.last?.id)! + 1
                }

                newBookmark.id = bookmarkId
                newBookmark.mark = true
                newBookmark.restaurantId = restaurant.id
                user.bookmarks.append(newBookmark)
            }
            
            bookMarkHeart.setImage(UIImage(named: "HeartIcon"), for: [])
            bookMarkLabel.text = "Bookmarked!"
        }
        
        self.ref?.child("user/\(self.user.uid)/bookmark/\(bookmarkId)").setValue(["id" : bookmarkId, "mark" : isBookmarked, "restaurantId" : self.restaurant.id])
    }
    
    @IBAction func buttonCall(_ sender: Any) {
        if let url = URL(string: "tel://\(restaurant.phoneNumber)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func buttonGetDirections(_ sender: Any) {
        let lat1 : NSString = NSString(format:"%f", restaurant.latitude)
        let lng1 : NSString = NSString(format:"%f", restaurant.longitude)
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(restaurant.name)"
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "restaurantRatingSegue"{
            let seg = segue.destination as! RestaurantReviewsViewController
            seg.restaurant = restaurant
            seg.user = user
        }
        
        if segue.identifier == "detailtoreviews"{
            let seg = segue.destination as! RestaurantReviewsListViewController
            seg.restaurant = restaurant
            seg.users = users
        }
    }
    
    //        rate(myRate: 1)
    
    @IBAction func backBtnPress(_ sender: Any) {
        updateDelegate?.updatedRestaurant(restaurant: restaurant)
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var Street: UILabel!
    @IBOutlet weak var cityStateZip: UILabel!
    
    func rate(myRate: Int)
    {
        if myRating > 0
        {
            reviews -= 1
            total -= Double(myRating)
        }
        myRating = myRate
        reviews += 1
        total += Double(myRate)
        numberReviews.setTitle("\(reviews) Reviews", for: .normal)
        paintStars(raiting: total / Double(reviews))
    }
    
    func getRestaurnatRaiting() -> Double
    {
        var totalRating : Double = 0
        for review in restaurant.review{
            totalRating += review.rating
        }
        var averageRating = 0.0
        
        if restaurant.review.count != 0{
            averageRating = totalRating/Double(restaurant.review.count)
        }
        
        return averageRating
    }
    
    func paintStars(raiting: Double)
    {
        star1.image = UIImage(named: "YellowStarIcon")
        star2.image = UIImage(named: "YellowStarIcon")
        star3.image = UIImage(named: "YellowStarIcon")
        star4.image = UIImage(named: "YellowStarIcon")
        star5.image = UIImage(named: "YellowStarIcon")
        
        if raiting < 4.5{
            star5.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 3.5{
            star4.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 2.5{
            star3.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 1.5{
            star2.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 0.5{
            star1.image = UIImage(named: "BlankStarIcon")
        }
        
    }
    
    func getUserDidReview(userId: String, localUser: User){
        ref = Database.database().reference()
        let prf = "profileImage"
        do {
        try getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/user%2F\(userId)%2F\(prf).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", user: localUser)
        } catch {
            localUser.image = UIImage()
        }
        ref!.child("user").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            localUser.name = value?["name"] as? String ?? ""
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getPhoto (urlString : String, user: User) throws {
        let url = URL(string: urlString)
        DispatchQueue.global().sync {
            do {
                let data = try Data(contentsOf: url!)
                user.image = UIImage(data: data)!
            } catch{
                user.image = UIImage(named: "UserIcon")!
            }
        }
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

extension  RestaurantDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection Section: Int) -> Int {
        
        return restaurant.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? DataCollectionViewCell
        
        cell?.restaurantImage.image = restaurant.images[indexPath.row]
        
        return cell!
    }
}

extension RestaurantDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds
        
        return CGSize(width: size.width, height: 220.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
