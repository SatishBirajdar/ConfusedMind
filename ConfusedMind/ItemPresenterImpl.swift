//
//  ItemPresenterImpl.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-09-25.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import Foundation

class ItemListPresenterImpl: ItemListPresenter {
    
//    let stringArray: [Item] = [Item(title: "Apple"), Item(title: "Apricot"), Item(title: "Banana")]
    
    let items: [Item] = ItemService().getItems()
    
    var itemPresenterView: ItemListPresenterView!
    init() {
        
    }
    
    func attachView(view: ItemListPresenterView){
        itemPresenterView = view
        itemPresenterView.displayItems(items: self.items)
    }
}
