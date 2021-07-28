//
//  AddPhotoVC.swift
//  My Photos
//
//  Created by Pars arge on 28.07.2021.
//

import UIKit
import CoreData

class AddPhotoVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedItem : Entity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedItem == nil {
            self.navigationItem.title = "Add a new photo"
        }else{
            self.navigationItem.title = selectedItem?.titletext
            txtTitle.text = selectedItem?.titletext
            txtDesc.text = selectedItem?.desctext
            imgPhoto.image = UIImage(data: selectedItem?.image as! Data)
            saveButton.setTitle("Update", for: UIControl.State.normal)
        }
    }
    
    @IBAction func btnCamera(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgPhoto.image = selectedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnGallery(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func btnSave(_ sender: UIButton) {
        if selectedItem == nil {
            let entityDesc = NSEntityDescription.entity(forEntityName: "Entity", in: pc)
            let newItem = Entity(entity: entityDesc!, insertInto: pc)
            newItem.titletext = txtTitle.text
            newItem.desctext = txtDesc.text
            newItem.image = imgPhoto.image!.jpegData(compressionQuality: 0.8) as Data?
            
            
        }else {
            selectedItem?.titletext = txtTitle.text
            selectedItem?.desctext = txtDesc.text
            selectedItem?.image = imgPhoto.image!.jpegData(compressionQuality: 0.8) as Data?
        }
        
        do{
            if pc.hasChanges {
                try pc.save()
            }
        }catch {
            print(error)
            return
        }
        navigationController!.popViewController(animated: true)
        
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        self.resignFirstResponder()
    }
}
