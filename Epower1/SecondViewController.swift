//
//  SecondViewController.swift
//  Epower1
//
//  Created by Bharath Bandaru on 22/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    var pass : String?
    var statevalue: String?
    @IBOutlet weak var headlabel: UILabel!
    
    var snos = Array<String>()
    var state_arr = Array<String>()
    var city_arr = Array<String>()
    @IBOutlet weak var jobch: UITextField!
    @IBOutlet weak var statech: UITextField!
    @IBOutlet weak var citych: UITextField!
    var stateURL = "http://192.168.0.100/elec_dir/state.php"
    var cityURL = "http://192.168.0.100/elec_dir/city.php"
    var jonURL = "http://192.168.0.100/elec_dir/job.php"
    var placepicker = UIPickerView()
    var toolBar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        callStateAlmo(url: stateURL)
        //callCityAlmo(url: cityURL)
        headlabel.text = pass
        
        placepicker.delegate = self
        placepicker.dataSource = self
        statech.inputView = placepicker
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FirstViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FirstViewController.canclePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        statech.inputView = placepicker
        statech.inputAccessoryView = toolBar
        statevalue = "select.."

        
    }
    func callStateAlmo( url : String){
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
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    
                    let responseJSON = JSON(resultValue)
                    for index in responseJSON["data"].array!{
                        self.state_arr.append(index["state"].string!)
                    }
                    DispatchQueue.main.async {
                        //  self.firstTableView.reloadData()
                        
                    }
                    print(self.state_arr)
                    
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
    func callCityAlmo( url : String){
        let para: Parameters = ["state":"ap"]
        
        Alamofire.request(url, method: .post, parameters: para)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    let responseJSON = JSON(resultValue)
                    print("response\(responseJSON["data"])")

                    for index in responseJSON["data"].array!{
                        self.city_arr.append(index["city"].string!)
                    }
                    DispatchQueue.main.async {
                        //  self.firstTableView.reloadData()
                        
                    }
                    print(self.city_arr)
                    
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return state_arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        statevalue = state_arr[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return state_arr[row]
        
    }

    
    func donePicker() -> Void {
        statech.text = statevalue
        self.view.endEditing(true)
    }
    func canclePicker() -> Void {
        self.view.endEditing(true)
    }
    

}
