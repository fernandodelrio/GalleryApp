//
//  View.swift
//
//  Created by Fernando del Rio on 21/04/20.
//  Copyright © 2020 Fernando del Rio. MIT License.
//

public protocol View: TypeErasedView {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get }
}

public extension View {
  var typeErasedViewModel: ViewModel { viewModel }
}
