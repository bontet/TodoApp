//
//  ViewController.swift
//  todo
//
//  Created by MacBook on 23/10/20.
//

import UIKit

class ViewController: UIViewController {
    
//    untuk deleget properti yang dapat digunakan
    @IBOutlet var tableView: UITableView!
    
    var isTodoData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Todo"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTodo()
        
    }
    
    func updateTodo() {
//        remove All Data before updated
        isTodoData.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for t in 0..<count {
            if let todo = UserDefaults().value(forKey: "todo_\(t+1)") as? String {
                isTodoData.append(todo)
            }
        }
        
//        refresh tableview
        tableView.reloadData()
    }
    
//    @ibAction untuk
    @IBAction func didTabAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Todo"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTodo()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        Select 1 row on table
        let vc = storyboard?.instantiateViewController(identifier: "todo") as! TodoViewController
        vc.title = "Update todo"
        vc.todo = isTodoData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isTodoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = isTodoData[indexPath.row]
        
        return cell
    }
}

