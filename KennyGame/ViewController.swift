//
//  ViewController.swift
//  KennyGame
//
//  Created by Emircan saglam on 5.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLAbel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var kenny: UIImageView!
    @IBOutlet weak var highScore: UILabel!
    
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var hideTimer = Timer()
    var highSc = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highSc = 0
            highScore.text = "Yüksek Skor: \(highSc)"
        }
        if let newScore = storedHighScore as? Int {
            highSc = newScore
            highScore.text = "Yüksek Skor: \(highSc)"
        }
        
        
        kenny.isUserInteractionEnabled = true
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny.addGestureRecognizer(recognizer)
        
        counter = 10
        timeLAbel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }
    
    @objc func hideKenny(){
        kenny.isHidden = true
        
        kenny.center = CGPoint(x: CGFloat.random(in: 52...266), y: CGFloat.random(in: 266...518))

        kenny.isHidden = false
        
    }
    
    
    
    @objc func increaseScore () {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLAbel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            kenny.isHidden = true
            
            if self.score > self.highSc {
                self.highSc = self.score
                self.highScore.text = "Yüksek Skor: \(self.highSc)"
                UserDefaults.standard.set(self.highSc, forKey: "highscore")
                
            }
            
            let alert = UIAlertController(title: "Süre Doldu!", message: "Tekrar oynamak ister misiniz?", preferredStyle: UIAlertController.Style.alert)
            let button = UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLAbel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(button)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}

