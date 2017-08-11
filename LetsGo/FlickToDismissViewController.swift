//
//  FlickToDismissViewController.swift
//  Example
//
//  Created by Jake Lawson on 04/06/2016.
//  Copyright © 2016 Jake Lawson. All rights reserved.
//

import UIKit

/// Options used to customize the appearance and interaction.
public enum FlickToDismissOption {
    case BackgroundColor(UIColor)
    case FlickThreshold(CGFloat)
    case FlickVelocityMultiplier(CGFloat)
    case SnapDamping(CGFloat)
    case Animation(AnimationType)
}

/// Different animation styles for presenting the flickable view.
public enum AnimationType: String {
    case None
    case Scale
}

/// Presents a UIView which can dismissed by flicking it off the screen.
@IBDesignable
public class FlickToDismissViewController: UIViewController {

    // MARK:- Properties
    
    /// Flickable UIView.
    @IBOutlet public var flickableView: UIView!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    /// Array of FlickToDismissOptions.
    private var options: [FlickToDismissOption]?
    /// Indicates how fast the view must be moving in order to have the view continue moving.
    @IBInspectable public var flickThreshold: CGFloat = 1000
    /// The amount of oscillation of the flickableView during the conclusion of a snap.
    @IBInspectable public var snapDamping: CGFloat = 0.5
    /// Affects how fast or slow the view is flicked off the screen.
    @IBInspectable public var flickVelocityMultiplier: CGFloat = 0.2
    /// Animation presentation type. See AnimationType for all possible values.
    @IBInspectable public var animationType: String = "None"
    /// The point for the flickable view to return to if the view was not flicked off the screen
    public var originalCenter: CGPoint?
    // UIKit Dynamics
    private var animator: UIDynamicAnimator!
    private var attachmentBehavior: UIAttachmentBehavior!
    private var snapBehaviour: UISnapBehavior!
    private var pushBehaviour: UIPushBehavior!
    
    // MARK:- Life Cycle
    
    public init(flickableView: UIView, options: [FlickToDismissOption]?) {
        super.init(nibName: nil, bundle: nil)
        self.flickableView = flickableView
        self.options = options
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Perform animation when view will appear
        switch AnimationType.init(rawValue: animationType) ?? .None {
        case .Scale:
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: ({
                self.flickableView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.flickableView.alpha = 1.0
            }), completion: nil)
        default:
            break
        }
    }
    
    // MARK:- Setup

    private func setup() {
        // Setup pan gesture
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleAttachmentGesture(panGesture:)))
        // Setup animator
        animator = UIDynamicAnimator(referenceView: view)
        // Apply options
        if let options = options {
            for option in options {
                switch option {
                case .BackgroundColor(let color):
                    view.backgroundColor = color
                case .FlickThreshold(let threshold):
                    flickThreshold = threshold
                case .FlickVelocityMultiplier(let multiplier):
                    flickVelocityMultiplier = multiplier
                case .SnapDamping(let damping):
                    snapDamping = damping
                case .Animation(let animation):
                    animationType = animation.rawValue
                }
            }
        }
        // Setup animation
        switch AnimationType.init(rawValue: animationType) ?? .None {
        case .Scale:
            flickableView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            flickableView.alpha = 0.0
        default:
            break
        }
        flickableView.addGestureRecognizer(panGestureRecognizer)
        // If there are no constraints, center the view
        if flickableView.constraints.count == 0 {
            flickableView.center = view.center
        }
        view.addSubview(flickableView)
    }
    
    // MARK: Layout
    
    public override func viewDidLayoutSubviews() {
        // Only set the center if the view has constraints
        if flickableView.constraints.count != 0 {
            originalCenter = flickableView.center
        }
    }
    
    // MARK:- Pan Gesture
    
    @objc private func handleAttachmentGesture(panGesture: UIPanGestureRecognizer) {
        let location = panGesture.location(in: view)
        let boxLocation = panGesture.location(in: flickableView)
        switch panGesture.state {
        case .began:
            animator.removeAllBehaviors()
            let centerOffset = UIOffset(horizontal: boxLocation.x-flickableView.bounds.midX, vertical: boxLocation.y-flickableView.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: flickableView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            animator.addBehavior(attachmentBehavior)
        case .ended:
            animator.removeAllBehaviors()
            let velocity = panGesture.velocity(in: view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            guard magnitude > flickThreshold else {
                snapBehaviour = UISnapBehavior(item: flickableView, snapTo: originalCenter ?? view.center)
                snapBehaviour.damping = snapDamping
                animator.addBehavior(snapBehaviour)
                return
            }
            let centerOffset = UIOffset(horizontal: boxLocation.x-flickableView.bounds.midX, vertical: boxLocation.y-flickableView.bounds.midY)
            pushBehaviour = UIPushBehavior(items: [flickableView], mode: .instantaneous)
            pushBehaviour.pushDirection = CGVector(dx: velocity.x, dy: velocity.y)
            pushBehaviour.setTargetOffsetFromCenter(centerOffset, for: flickableView)
            pushBehaviour.magnitude = magnitude * flickVelocityMultiplier
            animator.addBehavior(pushBehaviour)
            dismiss(animated: true, completion: nil)
        default:
            attachmentBehavior.anchorPoint = location
        }
    }
    
    // MARK:- Helpers
    
    /// Connect this to a button to dismiss the view controller.
    @IBAction public func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Rotation
    
    public  func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        // Remove behaviors on rotation in order to satisfy constraints
        animator.removeAllBehaviors()
        // Center view if there are no constraints
        if flickableView.constraints.count == 0 {
            flickableView.center = CGPoint(x: size.width/2, y: size.height/2)
        }
    }
    
}
