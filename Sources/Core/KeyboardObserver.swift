//
//  KeyboardObserver.swift
//  Core
//
//  Created by Pérsio on 25/09/20.
//

import UIKit

/// The abstraction that handles keyboard notifications.
public class KeyboardObserver {
    
    // MARK: - Actions
    
    /// The action called when keyboard appeared.
    public var onKeyboardAppeared: ((_ notification: Notification) -> Void)?
    
    /// The action called when keyoard disappeard.
    public var onKeyboardDisappearerd: ((_ notification: Notification) -> Void)?
    
    // MARK: - Properties
    
    private let notification: NotificationCenter
    
    // MARK: - Initialiazer
    
    /// Creates an observer object with a received notification
    /// - Parameter notification: The received notification.
    public init(notification: NotificationCenter = .default) {
        self.notification = notification
        registerNotifications()
    }
    
    // MARK: - Notification
    
    /// Register notifications.
    func registerNotifications() {
        notification.addObserver(self,
                                 selector: #selector(keyboardWillAppear(notification:)),
                                 name: UIResponder.keyboardWillShowNotification,
                                 object: nil)
        notification.addObserver(self,
                                 selector: #selector(keyboardWillDisappear(notification:)),
                                 name: UIResponder.keyboardWillHideNotification,
                                 object: nil)
    }
    
    @objc
    private func keyboardWillAppear(notification: Notification) {
        onKeyboardAppeared?(notification)
    }
    
    @objc
    private func keyboardWillDisappear(notification: Notification) {
        onKeyboardDisappearerd?(notification)
    }
    
    // MARK: - Deinitializer
    
    deinit {
        notification.removeObserver(self)
    }
}
