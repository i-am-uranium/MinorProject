//
//  MMSuggestionViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 16/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit
import MessageUI
class MMSuggestionViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet var firsName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var suggestionField: UITextView!
    @IBOutlet var sendSuggestion: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boarderAddingTofields()
    }
    
    
    
    func boarderAddingTofields(){

        self.title = "Suggestion"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "simpleImage")!)
        self.suggestionField.layer.cornerRadius = 5.0
        self.suggestionField.layer.borderColor = UIColor.grayColor().CGColor
        self.suggestionField.layer.borderWidth = 0.25
        self.suggestionField.backgroundColor = UIColor.clearColor()
        self.firsName.backgroundColor = UIColor.clearColor()
        self.firsName.layer.borderColor = UIColor.grayColor().CGColor
        self.lastName.backgroundColor = UIColor.clearColor()
        self.lastName.layer.borderColor = UIColor.grayColor().CGColor
        self.emailField.layer.borderColor = UIColor.grayColor().CGColor
        self.emailField.backgroundColor = UIColor.clearColor()
        self.sendSuggestion.layer.cornerRadius = 3.0
        self.sendSuggestion.layer.borderWidth = 1.0
        self.sendSuggestion.layer.borderColor = UIColor(netHex: 0x3F51B5).CGColor
        
    }

    

    func getText(firsName:UITextField, lastName:UITextField, emailField:UITextField, suggestionField:UITextView)->(String,String,String,String){
    
        let firsName = firsName.text
        let lastName = lastName.text
        let emailField = emailField.text
        let suggestionField = suggestionField.text
        return (firsName!,lastName!,emailField!,suggestionField)
    
    }
    
    
    
    // send suggestion button
    @IBAction func sendSuggestion(sender: AnyObject) {
        
        let (firsname,lastname,email,suggestion) = getText(firsName, lastName: lastName, emailField: emailField, suggestionField: suggestionField)
        if firsname.isEmpty{displayError()
        }else if lastname.isEmpty{displayError()}
        else if email.isEmpty{displayError()}
        else if suggestion.isEmpty{displayError()}
        else{
            
            let emailTitle = "Suggestion From: " + firsname
            let messageBody = "Name: " + firsname + " " + lastname + "\nEmail: " + email + "\n\nMessage: \n" + suggestion
            let toRecipents = ["stupidravi2009@gmail.com"]
            let mc  :MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            self.presentViewController(mc, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue :
            print("mail has been cancel")
        case MFMailComposeResultSaved.rawValue :
            print("mail has been save")
        case MFMailComposeResultFailed.rawValue :
            print("mail has been Failed %@",[error?.localizedDescription])
        case MFMailComposeResultSent.rawValue :
            print("mail has been sent")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // display error if any field is empty
    func displayError(){
        let error = UIAlertController(title: "Erro!", message: "One or More Fields Are empty!", preferredStyle: UIAlertControllerStyle.Alert)
        error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(error, animated: true, completion: nil)
    }
    
    
    
    @IBAction func dissmissKeyboard(sender: AnyObject) {
        self.resignFirstResponder()
    }
    
    
    
    // function to resign te keyboard fromthe textView
     func textView(textView : UITextView, text: String) -> Bool{
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }


}
