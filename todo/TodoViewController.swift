//
//  TodoViewController.swift
//  todo
//
//  Created by MacBook on 23/10/20.
//

import UIKit

class TodoViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var todo: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = todo
        
//        Navigation when delete button is clicked
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTodo))
    }
    
    @objc func deleteTodo() {
        
    }


}
