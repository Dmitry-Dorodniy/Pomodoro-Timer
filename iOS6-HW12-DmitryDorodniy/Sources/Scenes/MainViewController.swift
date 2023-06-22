//
//  ViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 20.05.2022.
//

import UIKit

protocol SettingTimeProtocol: AnyObject {
    func resetTime()
    func setWorkTime(to time: Int)
    func setRestTime(to time: Int)
}

class MainViewController: UIViewController {

    // MARK: - Properties
    private var isWorkTime = true
    private var isStarted = false
    private var accurateTimerCount = 1000
    private var timer = Timer()
    private var time = Int()

    var circularProgressBarView: CircularProgressBarView!

    private let imagePlay = UIImage(systemName: "play")
    private let imageStop = UIImage(systemName: "pause")

    // MARK: - Outlets
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!

    @IBAction func resetButton(_ sender: Any) {
        resetTime()
    }

    @IBAction func skipButton(_ sender: Any) {
        changeInterface()
        resetTime()
    }

    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .systemGray2
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(settingButtonAction), for: .touchUpInside)
        return button
    }()

    private lazy var progressContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.mainViewBackgroundColor
        return view
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(cgColor: Colors.progressBarWorkColor)
        button.setImage(imagePlay, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: UIImage.SymbolWeight.thin), forImageIn: .normal)
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTime()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    private func setupTime() {
        time = TimeModel.setTo.work
        timerLabel.text = formatTimer()
    }

    private func setupView() {
        view.backgroundColor = Colors.mainViewBackgroundColor
        setupCircularProgressBarView()
        circularProgressBarView.createCircularPath(tintColor: Colors.progressBarWorkColor)
    }

    private func setupHierarchy() {
        view.addSubview(progressContainer)
        view.addSubview(timerLabel)
        view.addSubview(settingButton)
        progressContainer.addSubview(circularProgressBarView)
        progressContainer.addSubview(playButton)
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        progressContainer.translatesAutoresizingMaskIntoConstraints = false
        progressContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        progressContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,
                                                   constant: -20).isActive = true
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

        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([buttonStack.topAnchor.constraint(equalTo: circularProgressBarView.bottomAnchor,
                                                                      constant: 20),
                                     buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),

                                     settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     settingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35)
        ])
    }

    // MARK: - Setup Shape View
    func setupCircularProgressBarView() {
        circularProgressBarView = CircularProgressBarView(frame: CGRect(x: 0,
                                                                        y: 0,
                                                                        width: Metric.progressBarWidth,
                                                                        height: Metric.progressBarWidth) )
    }

    //  MARK: - Buttons actions
    @objc private func playButtonAction() {
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

    @objc private func settingButtonAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController

        settingViewController.delegate = self
        self.present(settingViewController, animated: true)
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
        accurateTimerCount = 1000
        if isWorkTime {
            restTimeInterface()
            isWorkTime = false

        } else {
            workTimeInterface()
            isWorkTime = true
        }
        resetTime()
    }

    // MARK: - Timer update methods
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001,
                                     target: self,
                                     selector: (#selector(updateTimer)),
                                     userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if accurateTimerCount > 0 {
            accurateTimerCount -= 1
            return
        }

        accurateTimerCount = 1000

        guard time > 1 else {
            changeInterface()
            return
        }

        time -= 1
        timerLabel.text = formatTimer()
    }

    func resetTime() {
        accurateTimerCount = 1000
        if isWorkTime {
            time = TimeModel.setTo.work
            circularProgressBarView.createCircularPath(tintColor: Colors.progressBarWorkColor)
            isStartedCheck()
        } else {
            time = TimeModel.setTo.rest
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
        let time = Double(time)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: time) ?? "00:00"
    }
}

// MARK: - Extention
extension MainViewController: SettingTimeProtocol {
    func setWorkTime(to time: Int) {
        TimeModel.setTo.work = time
        resetTime()
    }

    func setRestTime(to time: Int) {
        TimeModel.setTo.rest = time
        resetTime()
    }
}
