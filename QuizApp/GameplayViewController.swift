//
//  GameplayViewController.swift
//  QuizApp
//
//  Created by Shahir Abdul-Satar on 5/4/17.
//  Copyright © 2017 Ahmad Shahir Abdul-Satar. All rights reserved.
//

import UIKit

class GameplayViewController: UIViewController, URLSessionDelegate {
    
    
    
    @IBOutlet weak var p1AnswerLabel: UILabel!
    
    @IBOutlet weak var p2AnswerLabel: UILabel!
    
    @IBOutlet weak var p3AnswerLabel: UILabel!
    
    @IBOutlet weak var p4AnswerLabel: UILabel!
    
    
    @IBOutlet weak var p1Image: UIImageView!
    
    @IBOutlet weak var p2Image: UIImageView!
    
    @IBOutlet weak var p3Image: UIImageView!
    
    @IBOutlet weak var p4Image: UIImageView!
    
    @IBOutlet weak var p1ScoreLabel: UILabel!
    
    @IBOutlet weak var p2ScoreLabel: UILabel!
    
    @IBOutlet weak var p3ScoreLabel: UILabel!
    
    @IBOutlet weak var p4ScoreLabel: UILabel!
    
    @IBOutlet weak var qNumLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var answerALabel: UILabel!
    
    @IBOutlet weak var answerBLabel: UILabel!
    
    @IBOutlet weak var answerCLabel: UILabel!
    
    @IBOutlet weak var answerDLabel: UILabel!
    
    @IBOutlet weak var winLoseLabel: UILabel!
    
    @IBAction func restartQuizButton(_ sender: Any) {
    }

    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    var questions = [String]()
    var number = [Int]()
    var questionSentence = [String]()
    var correctOption = [String]()
    var optionA = [String]()
    var optionB = [String]()
    var optionC = [String]()
    var optionD = [String]()
    var currentRound = 0
    
    var lastTapped:UILabel?
    var isPlayable = true
    var defaultLabelColor: UIColor?
    
    var score = 0
    var multiplayer = false
    var numPlayers = 1
    
    var roundTimer: Timer?
    var time = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
        printQuestions()
        
        if numPlayers == 1 {
            p2AnswerLabel.isHidden = true
            p2Image.isHidden = true
            p2ScoreLabel.isHidden = true
            p3AnswerLabel.isHidden = true
            p3Image.isHidden = true
            p3ScoreLabel.isHidden = true
            p4AnswerLabel.isHidden = true
            p4Image.isHidden = true
            p4ScoreLabel.isHidden = true
        }
        
        defaultLabelColor = answerALabel.backgroundColor
       
        let answerTapA = UITapGestureRecognizer(target: self, action: #selector(self.tapAnswer))
        let answerTapB = UITapGestureRecognizer(target: self, action: #selector(self.tapAnswer))
        let answerTapC = UITapGestureRecognizer(target: self, action: #selector(self.tapAnswer))
        let answerTapD = UITapGestureRecognizer(target: self, action: #selector(self.tapAnswer))
        answerALabel.addGestureRecognizer(answerTapA)
        answerBLabel.addGestureRecognizer(answerTapB)
        answerCLabel.addGestureRecognizer(answerTapC)
        answerDLabel.addGestureRecognizer(answerTapD)
        answerALabel.isUserInteractionEnabled = true
        answerBLabel.isUserInteractionEnabled = true
        answerCLabel.isUserInteractionEnabled = true
        answerDLabel.isUserInteractionEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func readJSONData(_ object: [String: AnyObject]) {
        if let title = object["title"] as? String,
            let version = object["swiftVersion"] as? Float,
            let users = object["users"] as? [[String: AnyObject]] {
            
            for user in users {
                
                print("\(user["name"]!) is \(user["age"]!) years old")
            }
        }
    }

    
    
    
    
    func getJSONData(){
        
        let urlString = "http://www.people.vcu.edu/~ebulut/jsonFiles/quiz1.json"
        let url = URL(string: urlString)
        let session = URLSession.shared
        _ = session.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            if let object = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] ,
                let questions = object?["questions"] as? [[String: Any]]
            {
                for question in questions {
                    //print(question["number"]!)
                    self.number.append(question["number"]! as! Int)
                    //print(question["questionSentence"]!)
                    self.questionSentence.append(question["questionSentence"]! as! String)
                    self.correctOption.append(question["correctOption"]! as! String)
                    
                    if let options = question["options"] as? [String: Any] {
                        self.optionA.append("A: " + (options["A"]! as! String))
                        self.optionB.append("B: " + (options["B"]! as! String))
                        self.optionC.append("C: " + (options["C"]! as! String))
                        self.optionD.append("D: " + (options["D"]! as! String))
                    }
                }
                self.nextQuestion()
            }
        }).resume()
    }
    
    func printQuestions() {
        print(questionSentence)
    }
    
    func nextQuestion() {
        answerALabel.backgroundColor = defaultLabelColor
        answerBLabel.backgroundColor = defaultLabelColor
        answerCLabel.backgroundColor = defaultLabelColor
        answerDLabel.backgroundColor = defaultLabelColor
        
        p1AnswerLabel.text = "?"
        p2AnswerLabel.text = "?"
        p3AnswerLabel.text = "?"
        p4AnswerLabel.text = "?"
        
        roundTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeLeft), userInfo: nil, repeats: true)
        
        if currentRound < questionSentence.count {
            
            self.questionLabel.text = self.questionSentence[currentRound]
            self.answerALabel.text = self.optionA[currentRound]
            self.answerBLabel.text = self.optionB[currentRound]
            self.answerCLabel.text = self.optionC[currentRound]
            self.answerDLabel.text = self.optionD[currentRound]
            self.qNumLabel.text = "Question \(currentRound + 1)"
            
            
            
            isPlayable = true
        } else {
            // TODO: end game
            isPlayable = false
            self.questionLabel.text = "Game over!"
            self.answerALabel.text = ""
            self.answerBLabel.text = ""
            self.answerCLabel.text = ""
            self.answerDLabel.text = ""
            self.qNumLabel.text = ""
            stopTimer()
        }
        
    }
    
    func submitAnswer(answer: Character) {
        if multiplayer {
            // Send answer to players
        } else {
            stopTimer()
            showAnswer(String(answer))
        }
    }
    
    func showAnswer(_ picked: String ) {
        if correctOption[currentRound] == picked {
            score += 1
            var label: UILabel?
            switch picked {
            case "A":
                label = answerALabel
            case "B":
                label = answerBLabel
            case "C":
                label = answerCLabel
            case "D":
                label = answerDLabel
            default:
                break
            }
            
            label?.backgroundColor = UIColor.green
        } else {
            var correctLabel: UILabel?
            var pickedLabel: UILabel?
            
            switch correctOption[currentRound] {
            case "A":
                correctLabel = answerALabel
            case "B":
                correctLabel = answerBLabel
            case "C":
                correctLabel = answerCLabel
            case "D":
                correctLabel = answerDLabel
            default:
                break
            }
            
            switch picked {
            case "A":
                pickedLabel = answerALabel
            case "B":
                pickedLabel = answerBLabel
            case "C":
                pickedLabel = answerCLabel
            case "D":
                pickedLabel = answerDLabel
            default:
                break
            }
            correctLabel?.backgroundColor = UIColor.green
            pickedLabel?.backgroundColor = UIColor.red
        }
        currentRound += 1
        lastTapped = nil
        p1ScoreLabel.text = String(score)
        isPlayable = false
        p1AnswerLabel.text = picked
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
    }
    
    func timeLeft() {
        time -= 1
        timeLabel.text = String(time)
        if time < 1 {
            time = 20
            showAnswer("")
            stopTimer()
        }
    }
    
    func stopTimer() {
        roundTimer?.invalidate()
        roundTimer = nil
        time = 20
    }
    
    func tapAnswer(sender: UITapGestureRecognizer) {
        if !isPlayable {
            return
        }
        if let label = sender.view as? UILabel {
            if label == lastTapped {
                submitAnswer(answer: (label.text?.characters.first)!)
            } else {
                lastTapped?.backgroundColor = defaultLabelColor
                label.backgroundColor = UIColor.yellow
                lastTapped = label
            }
        }
    }
    
}
