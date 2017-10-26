//
//  ItemPresenterContract.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-09-25.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import Foundation

protocol ItemListPresenterView{
    func displayItems(items: [Item])
}

protocol ItemListPresenter {
    func attachView(view: ItemListPresenterView)
}
