//
//  ViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 20.05.2022.
//

import UIKit

class ViewController: UIViewController {

    var isWorkTime = true
    var isStarted = false
    var timer = Timer()
    var time = Metric.timeToWork

    let imagePlay = UIImage(systemName: "play")
    let imageStop = UIImage(systemName: "pause")

    @IBOutlet weak var buttonStack: UIStackView!

    @IBAction func resetButton(_ sender: Any) {
        resetTime()
    }

    @IBAction func resumeButton(_ sender: Any) {
        changeInterface()
        resetTime()

    }

    private lazy var progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.viewBackgroundColor
        view.layer.cornerRadius = Metric.progressBarWidth * 0.5
        view.clipsToBounds = true
        view.layer.borderWidth = 4
        view.layer.borderColor = Colors.progressBarWorkColor

        return view
    }()

    @IBOutlet weak var timerLabel: UILabel!


    private lazy var playButton: UIButton = {
        let button = UIButton()
        //        let image = UIImage(systemName: "play")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)

        button.tintColor = UIColor(cgColor: Colors.progressBarWorkColor)
        button.setImage(imagePlay, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: UIImage.SymbolWeight.thin), forImageIn: .normal)
        //        button.imageView?.layer.transform = CATransform3DMakeScale(1.8, 1.8, 1.8)
        button.addTarget(self, action: #selector(PlayButtonAction), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupLayout()
        timerLabel.text = formatTimer()
    }

    private func setupView() {
        view.backgroundColor = Colors.viewBackgroundColor
    }

    private func setupHierarchy() {
        view.addSubview(progressBar)
        view.addSubview(timerLabel)
        progressBar.addSubview(playButton)
    }

    private func setupLayout() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -150).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: Metric.progressBarWidth).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: Metric.progressBarWidth).isActive = true

        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor, constant: -40).isActive = true


        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor, constant: Metric.progressBarWidth / 5).isActive = true

    }

    //  MARK: - Action
    @objc private func PlayButtonAction() {
        if !isStarted {
            timerLabel.text = formatTimer()
            isStarted = true
            startTimer()
            playButton.setImage(imageStop, for: .normal)
        } else {
            timer.invalidate()
            isStarted = false
            playButton.setImage(imagePlay, for: .normal)
        }
    }

    // MARK: - Change interface
    func workTimeInterface() {
        progressBar.layer.borderColor = Colors.progressBarWorkColor
        playButton.tintColor = UIColor(cgColor: Colors.progressBarWorkColor)
    }


    func restTimeInterface() {

        progressBar.layer.borderColor = Colors.progressBarRestColor
        playButton.tintColor = UIColor(cgColor: Colors.progressBarRestColor)
    }

    func changeInterface() {
        if isWorkTime {
            time = Metric.timeToRest
            restTimeInterface()
            timerLabel.text = formatTimer()
            isWorkTime = false

        } else {
            time = Metric.timeToWork
            workTimeInterface()
            timerLabel.text = formatTimer()
            isWorkTime = true
        }
    }

    func resetTime() {
        if isWorkTime {
            time = Metric.timeToWork
            timerLabel.text = formatTimer()
        } else {
            time = Metric.timeToRest
            timerLabel.text = formatTimer()
        }
    }


    // MARK: - Timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        guard time > 0 else {
            changeInterface()
            return
        }
        time -= 1
        timerLabel.text = formatTimer()
    }

    func formatTimer() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

// MARK: - Constants
enum Metric {
    static let progressBarWidth: CGFloat = 270
    static let timeToWork: Int = 1500
    static let timeToRest: Int = 300
}

enum Colors {
    static let viewBackgroundColor: UIColor = #colorLiteral(red: 0.05882352941, green: 0.1803921569, blue: 0.2470588235, alpha: 1)
    static let progressBarWorkColor: CGColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    static let progressBarRestColor: CGColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)

}

//extension UIView {
//
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//}
