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

class SecondViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate , UITableViewDelegate , UITableViewDataSource{
    var pass : String?
    var statevalue: String?
    var cityvalue: String?
    var jobvalue: String?
    var flag : Int = 0
    @IBOutlet weak var headlabel: UILabel!
    @IBOutlet weak var searchbutton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var snos = Array<String>()
    var state_arr = Array<String>()
    var city_arr = Array<String>()
    var job_arr = Array<String>()
    @IBOutlet weak var jobch: UITextField!
    @IBOutlet weak var statech: UITextField!
    @IBOutlet weak var citych: UITextField!
    var stateURL = "http://192.168.0.103/elec_dir/state.php"
    var cityURL = "http://192.168.0.103/elec_dir/city.php"
    var jobURL = "http://192.168.0.103/elec_dir/job.php"
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    var toolBar = UIToolbar()
    var toolBar2 = UIToolbar()
    var toolBar3 = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
       //   self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "detailID")
        callStateAlmo(url: stateURL)
        callJobAlmo(url: jobURL)
        searchbutton.clipsToBounds=true
        searchbutton.layer.cornerRadius=searchbutton.frame.size.height/2
        //callCityAlmo(url: cityURL)
        headlabel.text = pass
        pickerView1.tag = 1
        pickerView2.tag = 2
        pickerView3.tag = 3
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView3.delegate = self
        statech.inputView = pickerView1
        citych.inputView = pickerView2
        jobch.inputView = pickerView3
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar2.sizeToFit()
        toolBar3.barStyle = UIBarStyle.default
        toolBar3.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar3.sizeToFit()
        let doneButtons = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.donePickerS))
        let spaceButtons = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButtons = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.canclePickerS))
        
        
        
        
        let doneButtonc = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.donePickerC))
        let spaceButtonc = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButtonc = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.canclePickerC))
        
        
        
        let doneButtonj = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.donePickerJ))
        let spaceButtonj = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButtonj = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.canclePickerJ))
        toolBar.setItems([cancelButtons, spaceButtons, doneButtons], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar2.setItems([cancelButtonc, spaceButtonc, doneButtonc], animated: false)
        toolBar2.isUserInteractionEnabled = true
        toolBar3.setItems([cancelButtonj, spaceButtonj, doneButtonj], animated: false)
        toolBar3.isUserInteractionEnabled = true
        statech.inputView = pickerView1
        citych.inputView = pickerView2
        jobch.inputView = pickerView3
        statech.inputAccessoryView = toolBar
        citych.inputAccessoryView = toolBar2
        jobch.inputAccessoryView = toolBar3
        statevalue = "ALL"

        
    }
    
    @IBAction func citybfunc(_ sender: Any) {
    }
    
    
    func callStateAlmo( url : String){
        let parameters: Parameters = [:]
        flag = 1
        print("1111111")
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
        flag = 2
        city_arr.removeAll()
        print("2222222")
        let para: Parameters = ["state": statevalue ?? "ap"]
        
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
    
    
    func callJobAlmo( url : String){
        flag = 2
        job_arr.removeAll()
        job_arr.append("select..")
        print("2222222")
        let para: Parameters = ["job_cat": "APPDCL"]
        
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
                        self.job_arr.append(index["job"].string!)
                    }
                    DispatchQueue.main.async {
                        //  self.firstTableView.reloadData()
                    }
                    print(self.job_arr)
                    
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
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == pickerView1  {
            return state_arr.count
        } else if pickerView == pickerView2{
            return city_arr.count
        }
        else if pickerView == pickerView3{
            return job_arr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == pickerView1  {
           statevalue = state_arr[row]
        } else if pickerView == pickerView2{
           cityvalue = city_arr[row]
        } else if pickerView == pickerView3{
            jobvalue = job_arr[row]
        }
        
   
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1  {
            return state_arr[row]
        } else if pickerView == pickerView2{
            return city_arr[row]
        }
        else if pickerView == pickerView3{
            return job_arr[row]
        }
        return "kk"

  
        
    }

    
    func donePickerS() -> Void {
            statech.text = statevalue
            self.view.endEditing(true)
            callCityAlmo(url: cityURL)
    }
    func canclePickerS() -> Void {
        self.view.endEditing(true)
    }
    
    func donePickerC() -> Void {
        citych.text = cityvalue
        self.view.endEditing(true)
    }
    func canclePickerC() -> Void {
        self.view.endEditing(true)
    }
    func donePickerJ() -> Void {
        jobch.text = jobvalue
        self.view.endEditing(true)
    }
    func canclePickerJ() -> Void {
        self.view.endEditing(true)
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell:DetailTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "detailID") as! DetailTableViewCell!
        cell.name.text = "Bharath"
        cell.address.text = "H.no: 33, BharathNagar,Telangana"
        cell.email.text = "bharath@gmail.com"
        cell.phone.text = "9059831919"
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            
        }
        
    }


