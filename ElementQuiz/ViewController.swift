//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Dmitry Reshetnik on 06.04.2021.
//

import UIKit

class ViewController: UIViewController {
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateElement()
    }

    func updateElement() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        
        imageView.image = image
        answerLabel.text = "?"
    }
}

