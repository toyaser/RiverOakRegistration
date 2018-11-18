//
//  FormTableViewController.swift
//  RiverOakRegistration
//
//  Created by Yaser Abou Elenein on 19/2/18.
//  Copyright © 2018 Yaser Abouelenein. All rights reserved.
//

import UIKit
import YPDrawSignatureView

class FormTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var agreeButton: UIBarButtonItem!
    @IBOutlet weak var nameUserTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var howDidYouHearAboutUsCell: UITableViewCell!
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    var selectedOptionsFromHearAboutUsOptions = Array(repeating: false, count: 7)
    var selectedOptionOtherText = ""
    
    let cellSpacingHeight: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTargetIsNotEmptyTextFields()
        tableView.reloadData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        tableView.allowsSelection = false
    }
        
    @IBAction func clearSignature(_ sender: UIButton) {
        // This is how the signature gets cleared
        self.signatureView.clear()
    }
    // how to add text to disclosure https://stackoverflow.com/a/35400276/3322417
    
    func setupAddTargetIsNotEmptyTextFields() {
        agreeButton.isEnabled = false
        //
        //        headerView.clipsToBounds = true
        //        headerView.layer.cornerRadius = 5
        //        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        //
        nameUserTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        postalCodeTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        //        emailUserTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
        //                                     for: .editingChanged)
        //        passwordUserTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
        //                                        for: .editingChanged)
        //        confimPasswordUserTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
        //                                              for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFromHearAboutUsOptions" {
            
            let destinationVC = segue.destination as! HearAboutUsOptionsTableViewController
            
            destinationVC.selectedOptionsFromHearAboutUsOptions = self.selectedOptionsFromHearAboutUsOptions
            destinationVC.selectedOptionOtherText = self.selectedOptionOtherText
        }
    }

    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacingHeight
//    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 4
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 4
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameUserTextField {
            textField.resignFirstResponder()
            postalCodeTextField.becomeFirstResponder()
        } else if textField == postalCodeTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            nameUserTextField.resignFirstResponder()
        }
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        if !isValidEmail(testStr: emailTextField.text!) {
            let alert = UIAlertController(title: "Invalid Email", message: "Please enter a valid email address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let successAlert = UIAlertController(title: "Thank you", message: "Enjoy your stay", preferredStyle: UIAlertController.Style.alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                action in
                
                self.dismiss(animated: true, completion: nil)
                
            }))
            self.present(successAlert, animated: true, completion: nil)
        }
    }
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func enableIAgree() {
        guard
            let name = nameUserTextField.text, !name.isEmpty,
            let postalCode = postalCodeTextField.text, !postalCode.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let hearAboutUsOption = howDidYouHearAboutUsCell.detailTextLabel?.text, hearAboutUsOption != "Please Select"
            else {
                agreeButton.isEnabled = false
                return
            }
        
        agreeButton.isEnabled = true
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if (nameUserTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            (postalCodeTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            (emailTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            // string contains non-whitespace characters
            return
        }
        
        enableIAgree()
        
//        guard
//            let name = nameUserTextField.text, !name.isEmpty,
//            let postalCode = postalCodeTextField.text, !postalCode.isEmpty,
//            let email = emailTextField.text, !email.isEmpty,
//            let hearAboutUsOption = howDidYouHearAboutUsCell.detailTextLabel?.text, hearAboutUsOption != "Please Select"
//        else {
//                agreeButton.isEnabled = false
//                return
//        }
//        agreeButton.isEnabled = true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.reuseIdentifier == "RegistrationNameCell" {
                nameUserTextField.becomeFirstResponder()
            } else if cell.reuseIdentifier == "RegistrationPostalCodeCell" {
                postalCodeTextField.becomeFirstResponder()
            } else if cell.reuseIdentifier == "RegistrationEmailCell" {
                emailTextField.becomeFirstResponder()
            }
            
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
