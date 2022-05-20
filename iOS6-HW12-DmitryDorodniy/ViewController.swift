//
//  ViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 20.05.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var progressBar: UIView = {
let view = UIView()
        view.backgroundColor = Colors.viewBackgroundColor
        view.layer.cornerRadius = Metric.progressBarWidth * 0.5
        view.clipsToBounds = true
        view.layer.borderWidth = 4
        view.layer.borderColor = Colors.progressBarColor

        return view
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupLayout()

        // Do any additional setup after loading the view.
    }

    private func setupView() {
        view.backgroundColor = Colors.viewBackgroundColor
    }

    private func setupHierarchy() {
        view.addSubview(progressBar)

    }

    private func setupLayout() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: Metric.progressBarWidth).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: Metric.progressBarWidth).isActive = true

}

}

enum Metric {
    static let progressBarWidth: CGFloat = 240
}

enum Colors {
    static let viewBackgroundColor: UIColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    static let progressBarColor: CGColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
}
