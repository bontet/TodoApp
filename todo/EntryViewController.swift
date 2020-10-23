//
//  EntryViewController.swift
//  todo
//
//  Created by MacBook on 23/10/20.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
//    Add text field
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTodoData))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTodoData()
        return true
    }
    
    @objc func saveTodoData() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        guard let count  = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "todo_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
    

}
