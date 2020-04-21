//
//  TypeErasedView.swift
//
//  Created by Fernando Henrique Bonfim Moreno Del Rio on 21/04/20.
//  Copyright © 2020 Fernando Henrique Bonfim Moreno Del Rio. MIT License.
//

import Foundation

public protocol TypeErasedView {
    var typeErasedViewModel: ViewModel { get }
    func setupBindings()
}
