//
//  UIStoryboard.swift
//  NSFWExample
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import UIKit

extension UIStoryboard {    
    static func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func instantiateResultsViewController() -> ResultViewController {
        let vc = UIStoryboard.main().instantiateViewController(withIdentifier: String(describing: ResultViewController.self))
        return vc as! ResultViewController
    }
    
}
