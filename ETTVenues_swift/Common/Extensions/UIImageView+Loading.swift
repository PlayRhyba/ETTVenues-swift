//
//  UIImageView+Loading.swift
//  ETTVenues_swift
//
//  Created by Alexander Snigurskyi on 2017-04-18.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import AFNetworking


extension UIImageView {
    
    func load(withURL url: URL?) {
        guard let u = url else {
            return
        }
        
        let request = NSMutableURLRequest(url: u)
        request.addValue("image/*", forHTTPHeaderField: "Accept")
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        indicator.color = UIColor.gray
        
        var i_frame = indicator.frame
        let x = self.frame.size.width / 2.0 - i_frame.size.width / 2.0
        let y = self.frame.size.height / 2.0 - i_frame.size.height / 2.0
        i_frame.origin = CGPoint(x: x, y: y)
        indicator.frame = i_frame
        
        self.addSubview(indicator)
        
        indicator.startAnimating()
        
        self.image = nil
        
        self.setImageWith(request as URLRequest,
                          placeholderImage: nil,
                          success: { (_, _, image) in
                            self.subviews.forEach({ $0.removeFromSuperview() })
                            self.image = image
        }) { (_, _, _) in
            self.subviews.forEach({ $0.removeFromSuperview() })
        }
    }
}
