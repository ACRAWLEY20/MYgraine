//
//  RegisterViewController.swift
//  MYgraine
//
//  Created by Anthony Crawley on 7/7/20.
//  Copyright © 2020 Anthony Crawley. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let firstName: UITextField = {
          let field = UITextField()
          field.autocapitalizationType = .words
          field.autocorrectionType = .no
          field.returnKeyType = .continue
          field.layer.borderWidth = 1
          field.layer.cornerRadius = 12
          field.layer.borderColor = UIColor.lightGray.cgColor
          field .placeholder = "First Name"
          field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
          field.leftViewMode = .always
          field.backgroundColor = .white
          return field
      }()
    
    private let lastName: UITextField = {
          let field = UITextField()
          field.autocapitalizationType = .words
          field.autocorrectionType = .no
          field.returnKeyType = .continue
          field.layer.borderWidth = 1
          field.layer.cornerRadius = 12
          field.layer.borderColor = UIColor.lightGray.cgColor
          field .placeholder = "Last Name"
          field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
          field.leftViewMode = .always
          field.backgroundColor = .white
          return field
      }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.layer.borderColor = UIColor.lightGray.cgColor
        field .placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.layer.borderColor = UIColor.lightGray.cgColor
        field .placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstName)
        scrollView.addSubview(lastName)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
        
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePicture() {
        presentPhotoOptions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2, y:50 , width: size, height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        firstName.frame = CGRect(x: 30, y: imageView.bottom + 30, width: scrollView.width-60, height: 50)
        lastName.frame = CGRect(x: 30, y: firstName.bottom + 10, width: scrollView.width-60, height: 50)
        emailField.frame = CGRect(x: 30, y: lastName.bottom + 10, width: scrollView.width-60, height: 50)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width-60, height: 50)
        registerButton.frame = CGRect(x: 30, y: passwordField.bottom + 10, width: scrollView.width-60, height: 50)
        
    }
    
    @objc private func registerButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        
        guard let email = emailField.text,
            let password = passwordField.text,
            let first = firstName.text,
            let last = lastName.text,
            !email.isEmpty,
            !password.isEmpty,
            !first.isEmpty,
            !last.isEmpty,
            password.count >= 6 else{
            return
        }
        // Firebase Registration
    }
    
    func alerUserregisterError() {
        let alert = UIAlertController(title: "Oops!", message: "Please enter all information to create a new account.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
        
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if  textField == passwordField {
            registerButtonTapped()
        }
        
        return true
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoOptions() {
        
        let actions = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        
        actions.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self]_ in
            
            self?.presentCamera()
            
        }))
        actions.addAction(UIAlertAction(title: "Camera Roll", style: .default, handler:{ [weak self] _ in
            
            self?.presentLibrary()
            
        }))
        actions.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actions, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func presentLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
            self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
