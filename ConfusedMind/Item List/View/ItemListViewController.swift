//
//  ViewController.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-08-22.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import UIKit
import CoreData

class ItemListViewController: UITableViewController, UITextFieldDelegate {
    var items : [NSManagedObject] = []
    var presenter: ItemListPresenter = ItemListPresenterImpl()
    var managedContext = ManagedContext()
    
    var alertText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if #available(iOS 11.0, *) {
//            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.automatic
            
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        tableView?.dataSource = self
        tableView?.delegate = self
        self.presenter.attachView(view: self)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        items = managedContext.fetchItems()
    }
    
    @IBAction func editList(_ sender: UIBarButtonItem) {
        if sender.title == "Edit" {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
        } else {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
        }
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            let textField = alert.textFields?.first
            guard let nameToSave = textField?.text,  textField?.text != "" else {
                print("Textfield is empty")
                return
            }
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)

        alert.addTextField { (textField) in
            textField.delegate = self
            textField.autocapitalizationType = .words
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 20 // Bool
    }
    
    func save(name: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let entity =
            NSEntityDescription.entity(forEntityName: "Item",
                                       in: managedContext)!

        let item = NSManagedObject(entity: entity,
                                     insertInto: managedContext)

        item.setValue(name, forKeyPath: "name")

        do {
            try managedContext.save()
            items.append(item)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension ItemListViewController: ItemListPresenterView {
    func displayItems(items: [Item]) {
        self.items = items
    }
}

extension ItemListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableCell
        cell.itemName.text = item.value(forKeyPath: "name") as? String
        cell.row = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items.count)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        if editingStyle == .delete {
            // Delete the row from the data source
            print("item deleted")
            let itemToDelete = items[indexPath.row]
            items.remove(at: indexPath.row)
            managedContext.delete(itemToDelete)
            do {
                try managedContext.save()
                tableView.deleteRows(at: [indexPath], with: .left)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
         }
    }
    
}

extension ItemListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: false)
//        cell.isSelected = true
    }
}

class ItemTableCell: UITableViewCell, UITextViewDelegate {
    var row: Int = 0
    @IBOutlet weak var itemName: UITextView!
    
//    self.itemName.ShouldChangeText += delegate
//    {
//    if(itemName.Text.Length > 159) // limit to one sms length
//    {
//    return false;
//    }
//
//    return true;
//    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + (text.characters.count - range.length) <= 20
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Item")

        let editImage = UIImage.init(named: "editItem")
        let doneImage = UIImage.init(named: "doneEditItem")
        
        if (sender.imageView?.image?.isEqualToImage(image: editImage!))! {
            self.itemName.isEditable = true
            self.itemName.becomeFirstResponder()
            sender.setImage(doneImage, for: .normal)
        } else {
            self.itemName.isEditable = false
            self.itemName.resignFirstResponder()
            sender.setImage(editImage, for: .normal)
         
            do {
                let items = try managedContext.fetch(fetchRequest)
                let item = items[row]
                item.setValue(self.itemName.text, forKey: "name")
                
                //save the context
                do {
                    try managedContext.save()
                    print("saved!")
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                } catch {
                    
                }
                
            } catch {
                print("Error with request: \(error)")
            }
        }
    }
//    override var isSelected: Bool
//        {
//        didSet{
//            if (isSelected)
//            {
//                print("custom row selected \(self.itemName.text)")
//            }
//            else
//            {
//                print("custom row not selected")
//            }
//        }
//    }
}
