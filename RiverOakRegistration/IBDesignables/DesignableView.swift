//
//  DesignableView.swift
//  RiverOakRegistration
//
//  Created by Yaser Abou Elenein on 18/2/18.
//  Copyright © 2018 Yaser Abouelenein. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
