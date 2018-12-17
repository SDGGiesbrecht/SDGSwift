/*
 Resources.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal enum Resources {}

extension Resources {
    static let syntaxHighlighting = String(data: Data(base64Encoded: "LyoKIFN5bnRheCBIaWdobGlnaHRpbmcuY3NzCgogVGhpcyBzb3VyY2UgZmlsZSBpcyBwYXJ0IG9mIHRoZSBTREdTd2lmdCBvcGVuIHNvdXJjZSBwcm9qZWN0LgogaHR0cHM6Ly9zZGdnaWVzYnJlY2h0LmdpdGh1Yi5pby9TREdTd2lmdAoKIENvcHlyaWdodCDCqTIwMTggSmVyZW15IERhdmlkIEdpZXNicmVjaHQgYW5kIHRoZSBTREdTd2lmdCBwcm9qZWN0IGNvbnRyaWJ1dG9ycy4KCiBTb2xpIERlbyBnbG9yaWEuCgogTGljZW5zZWQgdW5kZXIgdGhlIEFwYWNoZSBMaWNlbmNlLCBWZXJzaW9uIDIuMC4KIFNlZSBodHRwOi8vd3d3LmFwYWNoZS5vcmcvbGljZW5zZXMvTElDRU5TRS0yLjAgZm9yIGxpY2VuY2UgaW5mb3JtYXRpb24uCiAqLwoKLyogTGF5b3V0ICovCgouc3dpZnQgewogICAgZGlzcGxheTogaW5saW5lOwogICAgd2hpdGUtc3BhY2U6IHByZS13cmFwOwp9Ci5zd2lmdC5ibG9ja3F1b3RlIHsKICAgIGRpc3BsYXk6IGJsb2NrOwogICAgbWFyZ2luOiAxLjRlbSAwOwogICAgYm9yZGVyOiAxcHggc29saWQ7CiAgICAgYm9yZGVyLXJhZGl1czogMC4zNTI5NGVtOwogICAgcGFkZGluZzogMC4zNTI5NGVtIDAuOTQxMThlbTsKfQoKLyogQ29sb3VyICovCgouc3dpZnQuYmxvY2txdW90ZSB7CiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjRjlGQUZBOwogICAgYm9yZGVyLWNvbG9yOiAgI0U2RTZFNjsKfQouc3dpZnQgewogICAgY29sb3I6ICMwMDAwMDA7Cn0KCi5zd2lmdCAua2V5d29yZCB7CiAgICBjb2xvcjogI0FBMEQ5MTsKfQoKLnN3aWZ0IC5wdW5jdHVhdGlvbiB7CiAgICBjb2xvcjogIzAwMDAwMDsKfQoKLnN3aWZ0IC5leHRlcm5hbC5pZGVudGlmaWVyIHsKICAgIGNvbG9yOiAjNUMyNjk5Owp9Ci5zd2lmdCAuaW50ZXJuYWwuaWRlbnRpZmllciB7CiAgICBjb2xvcjogIzNGNkU3NDsKfQoKLnN3aWZ0IC5udW1iZXIgewogICAgY29sb3I6ICMwRTBFRkY7Cn0KCi5zd2lmdCAuc3RyaW5nIHsKICAgIGNvbG9yOiAjQzQxQTE2Owp9Ci5zd2lmdCAuc3RyaW5n4oCQcHVuY3R1YXRpb24gewogICAgY29sb3I6ICM2MjI3MEI7Cn0KCi5zd2lmdCAuY29tcGlsYXRpb27igJBjb25kaXRpb24gewogICAgY29sb3I6ICM2NDM4MjA7Cn0KCi5zd2lmdCAuY29tbWVudCB7CiAgICBjb2xvcjogIzAwNzQwMDsKfQouc3dpZnQgLmNvbW1lbnTigJBwdW5jdHVhdGlvbiB7CiAgICBjb2xvcjogIzAwM0EwMDsKfQouc3dpZnQgLnVybCB7CiAgICBjb2xvcjogIzBFMEVGRjsKfQoKLnN3aWZ0IC5jb2RlIHsKICAgIGNvbG9yOiAjMDAwMDAwOwp9CgovKiBGb250ICovCgouc3dpZnQgewogICAgZm9udC1mYW1pbHk6ICJTRiBNb25vIiwgTWVubG8sIG1vbm9zcGFjZSwgIlNGIFBybyBJY29ucyI7CiAgICBsZXR0ZXItc3BhY2luZzogLTAuMDI3ZW07CiAgICBsaW5lLWhlaWdodDogMS4yNjY2NzsKfQoKLnN3aWZ0IC50ZXh0IHsKICAgIGZvbnQtZmFtaWx5OiAiU0YgUHJvIFRleHQiLCAiU0YgUHJvIEljb25zIiwgIi1hcHBsZS1zeXN0ZW0iLCAiQmxpbmtNYWNTeXN0ZW1Gb250IiwgIkhlbHZldGljYSBOZXVlIiwgIkhlbHZldGljYSIsICJBcmlhbCIsIHNhbnMtc2VyaWY7CiAgICBsZXR0ZXItc3BhY2luZzogMDsKfQoKLnN3aWZ0IC5jb21tZW504oCQa2V5d29yZCB7CiAgICBmb250LXdlaWdodDogYm9sZDsKfQoKLnN3aWZ0IC51cmw6bGluaywgLnN3aWZ0IC51cmw6dmlzaXRlZCB7CiAgICB0ZXh0LWRlY29yYXRpb246IG5vbmU7Cn0KLnN3aWZ0IC51cmw6aG92ZXIgewogICAgdGV4dC1kZWNvcmF0aW9uOiB1bmRlcmxpbmU7Cn0K")!, encoding: String.Encoding.utf8)!

}
