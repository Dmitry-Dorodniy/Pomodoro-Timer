//
//  ViewController.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 20.05.2022.
//

import UIKit

class ViewController: UIViewController {

    var isWorkTime = Bool()
    var isStarted = Bool()
    let imagePlay = UIImage(systemName: "play")
    let imageStop = UIImage(systemName: "stop")



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

        playButton.tintColor = UIColor(cgColor: Colors.progressBarWorkColor)
        button.setImage(imagePlay, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: UIImage.SymbolWeight.thin), forImageIn: .normal)
        //        button.imageView?.layer.transform = CATransform3DMakeScale(1.8, 1.8, 1.8)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupLayout()




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
    @objc private func buttonAction() {
        //
    }


}



enum Metric {
    static let progressBarWidth: CGFloat = 270
}

enum Colors {
    static let viewBackgroundColor: UIColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    static let progressBarWorkColor: CGColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)

}

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
