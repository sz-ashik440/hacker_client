//
//  LoadingFooter.swift
//  Hacker Client
//
//  Created by Admin on 8/5/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit

class LoadingFooter: UIView {
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        loadingIndicator.startAnimating()
    }
}
