//
//  GCCircularProgressView.swift
//  CGCircularProgressView
//
//  Created by Giancarlo Diaz Cavalcante on 06/06/18.
//  Copyright © 2018 Giancarlo Diaz Cavalcante. All rights reserved.
//

import UIKit

open class GCCircularProgressView: UIView {
    
    // ==================================================
    //
    //  MARK: - Private Properties
    //
    // ==================================================
    
    private let mainCircularShapeLayer = CAShapeLayer()
    private let pathCircularShapeLayer = CAShapeLayer()
    private var centerLabel = UILabel()
    
    // ==================================================
    //
    //  MARK: - Line Properties
    //
    // ==================================================
    
    
    /**
     The value of progress.

     Values may range between 0.0 and 1.0.  The default value for this property is 0.0.

     Values outside the range are pinned.
     */
    @IBInspectable
    open var progress: CGFloat {
        get {
            return self.mainCircularShapeLayer.strokeEnd
        }
        set {
            self.mainCircularShapeLayer.strokeEnd = self.pinProgress(forValue: newValue)
        }
    }
    
    
    /**
     The color of the circular path that will be animated.
     
     The default value for this property is a black color.
     */
    @IBInspectable
    open var progressTintColor: UIColor = .black {
        didSet {
            guard self.progressTintColor != oldValue else { return }
            self.mainCircularShapeLayer.strokeColor = self.progressTintColor.cgColor
        }
    }
    
    /**
     The color of the empty progress track (gets drawn over).
     
     The default value for this property is light gray color.
     */
    @IBInspectable
    open var trackTintColor: UIColor = .lightGray {
        didSet {
            guard self.trackTintColor != oldValue else { return }
            self.pathCircularShapeLayer.strokeColor = self.trackTintColor.cgColor
        }
    }
    
    /**
     Specifies the line width of the circular path that will be animated.
     
     The default value for this property is `10`.
     */
    @IBInspectable
    open var lineWidth: CGFloat = 10 {
        didSet {
            guard self.lineWidth != oldValue else { return }
            self.mainCircularShapeLayer.lineWidth = self.lineWidth
        }
    }
    
    /**
     Specifies the line width of the empty progress track.
     
     The default value for this property is `10`.
     */
    @IBInspectable
    open var trackLineWidth: CGFloat = 10 {
        didSet {
            guard self.trackLineWidth != oldValue else { return }
            self.pathCircularShapeLayer.lineWidth = self.trackLineWidth
        }
    }
    
    // ==================================================
    //
    //  MARK: - Center Text Properties
    //
    // ==================================================
    
    /**
     The color of the label inscribed in the circular path.
     
     The default value for this property is a black color.
     */
    @IBInspectable
    open var centerLabelColor: UIColor = .black {
        didSet {
            guard self.centerLabelColor != oldValue else { return }
            self.centerLabel.textColor = self.centerLabelColor
        }
    }
    
    /**
     The font of the label inscribed in the circular path.
     
     The default value for this property is the system font with size `15`.
     */
    open var centerLabelFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            guard self.centerLabelFont != oldValue else { return }
            self.centerLabel.font = self.centerLabelFont
        }
    }
    
    /**
     The text of the label inscribed in the circular path.
     
     The default value for this property is nil.
     */
    @IBInspectable
    open var centerLabelText: String? {
        didSet {
            guard self.centerLabelText != nil else { return }
            self.centerLabel.text = self.centerLabelText
        }
    }
    
    /**
     The styled text of the label inscribed in the circular path.
     
     The default value for this property is nil.
     */
    @IBInspectable
    open var centerLabelAttributedText: NSAttributedString? {
        didSet {
            guard self.centerLabelAttributedText != nil else { return }
            self.centerLabel.attributedText = self.centerLabelAttributedText
        }
    }
    
    // ==================================================
    //
    //  MARK: - Initializers
    //
    // ==================================================
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCircularProgressLayer(with: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.setupCircularProgressLayer(with: self)
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupCircularProgressLayer(with: self)
    }
    
    // ==================================================
    //
    //  MARK: - Private Methods
    //
    // ==================================================
    
    private func setupCenterLabel(with view: UIView, circleRadius: CGFloat) {
        let frameSideSize = circleRadius * sqrt(2.0)
        self.centerLabel = UILabel(frame: CGRect(x: (view.frame.size.width / 2) - (frameSideSize / 2),
                                                 y: (view.frame.size.height / 2) - (frameSideSize / 2),
                                                 width: frameSideSize,
                                                 height: frameSideSize))
        self.centerLabel.backgroundColor = .clear
        self.centerLabel.numberOfLines = 0
        self.centerLabel.textAlignment = .center
        self.centerLabel.textColor = self.centerLabelColor
        self.centerLabel.font = self.centerLabelFont
        self.centerLabel.text = self.centerLabelText
        self.centerLabel.attributedText = self.centerLabelAttributedText
        view.addSubview(self.centerLabel)
    }
    
    private func setupCAShapeLayer(with view: UIView, shapeLayer: CAShapeLayer, strokeColor: CGColor, lineWidth: CGFloat, strokeEnd: CGFloat? = nil, hasCenterLabel: Bool = false) {
        let center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        let shortestViewSize = view.frame.size.width > view.frame.size.height ? view.frame.size.height : view.frame.size.width
        let circleRadius = (shortestViewSize / 2.2) - lineWidth
        let startAngle = -CGFloat.pi / 2
        let endAngle = 1.5 * CGFloat.pi
        let circularPath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        if let layerStrokeEnd = strokeEnd {
            shapeLayer.strokeEnd = layerStrokeEnd
        }
        
        view.layer.addSublayer(shapeLayer)
        
        if hasCenterLabel {
            self.setupCenterLabel(with: view, circleRadius: circleRadius)
        }
    }
    
    private func setupCircularProgressLayer(with view: UIView) {
        self.setupCAShapeLayer(with: view, shapeLayer: self.pathCircularShapeLayer, strokeColor: self.trackTintColor.cgColor, lineWidth: self.trackLineWidth)
        self.setupCAShapeLayer(with: view, shapeLayer: self.mainCircularShapeLayer, strokeColor: self.progressTintColor.cgColor, lineWidth: self.lineWidth, strokeEnd: self.progress, hasCenterLabel: true)
    }
    
    // Pin certain values between 0.0 and 1.0
    private func pinProgress(forValue value: CGFloat, minValue: CGFloat = 0, maxValue: CGFloat = 1) -> CGFloat {
        return min(max(value, minValue), maxValue)
    }
    
    // ==================================================
    //
    //  MARK: - Public Methods
    //
    // ==================================================
    
    /**
    Sets the circular path progress value with the specified animationDuration, in seconds, and completion handler.

    The default value for the animationDuration is 0.3 seconds and for the completion is nil.
    */
    open func setProgress(_ progress: CGFloat, animationDuration: CFTimeInterval = 0.3, completion: (() -> Void)? = nil) {
        
        let newProgress = self.pinProgress(forValue: progress)
        
        CATransaction.begin()
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = self.progress
        basicAnimation.toValue = newProgress
        basicAnimation.duration = animationDuration
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        CATransaction.setCompletionBlock({
            self.progress = newProgress
            completion?()
        })
        self.mainCircularShapeLayer.add(basicAnimation, forKey: "layerAnimation")
        CATransaction.commit()
    }
}
