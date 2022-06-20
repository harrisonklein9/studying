//
//  DocumentationViewController.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit
import MarkdownView

class DocumentationViewController: EditableViewController {
    
    private lazy var markdownView: MarkdownView = {
        let view = MarkdownView()

        view.load(markdown: markdown)
        return view
    }()
    
    private lazy var markdown: String? = {
        guard let url = Bundle.main.url(forResource: "TopicArchMarkdown", withExtension: "txt"),
              let string = try? String(contentsOf: url)
        else {
            return nil
        }
        return string
    }()

    override func viewDidLoad() {
        view.addSubview(markdownView)
        title = "Topic Architecture"
        markdownView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        view.backgroundColor = .black
        super.viewDidLoad()
    }
    
    override func togglePencil() {
        if state == .hidden {
            markdownView.isScrollEnabled = false
            markdownView.isUserInteractionEnabled = false
            markdownView.resignFirstResponder()
        } else {
            markdownView.isScrollEnabled = true
            markdownView.isUserInteractionEnabled = true
            markdownView.becomeFirstResponder()
        }
        super.togglePencil()
        
    }

}
