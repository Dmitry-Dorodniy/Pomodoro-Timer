//
//  SettingViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 29.06.2022.
//

import UIKit

class SettingViewController: UIViewController {

    var delegate: SettingTimeProtocol?
    
    @IBAction func saveButton(_ sender: Any) {
       let time = checkText()
//        TimeModel.timeSetTo.work = 50
        delegate?.setWorkTime(to: time)
        dismiss(animated: true)
    }


    @IBOutlet weak var setWorkTimeLabel: UILabel!
    @IBOutlet weak var setRestTimeLabel: UILabel!

    @IBOutlet weak var setWorkTimeField: UITextField!
    @IBOutlet weak var setRestTimeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.title = "Set timer values"
        view.backgroundColor = Colors.settingViewBackgroundColor

        setWorkTimeLabel.text = "Set work time:"
        setWorkTimeField.placeholder = "Input here. Current time: \(TimeModel.timeSetTo.work)"
        setRestTimeLabel.text = "Set rest time:"
        setRestTimeField.placeholder = "Input here. Current time: \(TimeModel.timeSetTo.rest)"
    }

    func checkText() -> Int {
        if let time = Int(setWorkTimeField.text ?? "") {
            return abs(time)
        }
        return TimeModel.timeSetTo.work
    }

}

