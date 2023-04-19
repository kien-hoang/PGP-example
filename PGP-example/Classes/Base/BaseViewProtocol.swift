//
//  BaseViewProtocol.swift
//  Food Tracker iOS
//
//  Created by bradley.hoang99@gmail.com on 08/04/2023.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    func showLoading()
    func finishLoading()
    func showError(_ error: String)
}
