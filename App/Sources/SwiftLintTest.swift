//
//  SwiftLintTest.swift
//  XAuth
//
//  Created by Kompas Digital on 05/01/26.
//

import Foundation

class SwiftLintTest {
    
    // MARK: - 1. Pemicu WARNING (Kuning)
    
    func triggerWarnings() {
        let list = [1, 2, 3]
        
        // Pemicu: opt_in_rules: empty_count
        // SwiftLint akan menyarankan pakai ".isEmpty"
        if list.count == 0 {
            print("List kosong")
        }
        
        // Pemicu: opt_in_rules: force_unwrapping
        // SwiftLint akan melarang penggunaan tanda seru (!)
        let optionalName: String? = "Test"
        let forcedName = optionalName!
        print(forcedName)
        
        // Pemicu: line_length (Warning di atas 140 karakter)
        // Baris di bawah ini panjangnya sekitar 150 karakter, jadi akan jadi Warning kuning.
        let warningString = "Ini adalah kalimat yang sangat panjang sengaja dibuat untuk memicu warning swiftlint karena panjangnya melebihi batas warning 140 karakter yang sudah diset di config."
    }

    // MARK: - 2. Pemicu ERROR (Merah)
    
    func triggerError() {
        // Pemicu: line_length (Error di atas 200 karakter)
        // Baris komentar di bawah ini sangat panjang (> 200 char), jadi akan dianggap ERROR merah dan mungkin menghentikan build jika "Treat Warnings as Errors" aktif.
        
        // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
        // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
        // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
        // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
    }
}
