//
//  CircularProgressBarView.swift
//  iOS6-HW12-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 28.06.2022.
//

import UIKit

class CircularProgressBarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var circleLayer = CAShapeLayer()
    var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)

    func createCircularPath(tintColor: CGColor) {

        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                           y: frame.size.height / 2.0),
                                        radius: Metric.progressBarWidth/2,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 6.0
        circleLayer.strokeEnd = 1
        circleLayer.strokeColor = tintColor
        layer.addSublayer(circleLayer)

        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .butt
        progressLayer.lineWidth = 7.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = Colors.viewBackgroundColor.cgColor
        layer.addSublayer(progressLayer)
    }

    // MARK: - Animation for progress layer

    func progressAnimation(duration: TimeInterval) {

        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        //set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnimation")
    }
}
