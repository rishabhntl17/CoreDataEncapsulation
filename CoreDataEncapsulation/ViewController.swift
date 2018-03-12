//
//  ViewController.swift
//  CoreDataEncapsulation
//
//  Created by Appinventiv on 3/8/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user = [User]()
    
    @IBOutlet weak var displayTableView: UITableView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var mobileLabel: UITextField!
    @IBOutlet weak var deleteAllButtonOutlet: UIButton!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var getButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonOutlet.layer.cornerRadius = saveButtonOutlet.bounds.height/2
        deleteButtonOutlet.layer.cornerRadius = deleteButtonOutlet.bounds.height/2
        getButtonOutlet.layer.cornerRadius = getButtonOutlet.bounds.height/2
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.nameLabel.center.x += self.view.bounds.width
            self.mobileLabel.center.x -= self.view.bounds.width
            self.displayTableView.center.y -= self.view.bounds.height
        })
        UIView.animate(withDuration: 5.0) {
            self.displayTableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.displayTableView.layer.borderWidth = 1.0
            self.displayTableView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        deleteAllButtonOutlet.layer.shadowColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        deleteAllButtonOutlet.layer.shadowOpacity = 0.5
        displayTableView.delegate = self
        displayTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.center.x -= self.view.bounds.width
        self.mobileLabel.center.x += self.view.bounds.width
        self.displayTableView.center.y += self.view.bounds.height
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
        let newUser = CoreDataManager.getUser(entityName: "User") as! User
        newUser.name = nameLabel.text!
        newUser.mobile = mobileLabel.text!
        user.append(newUser)
        CoreDataManager.saveData(entityName: "User")
    }
    @IBAction func getButtonAction(_ sender: UIButton) {
        user = CoreDataManager.getData(entityName: "User") as! [User]
        for userInfo in user
        {
            print(userInfo.name ?? "")
            print(userInfo.mobile ?? "")
            
        }
        displayTableView.reloadData()
        
        let cells = displayTableView.visibleCells
        let tableViewHeight = displayTableView.bounds.height
        for cell in cells
        {
            cell.transform = CGAffineTransform(translationX: displayTableView.bounds.width/2, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells
        {
            UIView.animate(withDuration: 3, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        CoreDataManager.deleteData(entityName: "User", toDelete: nameLabel.text!)
    }
    @IBAction func deleteAllAction(_ sender: UIButton) {
        let bounds = deleteAllButtonOutlet.bounds
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.deleteAllButtonOutlet.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }) { (success : Bool) in
            if success {
                self.deleteAllButtonOutlet.bounds = bounds
            }
        }
        CoreDataManager.deleteAllData(entityName: "User")
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        user = CoreDataManager.getData(entityName: "User") as! [User]
        for userInfo in user
        {
            if userInfo.name == nameLabel.text!
            {
                userInfo.mobile = mobileLabel.text!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = displayTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let person = user[indexPath.row]
        cell.titleLabel.text = person.name
        cell.detailLabel.text = person.mobile
        return cell
    }
}

