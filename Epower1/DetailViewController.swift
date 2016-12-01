//
//  DetailViewController.swift
//  Epower1
//
//  Created by Bharath Bandaru on 28/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit
import MessageUI
class DetailViewController: UIViewController,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var phnl: UILabel!
    @IBOutlet weak var addr: UILabel!
    @IBOutlet weak var jobl: UILabel!
    @IBOutlet weak var namel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var whatsBut: UIButton!
    @IBOutlet weak var backview: UIView!
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResult.failed.rawValue :
            print("message failed")
            
        case MessageComposeResult.sent.rawValue :
            print("message sent")
            
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    
}
  
    @IBAction func whatsappFun(_ sender: Any) {
        
        
        
        guard let whatsAppUrl = NSURL(string: "whatsapp://send?text=Some%20Text")
 else { return }
        
        if UIApplication.shared.canOpenURL(whatsAppUrl as URL) {
            UIApplication.shared.openURL(whatsAppUrl as URL)
        }
    }
    @IBOutlet weak var messBut: UIButton!
    @IBOutlet weak var callBut: UIButton!
    var name: String?
    var emai: String?
    var addrr: String?
    var job: String?
    var phno: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
       // self.backview.clipsToBounds = true
        self.backview.layer.cornerRadius = 10
        phnl.text = phno
        addr.text = addrr
        jobl.text = "Head Manager"
        email.text = emai
        namel.text = name
        self.messBut.clipsToBounds = true
        self.messBut.layer.cornerRadius = self.messBut.frame.size.height/2
        self.callBut.clipsToBounds = true
        self.callBut.layer.cornerRadius = self.callBut.frame.size.height/2
        backview.layer.shadowColor = UIColor.black.cgColor
        backview.layer.shadowOpacity = 0.3
        backview.layer.shadowOffset = CGSize.zero
        backview.layer.shadowRadius = 10
//        backview.layer.shadowColor = UIColor.gray.cgColor
//        backview.layer.shadowOpacity = 0.25
//        backview.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        backview.layer.shadowRadius = 2
//        backview.layer.masksToBounds = true
//        backview.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        
//        whatsBut.clipsToBounds=true
//        whatsBut.layer.cornerRadius=messBut.frame.size.height/2
//        whatsBut.layer.shadowColor = UIColor.gray.cgColor
//        whatsBut.layer.shadowOpacity = 0.25
//        whatsBut.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        whatsBut.layer.shadowRadius = 2
//        whatsBut.layer.masksToBounds = true
//        whatsBut.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
//        
//        callBut.clipsToBounds=true
//        callBut.layer.cornerRadius=messBut.frame.size.height/2
//        callBut.layer.shadowColor = UIColor.black.cgColor
//        callBut.layer.shadowOpacity = 0.25
//        callBut.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        callBut.layer.shadowRadius = 2
//        callBut.layer.masksToBounds = true
//        callBut.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func msgbutAction(_ sender: Any) {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Message string"
        messageVC.recipients = [phno!] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    @IBAction func phbutAction(_ sender: Any) {
        
        if let url = NSURL(string: "tel://\(NSDecimalNumber(mantissa:UInt64(phno!)!, exponent: -9, isNegative:false))") {
            UIApplication.shared.openURL(url as URL)
            print("herer")
            
        }
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
