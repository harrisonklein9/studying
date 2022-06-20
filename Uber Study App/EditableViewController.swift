//
//  EditableViewController.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit
import PencilKit

class EditableViewController: UIViewController {
    
    lazy var pencilView: PKCanvasView = {
        let pencilView = PKCanvasView(frame: view.bounds)
        pencilView.backgroundColor = .clear
        
        return pencilView
    }()
    
    private lazy var toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        return toolPicker
    }()
    
    
    private var editedView: UIView?
    
    var state = PencilViewState.hidden
    
    public enum PencilViewState {
        case visible
        case hidden
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(togglePencil))
        DispatchQueue.main.async { [weak self] in
            guard let pencilView = self?.pencilView else { return }
            self?.view.addSubview(pencilView)
        }
        pencilView.isUserInteractionEnabled = false
        toolPicker.setVisible(true, forFirstResponder: pencilView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toolPicker.addObserver(pencilView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        toolPicker.removeObserver(pencilView)
    }
    
    @objc func togglePencil() {
        if state == .hidden {
            pencilView.becomeFirstResponder()
            pencilView.isUserInteractionEnabled = true
            state = .visible
        } else {
            pencilView.isUserInteractionEnabled = false
            pencilView.resignFirstResponder()
            state = .hidden
        }
    }
}
