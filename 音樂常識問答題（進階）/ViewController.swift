//
//  ViewController.swift
//  音樂常識問答題（進階）
//
//  Created by 蔡佳穎 on 2021/5/13.
//

import UIKit
import CodableCSV
import AVFoundation

extension Question {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "musicQuestions")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
            }
        }
        return array
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var questions = Question.data
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions.shuffle()
        questionLabel.text = "\(index+1)."+questions[index].question
        questionLabel.sizeToFit()
        questionLabel.frame = CGRect(x: 77, y: 55, width: 270, height: 100)
        questionLabel.numberOfLines = 0
        answerLabel.text = ""
    }

    @IBAction func showAnswer(_ sender: UIButton) {
        if index <= 9 {
            answerLabel.text = questions[index].answer
            answerLabel.sizeToFit()
            answerLabel.frame = CGRect(x: 30, y: 65, width: 279, height: 100)
            answerLabel.numberOfLines = 0
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        index += 1
        if index <= 9 {
            questionLabel.text = "\(index+1)."+questions[index].question
            questionLabel.sizeToFit()
            questionLabel.frame = CGRect(x: 77, y: 55, width: 270, height: 100)
            questionLabel.numberOfLines = 0
            answerLabel.text = ""
        }
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        questions.shuffle()
        index = 0
        questionLabel.text = "\(index+1)."+questions[index].question
        questionLabel.sizeToFit()
        questionLabel.frame = CGRect(x: 77, y: 55, width: 270, height: 100)
        questionLabel.numberOfLines = 0
        answerLabel.text = ""
    }
    
    @IBAction func speak(_ sender: UIButton) {
        let speak = AVSpeechUtterance(string: questions[index].question)
        speak.voice = AVSpeechSynthesisVoice(language: "it-IT")
        speak.pitchMultiplier = 1.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speak)
    }
}

