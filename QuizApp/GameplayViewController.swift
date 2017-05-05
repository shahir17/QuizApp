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

    
    var questions = [String]()
    var number = [Int]()
    var questionSentence = [String]()
    var correctOption = [String]()
    var optionA = [String]()
    var optionB = [String]()
    var optionC = [String]()
    var optionD = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
        
        
        
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
            if let object = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                if let questionsArray = object!.value(forKey: "questions") as? NSArray {
                    for question in questionsArray {
                        if let questionDict = question as? NSDictionary {
                            if let correctOpt = questionDict.value(forKey: "correctOption") as? NSArray {
                                
                            }
                            if let questionSent = questionDict.value(forKey: "questionSentence") as? NSArray {
                                print(questionSent)
                            }
                            if let number = questionDict.value(forKey: "number") as? NSArray {
                                print(number)
                            }
                            if let opt = questionDict.value(forKey: "options")  {
                                print(opt)
                            }
                        }
                    }
                }
                //print(object)
                //print(object?.value(forKey: "numberOfQuestions"))
                //print(object?.value(forKey: "questions"))
            }
        }).resume()
    }
    
    
    
    }
