//
//  SignUpViewController+UI.swift
//  Hooked
//
//  Created by Michael Roundcount on 2/29/20.
//  Copyright © 2020 Michael Roundcount. All rights reserved.
//

import UIKit
import ProgressHUD
import CoreLocation

extension SignUpViewController {
    
    func setUpTitleTextLbl() {
        let title = "Sign Up"
        //copy over from ViewController+UI
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Didot", size: 28)!, NSAttributedString.Key.foregroundColor : UIColor.black])
        
        titleTextLbl.attributedText = attributedText
    }
    
    func setUpAvatar() {
        //making the UIImage circular note: height and width is 80
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
        //adding actions to respond to tap gesture
        avatar.isUserInteractionEnabled = true
        //use self becauase it it is on the signUpViewController itseld
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
        
        avatar.isHidden = true
    }
    
    @objc func presentPicker() {
        //video 17 image compressing
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        //users can edit the selected photo
        picker.allowsEditing = true
        //enable methods in the UIImage picker delegate
        picker.delegate = self
        //Making the image fill the entire UIIMage space
        avatar.contentMode = . scaleAspectFill
        self.present(picker, animated: true, completion: nil)
    }
    
    func setUpUsernameTxt() {
        //build a wall! Caugh cuagh make a border
        usernameContainerView.layer.borderWidth = 1
        //note the type for border color is cgColor
        usernameContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        usernameContainerView.layer.cornerRadius = 3
        usernameContainerView.clipsToBounds = true
        //we don't need the border for the full name text field. Tthis is because the container came with a border
        usernameTxt.borderStyle = .none
        //coding in the placeholder string with the same key value pairing attributed string just like on ViewController+UI.
        let placeholderAttr = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        usernameTxt.attributedPlaceholder = placeholderAttr
        usernameTxt.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    func setUpEmailTxt() {
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        
        emailTxt.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        emailTxt.attributedPlaceholder = placeholderAttr
        emailTxt.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setUpPasswordTxt() {
        //the encryption text should be done in storyboard
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        passwordContainerView.layer.cornerRadius = 3
        passwordContainerView.clipsToBounds = true
        
        passwordTxt.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Password (6+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        passwordTxt.attributedPlaceholder = placeholderAttr
        passwordTxt.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setUpSignUpBtn() {
        signUpBtn.setTitle("Sign Up", for: UIControl.State.normal)
        signUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        signUpBtn.backgroundColor = UIColor.black
        signUpBtn.layer.cornerRadius = 5
        signUpBtn.clipsToBounds = true
        signUpBtn.setTitleColor(.white, for: UIControl.State.normal)
        
    }
    
    func setUpSignInBtn() {
        // We're going to apply the key value UI attributed string to a UI button
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)])
        
        let attributedSubText = NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.black])
        
        attributedText.append(attributedSubText)
        signInBtn.setAttributedTitle(attributedText, for: UIControl.State.normal)
    }
    
    
    //Dismissing the keyboard. Looks for the repsonder to the text field to give up the startis
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func validateFields() {
        //making sure the fields are in good form. ProgressHUD has a lot of built in features for this.
        print("We're in the field validation")
        guard let username = self.usernameTxt.text, !username.isEmpty else {
            //Might want to consider using ProgressHUD.showError
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            print("We're in the username")
            return
        }
        
        guard let email = self.emailTxt.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            print("We're in the email")
            return
        }
        guard let password = self.passwordTxt.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            print("We're in the password")
            return
        }
        
        print("Getting out of validation")
        //missing image... all or nothing we should add an alert here if taking it out.
    }
    
    func signUp(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        if usernameTxt.text!.isEmpty {
            print("no username")
        } else {

            print("we are now in sign up")
            ProgressHUD.show("Loading...")
            //passing all of the paramters into the user API. Assign all text fields to the appropriate parameters.
            //this is where I might remove image: self.image,
            Api.User.signUp(withUsername: self.usernameTxt.text!, email: self.emailTxt.text!, password: self.passwordTxt.text!, image: self.image, onSuccess: {
                print("In the first step of the API")
                ProgressHUD.dismiss()
                print("Right before on success")
                onSuccess()
                self.resetPreferences()
            }) { (errorMessage) in
                onError(errorMessage)
            }
        }
    }
    
    func resetPreferences() {
        let pref = true
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Alternative Rock" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Ambient" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Classical" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Country" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Dance & EDM" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Dancehall" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Deep House" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Disco" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Drum & Bass" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Dubstep" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Electronic" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Folk" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Hip-hop & Rap" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["House" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Indie" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Jazz & Blues" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Latin" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Metal" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Piano" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Pop" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["R&B & Soul" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Reggae" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Reggaeton" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Rock" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Techno" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Trance" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Trap" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["Triphop" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
        Ref().databasePreferencesUser(user: Api.User.currentUserId)
            .updateChildValues(["World" : pref]) { (error, ref) in
                if error == nil, pref == true {
                }
        }
    }
    
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //updating the avatar any time a user picks up an image.
    //display the photo on the UIIMage view. Use editedImage so if the photo is edited this info will return on the edited photo.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            image = imageSelected
            avatar.image = imageSelected
            
        }
        //If the user does not update their avatar. It will return to the default image
        if let imageOrigional = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            image = imageOrigional
            avatar.image = imageOrigional
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
