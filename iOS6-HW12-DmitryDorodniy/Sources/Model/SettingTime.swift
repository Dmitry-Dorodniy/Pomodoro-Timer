//
//  SettingViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 29.06.2022.
//

class SettingTime {

   var timeModel = TimeModel()

    func setWorkTime(in time: Int) {
        timeModel.timeToWork = time
    }

    func setRestTime(in time: Int) {
        timeModel.timeToRest = time
    }
}
