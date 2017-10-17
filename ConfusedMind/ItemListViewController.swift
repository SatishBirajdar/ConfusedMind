//
//  ViewController.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-08-22.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items: [Item]? = nil
    
    var presenter: ItemListPresenter!
    
    init(itemListPresentor: ItemListPresenter = ItemListPresenterImpl()) {
        super.init(nibName: "ItemListView", bundle: nil)
        self.presenter = itemListPresentor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Item List"
        self.navigationController?.navigationBar.backgroundColor = UIColor.red
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add1"), for: .normal)
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem?.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.presenter.attachView(view: self)
        
        
    }
    
    func addButtonClicked(){
        print("Clicked")
        self.navigationController?.pushViewController(AddListItemViewController(), animated: true)
    }
}

extension ItemListViewController: ItemListPresenterView {
    func displayItems(items: [Item]) {
        self.items = items
    }
}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var item = self.items?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableCell
        cell.itemName.text = item?.title

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ItemListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
//        cell.setSelected(true, animated: true)
        cell.isSelected = true
        
//        print("Row selected")
    }
}

class ItemTableCell: UITableViewCell {
    @IBOutlet weak var itemName: UITextView!
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        print("custom row selected")
//    }
    
    
    override var isSelected: Bool
        {
        didSet{
            if (isSelected)
            {
                print("custom row selected \(self.itemName.text)")
            }
            else
            {
                print("custom row not selected")
            }
        }
    }
}




