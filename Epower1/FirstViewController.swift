//
//  FirstViewController.swift
//  Epower1
//
//  Created by Bharath Bandaru on 22/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class FirstViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    var toolBar = UIToolbar()
    var placepicker = UIPickerView()
    var firstURL = "http://192.168.0.100/elec_dir/top_cat.php"
    var snos = Array<String>()
    var area_arr = Array<String>()
    @IBOutlet weak var areaField: UITextField!
    @IBOutlet weak var firstBut: UIButton!
    var sample: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstBut.clipsToBounds=true
        firstBut.layer.cornerRadius=firstBut.frame.size.height/2
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        
        self.navigationController!.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0x204B67)
        self.navigationController!.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-Thin", size: 26)!
        ]
        
        
        callAlmo(url: firstURL)
        
        placepicker.delegate = self
        placepicker.dataSource = self
        areaField.inputView = placepicker
        
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FirstViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FirstViewController.canclePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        areaField.inputView = placepicker
        areaField.inputAccessoryView = toolBar
        sample = "All Cities"
        

        
        
        // Do any additional setup after loading the view.
    }
    
    func callAlmo( url : String){
        let parameters: Parameters = [:]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                
                switch response.result {
                case .success(let _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    
                    let responseJSON = JSON(resultValue)
                    for index in responseJSON["data"].array!{
                        self.snos.append(index["sno"].string!)
                        self.area_arr.append(index["job_cat"].string!)
                    }
                    DispatchQueue.main.async {
                      //  self.firstTableView.reloadData()
                        
                    }
                    print(self.area_arr)
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    DispatchQueue.main.async {
                     //   self.firstTableView.reloadData()
                        
                    }
                    
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
                
                
        }
        
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return area_arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        sample = area_arr[row]

    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        return area_arr[row]
        
    }
    func donePicker() -> Void {
        areaField.text = sample
        self.view.endEditing(true)
    }
    func canclePicker() -> Void {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
