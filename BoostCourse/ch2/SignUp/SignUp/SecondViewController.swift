//
//  SecondViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/02/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwCheckField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addViews()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}




// MARK: SecondViewController Methods
extension SecondViewController {
    
    @IBAction func touchUpImage(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        UserInformation.shared.id = nil
        UserInformation.shared.pw = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        
        // id, pw, pwcheck 세 필드 모두 빈문자열 아니고, nil 아닐 때
        guard let idInput = idField.text, !idInput.isEmpty else { return }
        guard let pwInput = pwField.text, !pwInput.isEmpty else { return }
        guard let pwCheck = pwCheckField.text, !pwCheck.isEmpty else { return }
        
        if (pwInput == pwCheck) {
            
            UserInformation.shared.id = idField.text ?? nil
            UserInformation.shared.pw = pwField.text ?? nil
            
            print()
            print("SecondVC -> ThirdVC")
            print("다음 페이지로")
            
            let thirdStoryboard = UIStoryboard(name: "ThirdViewController", bundle: nil)
            let thirdVC = thirdStoryboard.instantiateViewController(withIdentifier: "thirdVC")
            
            self.navigationController?.pushViewController(thirdVC, animated: true)
        }
        else {
            print("pw != check, 다시 입력")
        }
    }
    
    /*
    // 이미지 선택하면 next 버튼 활성 여부 체크
    @objc func isImageSelected(imageView: UIImageView) -> Bool {
        if (self.imageView.image != nil) {
            return true
        }
        return false
    }
    
    // id, pw, pwCheck 3가지 TextField 입력하면 next 버튼 활성 여부 체크
    @objc func isTextFieldHasText(textField: UITextField) -> Bool {
        if (self.idField.hasText) && (self.pwField.hasText) && (self.pwCheckField.hasText) {
            return true
        }
        return false
    }
    
    // textView 입력하면 next 버튼 활성 여부 체크
    @objc func isTextViewHasText(textView: UITextView) -> Bool {
        if (self.textView.hasText) {
            return true
        }
        return false
    }
    */
    
    
    // 이미지 선택하면 next 버튼 활성 여부 체크
    @IBAction func imageSelected(_ sender: UIImageView) {
        if (self.imageView.image != nil) && (self.idField.hasText) && (self.pwField.hasText) && (self.pwCheckField.hasText) && (self.textView.hasText) {
            cancelButton.backgroundColor = .systemBlue
            cancelButton.isEnabled = true
        }
    }
    
    // id, pw, pwCheck 3가지 TextField 입력하면 next 버튼 활성 여부 체크
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if (self.imageView.image != nil) && (self.idField.hasText) && (self.pwField.hasText) && (self.pwCheckField.hasText) && (self.textView.hasText) {
            cancelButton.backgroundColor = .systemBlue
            cancelButton.isEnabled = true
        }
    }
    
    // textView 입력하면 next 버튼 활성 여부 체크
    @IBAction func textViewFilled(_ sender: UITextView) {
        if (self.imageView.image != nil) && (self.idField.hasText) && (self.pwField.hasText) && (self.pwCheckField.hasText) && (self.textView.hasText) {
            cancelButton.backgroundColor = .systemBlue
            cancelButton.isEnabled = true
        }
        
        /*
        cancelButton.isEnabled = (self.imageView.image != nil) && (self.idField.text != nil) && (self.pwField.text != nil) && (self.pwCheckField.text != nil) && (self.textView.text != nil)
        */
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}




// MARK: imagePicker 델리데이트
extension SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 취소하면 모달 dismiss
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 선택화면
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}




// MARK: SecondViewController Views
extension SecondViewController {
    
    func addViews() {
        self.addUIView()
        self.addImageView()
        self.addIdInputField()
        self.addPwInputField()
        self.addPwCheckField()
        self.addStackView()
        self.addTextView()
        self.addCancelButton()
        self.addNextButton()
    }
    
    func addUIView() {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.uiView = view
    }
    
    func addImageView() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        
        image.backgroundColor = .systemGray
        
        image.isUserInteractionEnabled = true
        let clickImageView = UITapGestureRecognizer(target: self, action: #selector(self.touchUpImage(_:)))
        image.addGestureRecognizer(clickImageView)
        
        image.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor, constant: 8).isActive = true
        image.topAnchor.constraint(equalTo: self.uiView.topAnchor, constant: 32).isActive = true
        image.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.3).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1).isActive = true
        
        self.imageView = image
    }
    
    func addIdInputField() {
        let id: UITextField = UITextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(id)
        
        id.borderStyle = UITextField.BorderStyle.roundedRect
        id.placeholder = "id"
        
        id.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        id.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        id.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        // id.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        
        self.idField = id
    }
    
    func addPwInputField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.placeholder = "pw"
        pw.isSecureTextEntry = true
        
        pw.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        // pw.topAnchor.constraint(equalTo: idField.bottomAnchor, constant: 8).isActive = true
        
        self.pwField = pw
    }
    
    func addPwCheckField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.placeholder = "check pw"
        pw.isSecureTextEntry = true
        
        pw.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        // pw.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 8).isActive = true
        
        self.pwCheckField = pw
    }
    
    func addStackView() {
        let stack: UIStackView = UIStackView(arrangedSubviews: [self.idField, self.pwField, self.pwCheckField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(stack)
        
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        
        stack.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 8).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        
        self.stackView = stack
    }
    
    func addTextView() {
        let text: UITextView = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(text)
        
        text.isEditable = true
        text.backgroundColor = .systemYellow
        
        text.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor, constant: 8).isActive = true
        text.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        text.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        // text.heightAnchor.constraint(equalTo: text.widthAnchor, multiplier: 1).isActive = true
        
        self.textView = text
    }
    
    func addCancelButton() {
        let cancel: UIButton = UIButton(type: UIButton.ButtonType.custom)
        
        cancel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cancel)
        
        cancel.setTitle("Cancel", for: UIControl.State.normal)
        
        cancel.addTarget(self, action: #selector(self.touchUpCancelButton(_:)), for: UIControl.Event.touchUpInside)
        
        cancel.backgroundColor = .systemBlue
        
        // cancel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80).isActive = true
        cancel.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor, constant: 16).isActive = true
        cancel.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.45).isActive = true
        cancel.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.cancelButton = cancel
        
    }
    
    func addNextButton() {
        let next: UIButton = UIButton(type: UIButton.ButtonType.custom)
        
        next.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(next)
        
        
        next.setTitle("Next", for: UIControl.State.normal)
        
        
        next.addTarget(self, action: #selector(self.touchUpNextButton(_:)), for: UIControl.Event.touchUpInside)
        
        next.isEnabled = false
        next.backgroundColor = .systemGray
        
        
        // next.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 80).isActive = true
        next.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -16).isActive = true
        next.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.45).isActive = true
        next.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.nextButton = next
    }
}
