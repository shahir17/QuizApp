//
//  MultiplayerManager.swift
//  QuizApp
//
//  Created by Shahir Abdul-Satar on 4/29/17.
//  Copyright © 2017 Ahmad Shahir Abdul-Satar. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MPCManager: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate {
    
    
    
    
    var session: MCSession!

    var peerID: MCPeerID!
    
    var browser: MCBrowserViewController!
    
    var advertiser: MCAdvertiserAssistant? = nil
    
    
    @IBAction func connect(_ sender: Any) {
        present(browser, animated: true, completion: nil)
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
            }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(peer: peerID)
        self.browser = MCBrowserViewController(serviceType: "quiz", session: session)
        self.advertiser = MCAdvertiserAssistant(serviceType: "quiz", discoveryInfo: nil, session: session)
        
        advertiser?.start()
        session.delegate = self
        browser.delegate = self
        
        //present(browser, animated: true, completion: nil)
        
    }
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
            switch state {
            case MCSessionState.connected:
                print("Connected: \(peerID.displayName)")
            case MCSessionState.connecting:
                print("Connecting: \(peerID.displayName)")
            case MCSessionState.notConnected:
                print("Not Connected: \(peerID.displayName)")
            }
            
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    
    }
        
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    
    
    
    
    
    
    
}
