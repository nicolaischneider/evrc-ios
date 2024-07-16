import SwiftUI

struct RichText: View {
    
    struct Element: Identifiable {
        let id = UUID()
        let content: String
        let isBold: Bool
        
        init(content: String, isBold: Bool) {
            var newContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if isBold {
                newContent = content.replacingOccurrences(of: "*", with: "")
            }
            
            self.content = newContent
            self.isBold = isBold
        }
    }
    
    let elements: [Element]
    
    let fontBold: Font
    let fontRegular: Font
    let underlined: Bool
    
    init(_ content: String, fontBold: Font, fontRegular: Font, isUnderlined: Bool = false) {
        elements = content.parseRichTextElements()
        self.fontBold = fontBold
        self.fontRegular = fontRegular
        self.underlined = isUnderlined
    }
    
    var body: some View {
        // swiftlint:disable force_unwrapping
        var content = text(for: elements.first!)
        // swiftlint:enable force_unwrapping
        elements.dropFirst().forEach { (element) in
            // swiftlint: disable shorthand_operator
            content = content + self.text(for: element)
            // swiftlint: enable shorthand_operator
        }
        
        return content
    }
    
    private func text(for element: Element) -> Text {
        let postfix = shouldAddSpace(for: element) ? " " : ""
        if element.isBold {
            if underlined {
                return Text(element.content + postfix)
                    .font(self.fontBold)
                    .underline()
            } else {
                return Text(element.content + postfix)
                    .font(self.fontBold)
            }
        } else {
            if underlined {
                return Text(element.content + postfix)
                    .font(self.fontRegular)
                    .underline()
            } else {
                return Text(element.content + postfix)
                    .font(self.fontRegular)
            }
        }
    }
    
    private func shouldAddSpace(for element: Element) -> Bool {
        return element.id != elements.last?.id
    }
}

extension String {

    /// Parses the input text and returns a collection of rich text elements.
    /// Currently supports asterisks only. E.g. "Save *everything* that *inspires* your ideas".
    ///
    /// - Returns: A collection of rich text elements.
    func parseRichTextElements() -> [RichText.Element] {
        
        guard let regex = try? NSRegularExpression(pattern: "\\*{1}(.*?)\\*{1}") else {
            return [RichText.Element(content: self, isBold: false)]
        }
        
        let range = NSRange(location: 0, length: count)

        /// Find all the ranges that match the regex *CONTENT*.
        let matches: [NSTextCheckingResult] = regex.matches(in: self, options: [], range: range)
        let matchingRanges = matches.compactMap { Range<Int>($0.range) }

        var elements: [RichText.Element] = []

        // Add the first range which might be the complete content if no match was found.
        // This is the range up until the lowerbound of the first match.
        let firstRange = 0..<(matchingRanges.isEmpty ? count : matchingRanges[0].lowerBound)

        self[firstRange].components(separatedBy: " ").forEach { (word) in
            guard !word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
            elements.append(RichText.Element(content: String(word), isBold: false))
        }

        // Create elements for the remaining words and ranges.
        for (index, matchingRange) in matchingRanges.enumerated() {
            let isLast = matchingRange == matchingRanges.last

            // Add an element for the matching range which should be bold.
            let matchContent = self[matchingRange]
            elements.append(RichText.Element(content: matchContent, isBold: true))

            // Add an element for the text in-between the current match and the next match.
            let endLocation = isLast ? count : matchingRanges[index + 1].lowerBound
            let range = matchingRange.upperBound..<endLocation
            self[range].components(separatedBy: " ").forEach { (word) in
                guard !word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                elements.append(RichText.Element(content: String(word), isBold: false))
            }
        }

        return elements
    }

    /// - Returns: A string subscript based on the given range.
    subscript(range: Range<Int>) -> String {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

// MARK: - Previews

#Preview {
    RichText("*This is* a test.", fontBold: .title3.bold(), fontRegular: .body, isUnderlined: false)
}
