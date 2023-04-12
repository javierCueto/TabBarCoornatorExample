//
//  UserConfigurationCoordinator.swift
//  TabBarCoornatorExample
//
//  Created by Javier Cueto on 12/04/23.
//

protocol UserConfigurationCoordinatorDelegate: AnyObject {
  func didFinish()
}

final class UserConfigurationCoordinator: Coordinator {
  var navigation: Navigation
  private let factory: UserConfigurationFactory
  private weak var delegate: UserConfigurationCoordinatorDelegate?
  
  init(
    navigation: Navigation,
    factory: UserConfigurationFactory,
    delegate: UserConfigurationCoordinatorDelegate
  ) {
    self.navigation = navigation
    self.factory = factory
    self.delegate = delegate
  }
  
  func start() {
    let controller = factory.makeUserConfigurationViewController(coordinator: self)
    navigation.viewControllers = [controller]
  }
}

extension UserConfigurationCoordinator: UserConfigurationViewControllerCoordinator {
  func didFinishFlow() {
    delegate?.didFinish()
  }
  
  func didSelectAvatarButton() {
    navigation.pushViewController(factory.makeAvatarViewController(), animated: true)
  }
}