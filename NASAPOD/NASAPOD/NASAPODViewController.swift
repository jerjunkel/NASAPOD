//
//  NASAPODViewController.swift
//  NASAPOD
//
//  Created by Jermaine Kelly on 11/5/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class NASAPODViewController: UIViewController {
    
    let pictureOfTheDayEndpoint = "https://api.nasa.gov/planetary/apod?api_key=sc9iw4ElIKu4KSw5204cqtOCbOM6Oo6FWUs97ES2"
    var picture: Picture!
  
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pictureOfTheDayImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShadow(to: pictureOfTheDayImageView)
        getPictureObject()
    }
    
    func getPictureObject(for date:String = ""){
        APIRequestManager.manager.getData(from: pictureOfTheDayEndpoint + date) { (data) in
            if let validData = data{
                DispatchQueue.main.async {
                    self.picture = Picture.buildPicObject(from: validData)
                    self.getImage(from: (self.picture?.url)!)
                    self.descriptionTextView.text = self.picture.title + "\n\n" + self.picture.description
                    
                    
                }
            }
        }
    }
    
    func getImage(from imageUrl: String){
        APIRequestManager.manager.getData(from: imageUrl) { (data) in
            if let validData = data{
                DispatchQueue.main.async {
                    self.pictureOfTheDayImageView.image = UIImage(data: validData)
                   // self.pictureOfTheDayImageView.setNeedsDisplay()
                }
                print("Image set")
            }
        }
    }
    
    func dateFormat(date: Date)->String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormater.string(from: date)
        dateFormater.dateStyle = .medium
        print(date)
        return "&date=\(stringDate)"
    }
    
    func addShadow(to view:UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let stringDate = dateFormat(date: sender.date)
        getPictureObject(for: stringDate)
    }

    
}
