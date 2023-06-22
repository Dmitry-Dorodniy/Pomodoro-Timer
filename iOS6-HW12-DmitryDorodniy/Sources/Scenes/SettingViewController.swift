//
//  SettingViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 29.06.2022.
//

import UIKit

class SettingViewController: UIViewController {

    weak var delegate: SettingTimeProtocol?
    
    @IBAction func saveButton(_ sender: Any) {
        if  let time = checkText(setWorkTimeField.text ?? "") {
            delegate?.setWorkTime(to: time)
        }
        if  let time = checkText(setRestTimeField.text ?? "") {
            delegate?.setRestTime(to: time)
        }
        dismiss(animated: true)
    }

    @IBAction func defaultButton(_ sender: Any) {
        TimeModel.setTo = TimeModel()
        delegate?.resetTime()
        dismiss(animated: true)
    }

    @IBOutlet weak var setWorkTimeLabel: UILabel!
    @IBOutlet weak var setRestTimeLabel: UILabel!

    @IBOutlet weak var setWorkTimeField: UITextField!
    @IBOutlet weak var setRestTimeField: UITextField!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = Colors.settingViewBackgroundColor

        setWorkTimeLabel.text = "Set work time:"
        setWorkTimeField.placeholder = "Input here. Current time: \(TimeModel.setTo.work)"
        setRestTimeLabel.text = "Set rest time:"
        setRestTimeField.placeholder = "Input here. Current time: \(TimeModel.setTo.rest)"
    }

    func checkText(_ field: String) -> Int? {
        if let time = Int(field) {
            return abs(time)
        }
        return nil
    }
}

