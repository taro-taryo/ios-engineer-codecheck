//
//  LanguageIconProvider.swift
//  iOSEngineerCodeCheck
//
//  Created by taro-taryo on 2024/11/11.
// Copyright © 2024 YUMEMI Inc. All rights reserved.
// Copyright © 2024 taro-taryo. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

struct LanguageIconProvider {
    static func icon(for language: String) -> Image? {
        switch language.lowercased() {
        // Popular Programming Languages
        case "swift":
            return Image(systemName: "swift")
        case "javascript":
            return Image(systemName: "curlybraces.square")
        case "python":
            return Image(systemName: "tortoise")
        case "java":
            return Image(systemName: "cup.and.saucer")
        case "ruby":
            return Image(systemName: "diamond")
        case "php":
            return Image(systemName: "terminal")
        case "c", "c++", "cpp":
            return Image(systemName: "c.circle")
        case "c#", "csharp":
            return Image(systemName: "number.circle")
        case "objective-c":
            return Image(systemName: "c.circle.fill")
        case "go":
            return Image(systemName: "circle.grid.3x3.fill")
        case "kotlin":
            return Image(systemName: "triangle.fill")
        case "rust":
            return Image(systemName: "gear")
        case "dart":
            return Image(systemName: "diamond.righthalf.filled")
        case "scala":
            return Image(systemName: "scalemass")
        case "shell", "bash", "zsh":
            return Image(systemName: "terminal.fill")

        // Scripting and Markup Languages
        case "perl":
            return Image(systemName: "text.cursor")
        case "lua":
            return Image(systemName: "moon.stars.fill")
        case "r":
            return Image(systemName: "chart.bar.fill")
        case "matlab":
            return Image(systemName: "function")
        case "julia":
            return Image(systemName: "cube.box")
        case "haskell":
            return Image(systemName: "arrowshape.zigzag.forward")
        case "clojure":
            return Image(systemName: "atom")
        case "elixir":
            return Image(systemName: "drop.fill")
        case "erlang":
            return Image(systemName: "waveform.path.ecg")
        case "f#", "fsharp":
            return Image(systemName: "f.cursive")
        case "vb", "visual basic", "vba":
            return Image(systemName: "v.circle")
        case "html":
            return Image(systemName: "chevron.left.forwardslash.chevron.right")
        case "css":
            return Image(systemName: "paintbrush.fill")
        case "xml":
            return Image(systemName: "doc.text.fill")
        case "yaml", "yml":
            return Image(systemName: "doc.on.doc.fill")

        // Notebooks and Document Languages
        case "jupyter notebook":
            return Image(systemName: "book.fill")
        case "tex", "latex":
            return Image(systemName: "text.book.closed.fill")
        case "markdown":
            return Image(systemName: "text.alignleft")
        case "rst", "restructuredtext":
            return Image(systemName: "text.alignjustify")

        // Statistical and Scientific Languages
        case "mathematica", "wolfram":
            return Image(systemName: "function")
        case "stata":
            return Image(systemName: "chart.bar")
        case "sas":
            return Image(systemName: "square.grid.3x2")
        case "spss":
            return Image(systemName: "chart.pie.fill")

        // Data Languages
        case "json", "json5", "jsonc":
            return Image(systemName: "doc.plaintext")
        case "csv":
            return Image(systemName: "tablecells")
        case "tsv":
            return Image(systemName: "tablecells.fill")
        case "toml":
            return Image(systemName: "text.append")

        // Query Languages
        case "sql":
            return Image(systemName: "magnifyingglass")
        case "graphql":
            return Image(systemName: "hexagon")

        // Additional Languages
        case "fortran":
            return Image(systemName: "function")
        case "cobol":
            return Image(systemName: "rectangle.split.3x1")
        case "smalltalk":
            return Image(systemName: "rectangle.grid.1x2")
        case "powershell":
            return Image(systemName: "powerplug.fill")
        case "typescript":
            return Image(systemName: "chevron.left.forwardslash.chevron.right")
        case "solidity":
            return Image(systemName: "hexagon.fill")
        case "prolog":
            return Image(systemName: "triangle")
        case "ada":
            return Image(systemName: "circle.grid.hex")
        case "j":
            return Image(systemName: "j.circle")
        case "tcl":
            return Image(systemName: "square.grid.3x3.fill")
        case "racket":
            return Image(systemName: "circle.grid.cross.fill")

        // Default icon for unspecified languages
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
}
