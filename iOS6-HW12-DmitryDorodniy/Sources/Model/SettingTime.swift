//
//  SettingViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 29.06.2022.
//

class SettingTime {

    var timeModel = TimeModel(work: 1500, rest: 300) {
        didSet {
            print(timeModel)
        }
    }

    func setWorkTime(in time: Int) {
        timeModel.work = time
    }

    func setRestTime(in time: Int) {
        timeModel.rest = time
    }
}
