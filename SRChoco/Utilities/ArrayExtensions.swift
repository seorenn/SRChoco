extension Array {
    func join(seperator: String) -> String {
        var result = ""
        for (idx, item) in enumerate(self) {
            result += "\(item)"
            if idx < self.count - 1 {
                result += seperator
            }
        }
        return result
    }
}