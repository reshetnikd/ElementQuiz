//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Dmitry Reshetnik on 06.04.2021.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case question
    case answer
}

class ViewController: UIViewController {
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    var mode: Mode = .flashCard
    var state: State = .question
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func showAnswer(_ sender: UIButton) {
        state = .answer
        updateUI()
    }
    
    @IBAction func next(_ sender: UIButton) {
        currentElementIndex += 1
        
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
        }
        state = .question
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    // Updates the app's UI in flash card mode.
    func updateFlachCardUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        
        imageView.image = image
        
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
    }
    
    // Updates the app's UI in quiz mode.
    func updateQuizUI() {
        
    }
    
    // Updates the app's UI based on its mode and state.
    func updateUI() {
        switch mode {
            case .flashCard:
                updateFlachCardUI()
            case .quiz:
                updateQuizUI()
        }
    }
}

