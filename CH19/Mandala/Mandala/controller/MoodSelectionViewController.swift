//
//  ViewController.swift
//  Mandala
//
//  Created by Atheer abdullah on 04/05/1443 AH.
//

import UIKit

class MoodSelectionViewController: UIViewController {
  
  
  @IBOutlet var moodSelector: ImageSelector!
   
  @IBOutlet var addMoodButten: UIButton!
  
  
  var moods: [Mood] = [] {
    didSet {
      currentMood = moods.first
      moodSelector.images = moods.map { $0.image }
      moodSelector.highlightColors = moods.map { $0.color }
    }
    }
  
  var moodsConfigurable: MoodsConfigurable!
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "embedContainerViewController":
      guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
        preconditionFailure(
          "View controller expected to conform to MoodsConfigurable")
      }
      self.moodsConfigurable = moodsConfigurable
      segue.destination.additionalSafeAreaInsets =
        UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
    default:
      preconditionFailure("Unexpected segue identifier")
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
    addMoodButten.layer.cornerRadius = addMoodButten.bounds.height / 2
    
  }
  
  var currentMood: Mood? {
    didSet {
      guard let currentMood = currentMood else {
        addMoodButten?.setTitle(nil, for: .normal)
        addMoodButten?.backgroundColor = nil
        return
      }
      
      addMoodButten?.setTitle("I'm \(currentMood.name)", for: .normal)
      let selectionAnimator = UIViewPropertyAnimator(duration: 0.3,
                                                           dampingRatio: 0.7) {
                self.addMoodButten?.backgroundColor = currentMood.color
            }
            selectionAnimator.startAnimation()
    }
      
    }
  
  
  
  
  
  @IBAction func moodSelectionChanged(_ sender: ImageSelector) {
    let selectedIndex = sender.selectedIndex
    currentMood = moods[selectedIndex]
  }

  @IBAction func addMoodTapped(_ sender: Any) {
  
  
      guard let currentMood = currentMood else {
  return }
      let newMoodEntry = MoodEntry(mood: currentMood, timestamp:  Date())
      moodsConfigurable.add(newMoodEntry)
  }
}
