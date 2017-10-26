//
//  ItemPresenterImpl.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-09-25.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import Foundation

class ItemListPresenterImpl: ItemListPresenter {
    
    let items: [Item] = []
    var itemPresenterView: ItemListPresenterView!
    init() {
        
    }
    
    func attachView(view: ItemListPresenterView){
        itemPresenterView = view
        itemPresenterView.displayItems(items: self.items)
    }
}
