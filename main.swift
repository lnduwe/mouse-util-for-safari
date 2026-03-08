//
//  main.swift
//  mousef
//
//  Created by orca on 2026/03/08.
//

import Foundation
import CoreGraphics


let kVK_ANSI_LeftBracket: CGKeyCode = 0x21 // '['
let kVK_ANSI_RightBracket: CGKeyCode = 0x1E


func startMouseListener() {

    let eventMask = (1 << CGEventType.otherMouseDown.rawValue)
    
    guard let eventTap = CGEvent.tapCreate(
        tap: .cghidEventTap,
        place: .headInsertEventTap,
        options: .defaultTap,
        eventsOfInterest: CGEventMask(eventMask),
        callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in

            let mouseButton = event.getIntegerValueField(.mouseEventButtonNumber)
            if mouseButton == 4 {
                let cmdDown = CGEvent(keyboardEventSource: nil, virtualKey: kVK_ANSI_RightBracket, keyDown: true)
                cmdDown?.flags = .maskCommand

                let cmdUp = CGEvent(keyboardEventSource: nil, virtualKey: kVK_ANSI_RightBracket, keyDown: false)
                cmdUp?.flags = .maskCommand

                cmdDown?.post(tap: .cgAnnotatedSessionEventTap)
                cmdUp?.post(tap: .cgAnnotatedSessionEventTap)

                return nil
            }

        if mouseButton == 3 {
                let cmdDown = CGEvent(keyboardEventSource: nil, virtualKey: kVK_ANSI_LeftBracket, keyDown: true)
                cmdDown?.flags = .maskCommand

                let cmdUp = CGEvent(keyboardEventSource: nil, virtualKey: kVK_ANSI_LeftBracket, keyDown: false)
                cmdUp?.flags = .maskCommand

                cmdDown?.post(tap: .cgAnnotatedSessionEventTap)
                cmdUp?.post(tap: .cgAnnotatedSessionEventTap)

                return nil
            }
            return Unmanaged.passRetained(event)
        },
        userInfo: nil
    ) else {
        print("Error: check permission.")
        return
    }

    let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
    CGEvent.tapEnable(tap: eventTap, enable: true)
    CFRunLoopRun()
}

startMouseListener()
