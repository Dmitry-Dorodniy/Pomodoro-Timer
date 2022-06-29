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

    @IBAction func skipButton(_ sender: Any) {
        changeInterface()
        resetTime()
    }

    private lazy var progressContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.viewBackgroundColor
        return view
    }()

    @IBOutlet weak var timerLabel: UILabel!

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(cgColor: Colors.progressBarWorkColor)
        button.setImage(imagePlay, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: UIImage.SymbolWeight.thin), forImageIn: .normal)
        button.addTarget(self, action: #selector(PlayButtonAction), for: .touchUpInside)
        return button
    }()

    var circularProgressBarView: CircularProgressBarView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupLayout()
        timerLabel.text = formatTimer()
    }

    private func setupView() {
        view.backgroundColor = Colors.viewBackgroundColor
       setupCircularProgressBarView()
        circularProgressBarView.createCircularPath(tintColor: Colors.progressBarWorkColor)
    }

    private func setupHierarchy() {
        view.addSubview(progressContainer)
        view.addSubview(timerLabel)
        progressContainer.addSubview(circularProgressBarView)
        progressContainer.addSubview(playButton)
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        progressContainer.translatesAutoresizingMaskIntoConstraints = false
        progressContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        progressContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: 50).isActive = true
        progressContainer.heightAnchor.constraint(equalToConstant: Metric.progressBarWidth).isActive = true
        progressContainer.widthAnchor.constraint(equalToConstant: Metric.progressBarWidth).isActive = true

        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: progressContainer.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: progressContainer.centerYAnchor,
                                            constant: -40).isActive = true

        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerXAnchor.constraint(equalTo: progressContainer.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: progressContainer.centerYAnchor,
                                            constant: Metric.progressBarWidth / 5).isActive = true

    }

    // MARK: - Setup Shape View

    func setupCircularProgressBarView() {
        //set view
        circularProgressBarView = CircularProgressBarView(frame: CGRect(x: 0,
                                                                        y: 0,
                                                                        width: Metric.progressBarWidth,
                                                                        height: Metric.progressBarWidth) )
    }

    //  MARK: - Button Play Pause

    @objc private func PlayButtonAction() {
        if !isStarted {
            timerLabel.text = formatTimer()
            isStarted = true
            startTimer()
            playButton.setImage(imageStop, for: .normal)
            circularProgressBarView.progressAnimation(duration: TimeInterval(time))
        } else {
            timer.invalidate()
            if let presentation = circularProgressBarView.progressLayer.presentation() {
            circularProgressBarView.progressLayer.strokeEnd = presentation.strokeEnd
            }
            circularProgressBarView.progressLayer.removeAnimation(forKey: "progressAnimation")
            isStarted = false
            playButton.setImage(imagePlay, for: .normal)
        }
    }

    // MARK: - Change interface
    func workTimeInterface() {

        circularProgressBarView.createCircularPath(tintColor: Colors.progressBarWorkColor)
        playButton.tintColor = UIColor(cgColor: Colors.progressBarWorkColor)
    }

    func restTimeInterface() {

       circularProgressBarView.createCircularPath(tintColor: Colors.progressBarRestColor)
        playButton.tintColor = UIColor(cgColor: Colors.progressBarRestColor)
    }

    func changeInterface() {
        if isWorkTime {
//            time = Metric.timeToRest
            restTimeInterface()
//            timerLabel.text = formatTimer()
            isWorkTime = false

        } else {
//            time = Metric.timeToWork
            workTimeInterface()
//            timerLabel.text = formatTimer()
            isWorkTime = true
        }
        resetTime()
    }

    // MARK: - Timer

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: (#selector(updateTimer)),
                                     userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        guard time > 0 else {
            changeInterface()
            return
        }
        time -= 1
        timerLabel.text = formatTimer()
    }

    func resetTime() {

        if isWorkTime {
            time = Metric.timeToWork
            circularProgressBarView.createCircularPath(tintColor: Colors.progressBarWorkColor)
            isStartedCheck()
        } else {
            time = Metric.timeToRest
            circularProgressBarView.createCircularPath(tintColor: Colors.progressBarRestColor)
            isStartedCheck()
        }
            timerLabel.text = formatTimer()
    }

    func isStartedCheck() {
        if isStarted {
            circularProgressBarView.progressAnimation(duration: TimeInterval(time)) }
    }

    func formatTimer() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}


