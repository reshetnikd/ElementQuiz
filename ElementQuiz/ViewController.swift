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
    case score
}

class ViewController: UIViewController, UITextFieldDelegate {
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    var state: State = .question
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
                case .flashCard:
                    setupFlashCards()
                case .quiz:
                    setupQuiz()
            }
            
            updateUI()
        }
    }
    
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
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
            
            if mode == .quiz {
                state = .score
                updateUI()
                return
            }
        }
        state = .question
        updateUI()
    }
    
    @IBAction func switchModes(_ sender: UISegmentedControl) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    // Updates the app's UI in flash card mode.
    func updateFlachCardUI(elementName: String) {
        // Text field and keyboard
        textField.isHidden = true
        textField.resignFirstResponder()
        
        // Answer label
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
        
        // Segmented control
        modeSelector.selectedSegmentIndex = 0
    }
    
    // Updates the app's UI in quiz mode.
    func updateQuizUI(elementName: String) {
        // Text field and keyboard
        textField.isHidden = false
        
        switch state {
            case .question:
                textField.text = ""
                textField.becomeFirstResponder()
            case .answer:
                textField.resignFirstResponder()
            case .score:
                textField.isHidden = true
                textField.resignFirstResponder()
        }
        
        // Answer label
        switch state {
            case .question:
                answerLabel.text = ""
            case .answer:
                if answerIsCorrect {
                    answerLabel.text = "✓"
                } else {
                    answerLabel.text = "✗"
                }
            case .score:
                answerLabel.text = ""
        }
        
        // Score display
        if state == .score {
            displayScoreAlert()
        }
        
        // Segmented control
        modeSelector.selectedSegmentIndex = 1
    }
    
    // Updates the app's UI based on its mode and state.
    func updateUI() {
        // Shared code: updating the image
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        
        imageView.image = image
        
        // Mode-specific UI updates are split into two methods for readability
        switch mode {
            case .flashCard:
                updateFlachCardUI(elementName: elementName)
            case .quiz:
                updateQuizUI(elementName: elementName)
        }
    }
    
    // Runs after the user hits the Return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Get the text from the text field
        let textFieldContents = textField.text!
        
        // Determine whether the user answered correctly and update appropriate quiz state
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        // The app should now display the answer to the user
        state = .answer
        updateUI()
        
        // Debugging
        if answerIsCorrect {
            print("✓")
        } else {
            print("✗")
        }
        
        return true
    }
    
    // Shows an iOS alert with the user's quiz score.
    func displayScoreAlert() {
        let alert = UIAlertController(title: "Quiz Score", message: "Your score is \(correctAnswerCount) out of \(elementList.count).", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    // Sets up a new flash card session.
    func setupFlashCards() {
        state = .question
        currentElementIndex = 0
    }
    
    // Sets up a new quiz.
    func setupQuiz() {
        state = .question
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
    }
}

