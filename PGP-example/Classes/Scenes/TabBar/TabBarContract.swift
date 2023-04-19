//
//  TabBarContract.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterTabBarProtocol {
    var tabBarItems: [TabBarType] { get }
}

// MARK: Presenter -> View

protocol PresenterToViewTabBarProtocol: AnyObject {
    
}
