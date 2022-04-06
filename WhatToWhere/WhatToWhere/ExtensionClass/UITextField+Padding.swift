//
//  UITextField+Padding.swift
//  VLogMe
//
//  Created by macmini on 05/04/18.
//  Copyright © 2018 macmini. All rights reserved.
//

import UIKit

@IBDesignable
class UITextField_Padding: UITextField ,UITextFieldDelegate {
    private var realDelegate: UITextFieldDelegate?

    // Keep track of the text field's real delegate
    override var delegate: UITextFieldDelegate? {
        get {
            return realDelegate
        }
        set {
            realDelegate = newValue
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Make the text field its own delegate
        super.delegate = self
    }

    var textPadding = UIEdgeInsets(
        top: 10,
        left: 15,
        bottom: 10,
        right: 15
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Make the text field its own delegate
        super.delegate = self
    }

    // This is one third of the magic
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let realDelegate = realDelegate, realDelegate.responds(to: aSelector) {
            return realDelegate
        } else {
            return super.forwardingTarget(for: aSelector)
        }
    }

    // This is another third of the magic
    override func responds(to aSelector: Selector!) -> Bool {
        if let realDelegate = realDelegate, realDelegate.responds(to: aSelector) {
            return true
        } else {
            return super.responds(to: aSelector)
        }
    }

    func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func becomeFirstResponder() -> Bool {
//        backgroundColor = UIColor(red: 255/255.0, green: 0/255.0, blue:0/255.0, alpha: 1.0)
//        bottomColor = UIColor(red: 255/255.0, green: 0/255.0, blue:0/255.0, alpha: 1.0)
        super.becomeFirstResponder()

        return true
    }

    override func resignFirstResponder() -> Bool {
//        backgroundColor = UIColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.26)
        super.resignFirstResponder()
        return true
    }
    
    var bottomColor: UIColor = UIColor.clear {
        didSet {
            if bottomColor == UIColor.clear {
                self.borderStyle = .roundedRect
            } else {
                self.borderStyle = .bezel
            }
            self.setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor
    }

}
