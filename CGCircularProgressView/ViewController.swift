//
//  ViewController.swift
//  CGCircularProgressView
//
//  Created by Giancarlo Diaz Cavalcante on 06/06/18.
//  Copyright © 2018 Giancarlo Diaz Cavalcante. All rights reserved.
//

import UIKit

class Controller {
    
}


class ViewController: UIViewController {
    @IBOutlet weak var circularProgressView: GCCircularProgressView!
    @IBOutlet weak var stepperView: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepperView.value = Double(self.circularProgressView.progress * 100)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    @IBAction func didTapStepper(sender: UIStepper) {
        let progress = sender.value / 100
        self.circularProgressView.progress = CGFloat(progress)
//        self.runCircularTimeAnimation()
    }
    
    func runCircularTimeAnimation() {
        self.circularProgressView.setProgress(1, animationDuration: 2) {
            print("progress completed")
        }
    }
}

