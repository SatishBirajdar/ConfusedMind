//
//  ItemPresenterTest.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-09-25.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import XCTest
//import Hamcrest

@testable import ConfusedMind

class ItemListPresenterTest: XCTestCase {
    
    var subject: ItemListPresenter!
    var view: ItemListPresenterViewSpy!
    
    override func setUp() {
        super.setUp()
        subject = ItemListPresenterImpl()
        view = ItemListPresenterViewSpy()
        subject.attachView(view: view)
    }
    
    func testGetItems(){
//        assertThat(view.displayItemsCalled, equalTo(1))
    }
}

class ItemListPresenterViewSpy: ItemListPresenterView {
    var displayItemsCalled = 0
    func displayItems(items: [Item]){
        displayItemsCalled += 1
    }
}

